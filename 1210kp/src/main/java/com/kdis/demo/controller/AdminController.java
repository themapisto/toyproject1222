package com.kdis.demo.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

import com.kdis.demo.service.LoginService;
import com.kdis.demo.service.MemberService;
import com.kdis.demo.vo.PaginationDto;
import com.kdis.demo.vo.UserVo;

import prjc.baechan.common.SHA256Util;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Inject
	private LoginService LoginService;
	
	@Inject
	private MemberService MemberService;
	
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
		UserVo userVO = MemberService.selectMyInfo(paramMap);
		 
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
	
	// 유저 리스트 
	@RequestMapping(value = "userList")
	public String showAllUser(PaginationDto dto, ModelMap model, 
			HttpServletRequest request,HttpServletResponse response) throws Exception {

		dto.setTotal(MemberService.countTotal(dto));
		List<UserVo> userList = MemberService.showAllUser(dto);
		model.addAttribute("pageDto", dto);
		model.addAttribute("userList",userList);
		return "/admin/userList";
	}
	
	// 회원 상태변경
	@RequestMapping(value = "/modifyState", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> modifyState(UserVo user, ModelMap model, 
			HttpServletRequest request,HttpServletResponse response) throws Exception {

		HashMap<String, String> result = new HashMap <String,String>();
		int modifyRst = MemberService.modifyState(user);
		
		if ( modifyRst > 0) {
			String Msg = "수정되었습니다";
			String Code = "0";
			
			result.put("Msg", Msg);
			result.put("Code", Code);
			
		} else {
			String Msg = "잠시 후 다시 시도해주세요";
			String Code = "1";
			
			result.put("Msg", Msg);
			result.put("Code", Code);
		}
		return result;
	}
	
	@RequestMapping(value = "lockingDate", method = RequestMethod.POST)
	public String lockingDate(PaginationDto dto, ModelMap model, 
			HttpServletRequest request,HttpServletResponse response) throws Exception {
		System.out.println(dto.getEndDate());
		dto.setTotal(MemberService.countTotal(dto));
		List<UserVo> userList = MemberService.showAllUser(dto);
		model.addAttribute("pageDto", dto);
		model.addAttribute("userList",userList);
		return "/admin/userList";
	}
	
	// 관리자 리스트 
	@RequestMapping(value = "adminList")
	public String showAllAdmin(PaginationDto dto, ModelMap model, 
			HttpServletRequest request,HttpServletResponse response) throws Exception {

		dto.setTotal(MemberService.countAdmin(dto));
		List<UserVo> userList = MemberService.showAllAdmin(dto);
		model.addAttribute("pageDto", dto);
		model.addAttribute("userList",userList);
		return "/admin/adminList";
	}
	
	// 관리자 추가양식 
	@RequestMapping(value = "/join")
	public String join() throws Exception {
		return "/admin/join";
	}
	
	// 회원가입 처리
	@RequestMapping(value = "/adminJoinSubmit")
	public String joinSubmit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();

		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String userNm = request.getParameter("userNm");
		String birthday = request.getParameter("birthday");
		String email = request.getParameter("email");
		String phoneNumber = request.getParameter("phoneNumber");

		String salt = SHA256Util.getNewSalt();

		paramMap.put("userId", userId);
		paramMap.put("userNm", userNm);
		paramMap.put("password", SHA256Util.encrypt(password,salt));
		paramMap.put("salt", salt);
		paramMap.put("birthday", birthday);
		paramMap.put("phoneNumber", phoneNumber);
		paramMap.put("email", email);
		paramMap.put("grade", '5');
		paramMap.put("userState", '1');
		paramMap.put("loginFailCount", '0');

		int result = 0;
		result = LoginService.userJoin(paramMap);

		if(result == 1) {
			model.addAttribute("result", "Y");
		}else if(result == 0) {
			model.addAttribute("result", "N");
		}

		model.addAttribute("submit", "adminJoin");
		return "/common/result";
	}
	
	// 관리자 삭제 
	@RequestMapping(value = "/deleteAdmin", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> deleteAdmin(UserVo user, ModelMap model, 
			HttpServletRequest request,HttpServletResponse response) throws Exception {

		HashMap<String, String> result = new HashMap <String,String>();
		int deleteRst = MemberService.deleteAdmin(user);

		if ( deleteRst > 0) {
			String Msg = "삭제되었습니다";
			result.put("Msg", Msg);

		} else {
			String Msg = "잠시 후 다시 시도해주세요";

			result.put("Msg", Msg);
		}
		return result;
	}
}
