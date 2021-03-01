package com.kdis.demo.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.demo.service.LoginService;
import com.kdis.demo.service.MemberService;
import com.kdis.demo.vo.UserVo;

import prjc.baechan.common.SHA256Util;

@Controller
@RequestMapping("/login/*")
public class LoginController{
	 
	 @Inject
	 private LoginService LoginService;
	 
	 @Inject
	 private MemberService MemberService;
	 
	 @Autowired
	 private JavaMailSender mailSender; 
	 
	 @RequestMapping(value = "/login")
	 public String login() throws Exception {
		 return "/login/login";
	 }
	 
	 @RequestMapping(value = "/join")
	 public String join() throws Exception {
		 return "/login/join";
	 }
	 
	 @RequestMapping(value = "/idSearchPopup")
	 public String idSearch() throws Exception {
		 return "/login/idSearchPopup";
	 }
	 
	 @RequestMapping(value = "/pwdSearchPopup")
	 public String pwdSearch() throws Exception {
		 return "/login/pwdSearchPopup";
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
		 loginChk = LoginService.loginSubmit(paramMap);
		 UserVo userVO = MemberService.selectMyInfo(paramMap);
		 
		 // 회원 로그인 실패 횟수 가져와서 로그인 할 수 있는 상태인지 판별
		 Integer loginFailCount = userVO.getLoginFailCount();
		 int updateLoginCntChk = 0;
		 int updateUserStateChk = 0;
		 
		 // 로그인 계정 체크 성공 시
		 if(loginChk == 1) {
			 loginFailCount = 0;
			 paramMap.put("loginFailCount", loginFailCount);
			 paramMap.put("grade", "1");
			 paramMap.put("userState", "1");
			 
			 // 로그인 실패 횟수 초기화 및 회원 상태 초기화
		 	 updateLoginCntChk = LoginService.updateLoginFailCount(paramMap);
			 updateUserStateChk = MemberService.updateUserState(paramMap);

			 // 위의 메서드들 처리 완료 확인 후 session 생성
		 	 if(updateLoginCntChk == 1 && updateUserStateChk == 1) {
		 		 HttpSession session = request.getSession(true);
				 
				 session.setAttribute("sessionId", userVO.getUserId());
				 session.setAttribute("sessionUserNm", userVO.getUserNm());
				 session.setAttribute("sessionLoginChk", "user");
				 
				 result = "success";
		 	 }else {
		 		 // 로그인실패횟수초기화 오류 에러페이지 호출
				 result = "error";
		 	 }
		 // 로그인 계정 체크 실패 시
		 }else{
			 String state = userVO.getUserState();
			 // 회원 등급 1 : 일반 사용자이면 로그인 실패 횟수 증가
			 if("1".equals(state)) {
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
		 model.addAttribute("submit","logout");
		 return "/common/result";
	 }
	 
	 // 아이디 중복 체크 ajax로 처리
	 @ResponseBody
	 @RequestMapping(value="/idCheckAjax")
	 public Map<String,String> idCheckAjax(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		 Map<String,String> resultMap = new HashMap<String,String>();
		 int check = 0;
		 String result = "";
		 
		 String userId = request.getParameter("userId");
		 check = LoginService.idCheck(userId);
		 if(check == 1) {
			 result = "N";
		 }else if(check == 0) {
			 result = "Y";
		 }
		 
		 resultMap.put("result", result);
		 return resultMap;
	 }
	 
	 // 회원가입 처리
	 @RequestMapping(value = "/joinSubmit")
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
		 paramMap.put("grade", '1');
		 paramMap.put("userState", '1');
		 paramMap.put("loginFailCount", '0');
		 
		 int result = 0;
		 result = LoginService.userJoin(paramMap);
		 
		 if(result == 1) {
			 model.addAttribute("result", "Y");
		 }else if(result == 0) {
			 model.addAttribute("result", "N");
		 }
		 
		 model.addAttribute("submit", "join");
		 return "/common/result";
	 }
	 
	 // 아이디 찾기 - 회원이름,핸드폰번호 비교하여 해당하는 계정 return
	 @ResponseBody
	 @RequestMapping("/idSearch")
	 public Map<String,String> idSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();
		 Map<String,String> resultMap = new HashMap<String,String>();
		 
		 String userNm = request.getParameter("userNm");
		 String phoneNumber = request.getParameter("phoneNumber");

		 paramMap.put("userNm",userNm);
		 paramMap.put("phoneNumber", phoneNumber);
		 
		 String userId = "";
		 userId = LoginService.searchIdChk(paramMap);

		 // id 가져올때 뒷 4 자리 별표 처리
		 if(!"".equals(userId) && userId != null) {
			 userId = userId.substring(0, userId.length()-4) + "****";
			 
			 resultMap.put("userId", userId);
			 resultMap.put("result", "success");
		 }else {
			 resultMap.put("result", "fail");
		 }
		 
		 return resultMap;
	 }
	 
