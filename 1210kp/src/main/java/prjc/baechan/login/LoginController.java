package prjc.baechan.login;

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
		 int addLoginCntChk = 0;
		 int userLockChk = 0;
		 
		 if(loginChk == 1) {
			 loginFailCount = 0;
			 paramMap.put("loginFailCount", loginFailCount);
		 	 addLoginCntChk = LoginService.updateLoginFailCount(paramMap);

		 	 if(addLoginCntChk == 1) {
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
					 addLoginCntChk = LoginService.updateLoginFailCount(paramMap);
					 
					 if(addLoginCntChk == 1) {
						 result = loginFailCount.toString();
					 }else {
						 // 로그인실패횟수증감오류 에러페이지 호출
						 result = "-1";
					 }
				 }else if(loginFailCount == 5){
					 
					 paramMap.put("loginFailCount", loginFailCount);
					 addLoginCntChk = LoginService.updateLoginFailCount(paramMap);
					 
					 userLockChk = MemberService.userLockout(paramMap);
					 
					 if(userLockChk == 1 && addLoginCntChk == 1) {
						 result = "5";
					 }else {
						// 계정잠금오류 에러페이지 호출
						 result = "-1";
					 }
				 }else {
					 result = "0";
				 }
			 }else{
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
	 
}