package prjc.baechan.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import prjc.baechan.common.CouponDTO;
import prjc.baechan.common.CouponVO;
import prjc.baechan.common.SHA256Util;
import prjc.baechan.common.UserVO;
import prjc.baechan.login.LoginService;
import prjc.baechan.member.MemberService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Inject
	private LoginService LoginService;
	 
	@Inject
	private MemberService MemberService;
	
	@Inject
	private AdminService AdminService;
	// 관리자 로그인 페이지
	@RequestMapping(value = "/login")
	public String adminLogin() throws Exception {
		return "/admin/login";
	}
	
	// 관리자 페이지 홈
	@RequestMapping(value = "/home")
	public String adminPage() throws Exception {
		return "/admin/home";
	}
	
	// 로그인 기능 처리
	@RequestMapping(value = "/loginSubmit")
	@ResponseBody
	public Map<String, String> loginSubmit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		Map<String,String> resultMap = new HashMap<String,String>();

		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		 
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 
		String loginAvailableTime = "";
		Date loginFailTime = null;

		// 회원가입 할 때 등록된 salt를 가져옴
		String salt = LoginService.getUserSalt(userId);

		paramMap.put("userId", userId);
		paramMap.put("password", SHA256Util.encrypt(password,salt));
 
		int loginChk = 0;
		String result = "";
		 
		// 로그인 계정 체크 후 회원정보 가져오기
		loginChk = LoginService.adminLoginSubmit(paramMap);
		UserVO userVO = MemberService.selectMyInfo(paramMap);
		 
		// 회원 로그인 실패 횟수 가져와서 로그인 할 수 있는 상태인지 판별
		Integer loginFailCount = userVO.getLoginFailCount();
		int updateLoginCntChk = 0;
		int updateUserStateChk = 0;
		 
		// 로그인 계정 체크 성공 시
		if(loginChk == 1) {
			loginFailCount = 0;
			paramMap.put("loginFailCount", loginFailCount);
			paramMap.put("userState", "1");
		 
			// 로그인 실패 횟수 초기화 및 회원 상태 초기화
			updateLoginCntChk = LoginService.updateLoginFailCount(paramMap);
			updateUserStateChk = MemberService.updateUserState(paramMap);
			// 위의 메서드들 처리 완료 확인 후 session 생성
		 	if(updateLoginCntChk == 1 && updateUserStateChk == 1) {
		 		HttpSession session = request.getSession(true);
				 
				session.setAttribute("sessionId", userVO.getUserId());
				session.setAttribute("sessionUserNm", userVO.getUserNm());
				session.setAttribute("sessionLoginChk", "admin");
				 
				result = "success";
		 	}else {
		 		// 로그인실패횟수초기화 오류 에러페이지 호출
				result = "error";
		 	}
		// 로그인 계정 체크 실패 시
		}else{
			String grade = userVO.getGrade();
			String state = userVO.getUserState();
			// 회원 등급 5 : 관리자면 로그인 실패 횟수 증가
			if("5".equals(grade)) {
				loginFailCount++;
				// 로그인 실패 횟수 5회 미만 시 로그인 실패 횟수 update
				if(loginFailCount < 5) {
					 
					paramMap.put("loginFailCount", loginFailCount);
					updateLoginCntChk = LoginService.updateLoginFailCount(paramMap);
					 
					if(updateLoginCntChk == 1) {
						result = loginFailCount.toString();
					}else {
						// 로그인실패횟수증감오류 에러페이지 호출
						result = "error";
					}
				}else if(loginFailCount == 5){
					 
					paramMap.put("loginFailCount", loginFailCount);
					updateLoginCntChk = LoginService.updateLoginFailCount(paramMap);
					int updateLoginFailTimeResult = 0; 
					// 로그인 5회 실패 후 계정 잠금 시간 insert
					try {
						updateLoginFailTimeResult = LoginService.insertLoginHistory(paramMap);
					}catch(Exception e){
						e.printStackTrace();
						throw e;
					}
					paramMap.put("userState","8");
					updateUserStateChk = MemberService.updateUserState(paramMap);
					 
					if(updateUserStateChk == 1 && updateLoginCntChk == 1 && updateLoginFailTimeResult == 1) {
						 
						// 계정 잠금 시 로그인 실패 시간 가져와서 30분 후에 로그인 가능 시간 return 
						userVO = MemberService.selectMyInfo(paramMap);
						loginFailTime = dateFormat.parse(dateFormat.format(userVO.getLoginFailTime())); 
						cal.setTime(loginFailTime);
						cal.add(Calendar.MINUTE, 30);
						loginAvailableTime = dateFormat.format(cal.getTime());
						 
						resultMap.put("loginFailTime",loginAvailableTime);

						result = "loginFailLocked";
					}else {
						// 계정잠금오류 에러페이지 호출
						result = "error";
					}
				}else {
					// 계정 잠금 시 로그인 실패 시간 가져와서 30분 후에 로그인 가능 시간 return 
					userVO = MemberService.selectMyInfo(paramMap);
					loginFailTime = dateFormat.parse(dateFormat.format(userVO.getLoginFailTime())); 
					cal.setTime(loginFailTime);
					cal.add(Calendar.MINUTE, 30);
					loginAvailableTime = dateFormat.format(cal.getTime());
					 
					resultMap.put("loginFailTime",loginAvailableTime);
					 
					result = "locked";
				}
			}else if("9".equals(state)){
				result = "userWithdrawal";
			}else if(!"5".equals(grade)) {
				result = "notAdmin";
			}else{
				 
				// 계정 잠금 시 로그인 실패 시간 가져와서 30분 후에 로그인 가능 시간 return 
				userVO = MemberService.selectMyInfo(paramMap);
				loginFailTime = dateFormat.parse(dateFormat.format(userVO.getLoginFailTime())); 
				cal.setTime(loginFailTime);
				cal.add(Calendar.MINUTE, 30);
				loginAvailableTime = dateFormat.format(cal.getTime());
				 
				resultMap.put("loginFailTime",loginAvailableTime);
				 
				result = "locked";

			}
		}
		resultMap.put("result", result);
		return resultMap;
	}
	
	// 로그아웃 처리
	@RequestMapping(value="/logout")
	public String logout(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {

		 HttpSession session = request.getSession(true);
		 session.invalidate();
		 
		 model.addAttribute("result", "Y");
		 model.addAttribute("submit","adminLogout");
		 return "/common/result";
	}
	
	// 관리자 쿠폰 관리 리스트
	@RequestMapping(value="/couponList")
	public String asyncBBS(CouponDTO param, ModelMap model) throws Exception {
		
		ArrayList<CouponVO> couponList = AdminService.couponList(param);
		
		model.addAttribute("couponList",couponList);
		
		return "/admin/couponList";
	}
	
	// 쿠폰 등록가능여부변경
	@RequestMapping(value="/couponUpdtRgstChkAjax")
	@ResponseBody
	public Map<String,Object> couponUpdtRgstChkAjax(CouponDTO param, ModelMap model) throws Exception {
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		String result = "N";
		
		String couponId = param.getCouponId();
		couponId = couponId.substring(0,couponId.length()-1);
		String[] couponIdArr = couponId.split(",");

		int updateResult = 0;
		
		updateResult = AdminService.couponUpdtRgstChk(couponIdArr); 

		if(updateResult != 0) {
			result = "Y";
		}
		
		resultMap.put("result", result);
		return resultMap;
	}
	
	// 쿠폰 삭제하기 ( delete x update o )
	@RequestMapping(value="/couponDeleteAjax")
	@ResponseBody
	public Map<String,Object> couponDeleteAjax(CouponDTO param, ModelMap model) throws Exception {
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		String result = "N";
		
		String couponId = param.getCouponId();
		couponId = couponId.substring(0,couponId.length()-1);
		String[] couponIdArr = couponId.split(",");

		int updateResult = 0;
		
		updateResult = AdminService.couponDeleteAjax(couponIdArr); 

		if(updateResult != 0) {
			result = "Y";
		}
		
		resultMap.put("result", result);
		return resultMap;
	}
	
	// coupon 정보 수정페이지
	@RequestMapping(value="/updateCoupon" , method=RequestMethod.GET)
	public String updateCoupon(CouponDTO param, ModelMap model) throws Exception {
		CouponVO couponList = AdminService.updateCouponView(param);
		model.addAttribute("couponList",couponList);
		return "/admin/updateCoupon";
	}
	
	// 쿠폰 수정하기 
	@RequestMapping(value="/couponUpdateAjax")
	@ResponseBody
	public Map<String,Object> couponUpdateAjax(CouponDTO param, ModelMap model) throws Exception {
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		String result = "N";

		int updateResult = 0;
		
		updateResult = AdminService.couponUpdateAjax(param); 

		if(updateResult != 0) {
			result = "Y";
		}
		
		resultMap.put("result", result);
		return resultMap;
	}
	
	// coupon 생성페이지
	@RequestMapping(value="/makeCoupon")
	public String makeCoupon() throws Exception {
		return "/admin/makeCoupon";
	}
	
	// 쿠폰 생성하기 
	@RequestMapping(value="/couponMakeAjax")
	@ResponseBody
	public Map<String,Object> couponMakeAjax(CouponDTO param, ModelMap model) throws Exception {
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		String result = "N";

		int insertResult = 0;
		
		insertResult = AdminService.couponMakeAjax(param); 

		if(insertResult != 0) {
			result = "Y";
		}
		
		resultMap.put("result", result);
		return resultMap;
	}
	
	
}