	 // 비밀번호 찾기 - 회원이름,핸드폰번호,이메일 비교하여 해당 계정 이메일로 임시비밀번호 발급
	 @ResponseBody
	 @RequestMapping("/pwdSearch")
	 public Map<String,String> pwdSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();
		 Map<String,String> resultMap = new HashMap<String,String>();
		 
		 String userNm = request.getParameter("userNm");
		 String phoneNumber = request.getParameter("phoneNumber");
		 String email = request.getParameter("email");

		 paramMap.put("userNm",userNm);
		 paramMap.put("phoneNumber", phoneNumber);
		 paramMap.put("email", email);
		 
		 String userId = "";
		 String password = "";
		 String userSalt = "";
		 
		 userId = LoginService.searchPwdChk(paramMap);
		 userSalt = LoginService.getUserSalt(userId);
		 
		 paramMap.put("userId", userId);
		 paramMap.put("salt", userSalt);
				 
		 if(!"".equals(userId) && userId != null) {		
			//임시비밀번호 생성
			 password = getRandomPassword();
			 
			 // 임시비밀번호 회원정보에 등록
			 paramMap.put("password", SHA256Util.encrypt(password,userSalt));
			 int tmpPassword = 0;
			 tmpPassword = MemberService.updatePwd(paramMap);
			 
			 if(tmpPassword == 1) {
				// 이메일 발송 메서드
				 int mailSendChk = 0;
				 mailSendChk = mailSend(password);
				 
				 if(mailSendChk == 1) {
					 resultMap.put("result", "success");
				 }else {
					 //TODO : 기존 비밀번호로 되돌려야
				 }
			 }else {
				 resultMap.put("result", "error");
			 }
		 }else {
			 resultMap.put("result", "fail");
		 }
		 
		 
		 
		 return resultMap;
	 }
	 
	 // 임시비밀번호 생성
	 public static String getRandomPassword() { 
		 char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
				 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }; 
		 
		 char[] charSetSpecial = new char[] {'!', '@', '#', '$', '%', '^', '&' };
		 
		 int idx = 0; 
		 StringBuffer sb = new StringBuffer(); 
		 
		 // 4자리는 숫자,영문 소문자 나온 후 1자리는 특수문자 로 반복 하여 총 15자리
		 for (int i = 0; i < 3; i++) { 
			 for( int j = 0; j < 4; j ++) {
				 idx = (int) (charSet.length * Math.random()); 
				 sb.append(charSet[idx]); 
			 }
			 idx = (int) (charSetSpecial.length * Math.random());
			 	sb.append(charSetSpecial[idx]);
		 } 
		 return sb.toString(); 
	 }

	 // 비밀번호 찾기 시 메일발송 처리 
	 public int mailSend(String password) throws Exception{
		 	String subject = "MovieBox에서 회원님의 임시비밀번호를 보내드립니다.";
	        String content = "MovieBox 임시비밀번호 : " + password;
	        String from = "baechantest@naver.com";
	        String to = "asdfjklddd@naver.com";

	        try {
	            MimeMessage mail = mailSender.createMimeMessage();
	            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
	            // true는 멀티파트 메세지를 사용하겠다는 의미
	            
	            /*
	             * 단순한 텍스트 메세지만 사용시엔 아래의 코드도 사용 가능 
	             * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
	             */
	            mailHelper.setFrom(from);
	            // 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
	            // 보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용하시면 됩니다.
	            //mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
	            mailHelper.setTo(to);
	            mailHelper.setSubject(subject);
	            mailHelper.setText(content, true);
	            // true는 html을 사용하겠다는 의미입니다.
	            
	            /*
	             * 단순한 텍스트만 사용하신다면 다음의 코드를 사용하셔도 됩니다. mailHelper.setText(content);
	             */
	            
	            mailSender.send(mail);
	            return 1;
	        } catch(Exception e) {
	            e.printStackTrace();
	            return 0;
	        }
			
		 
		 
	 }
	 
}