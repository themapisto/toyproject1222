package com.kdis.demo.controller;

import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.demo.service.LoginService;
import com.kdis.demo.service.MemberService;
import com.kdis.demo.vo.UserVO;

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
}
