package prjc.baechan.login;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.demo.MemberService;
import com.kdis.demo.SHA256Util;
import com.kdis.demo.UserVO;

@Controller
@RequestMapping("/login/*")
public class LoginController{
	 
	 @Inject
	 private LoginService LoginService;
	 
	 @Inject
	 private MemberService MemberService;
	 
	 @Resource(name="mailSender")
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
	 
	 @RequestMapping(value = "/loginSubmit")
	 @ResponseBody
	 public Map<String, String> loginSubmit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();
		 Map<String,String> resultMap = new HashMap<String,String>();

		 String userId = request.getParameter("userId");
		 String password = request.getParameter("password");

		 String salt = LoginService.getUserSalt(userId);

		 paramMap.put("userId", userId);
		 paramMap.put("password", SHA256Util.encrypt(password,salt));
 
		 int loginChk = 0;
		 String result = "";
		 
		 loginChk = LoginService.loginSubmit(paramMap);
		 UserVO userVO = MemberService.selectMyInfo(paramMap);
		 
		 Integer loginFailCount = userVO.getLoginFailCount();
		 int updateLoginCntChk = 0;
		 int updateUserStateChk = 0;
		 
		 if(loginChk == 1) {
			 loginFailCount = 0;
			 paramMap.put("loginFailCount", loginFailCount);
			 paramMap.put("userState", "1");
		 	 updateLoginCntChk = LoginService.updateLoginFailCount(paramMap);
			 updateUserStateChk = MemberService.updateUserState(paramMap);

		 	 if(updateLoginCntChk == 1 && updateUserStateChk == 1) {
		 		 HttpSession session = request.getSession(true);
				 
				 session.setAttribute("sessionId", userVO.getUserId());
				 session.setAttribute("sessionUserNm", userVO.getUserNm());
				 session.setAttribute("sessionLoginChk", "Y");
				 
				 result = "success";
		 	 }else {
		 		 // 로그인실패횟수초기화 오류 에러페이지 호출
				 result = "-1";
		 	 }
			 
		 }else{
			 String state = userVO.getUserState();
			 if("1".equals(state)) {
				 loginFailCount++;

				 if(loginFailCount < 5) {
					 
					 paramMap.put("loginFailCount", loginFailCount);
					 updateLoginCntChk = LoginService.updateLoginFailCount(paramMap);
					 
					 if(updateLoginCntChk == 1) {
						 result = loginFailCount.toString();
					 }else {
						 // 로그인실패횟수증감오류 에러페이지 호출
						 result = "-1";
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
						 result = "5";
					 }else {
						// 계정잠금오류 에러페이지 호출
						 result = "-1";
					 }
				 }else {
					 result = "0";
				 }
			 }else {
				 result = "0";
			 }
		 }
		 
		 
		
		 resultMap.put("result", result);
		 return resultMap;
	 }
	 
	 @RequestMapping(value="/logout")
	 public String logout(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {

		 HttpSession session = request.getSession(true);
		 session.invalidate();
		 
		 model.addAttribute("result", "Y");
		 model.addAttribute("submit","logout");
		 return "/common/result";
	 }
	 
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
		 userId = LoginService.getUserId(paramMap);

		 if(!"".equals(userId) && userId != null) {
			 userId = userId.substring(0, userId.length()-4) + "****";
			 
			 resultMap.put("userId", userId);
			 resultMap.put("result", "success");
		 }else {
			 resultMap.put("result", "fail");
		 }
		 
		 return resultMap;
	 }
	 
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
		 
		 userId = LoginService.getUserId(paramMap);
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
	 
	 public static String getRandomPassword() { 
		 char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
				 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }; 
		 
		 char[] charSetSpecial = new char[] {'!', '@', '#', '$', '%', '^', '&' };
		 
		 int idx = 0; 
		 StringBuffer sb = new StringBuffer(); 
		 
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