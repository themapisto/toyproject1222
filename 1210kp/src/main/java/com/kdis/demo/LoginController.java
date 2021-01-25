package com.kdis.demo;

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
	 
	 @RequestMapping(value = "/result")
	 public String result() throws Exception {
		 return "/login/result";
	 }
	 
	 @RequestMapping(value = "/sessionExpire")
	 public String sessionExpire() throws Exception {
		 return "/login/sessionExpire";
	 }
	 
	 @RequestMapping(value = "/loginSubmit")
	 public String loginSubmit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();
		 
		 String userId = request.getParameter("userId");
		 String password = request.getParameter("password");
		 
		 String salt = LoginService.getUserSalt(userId);

		 paramMap.put("userId", userId);
		 paramMap.put("password", SHA256Util.encrypt(password,salt));
 
		 int result = 0;
		 result = LoginService.loginSubmit(paramMap);
		 UserVO userVO = MemberService.selectMyInfo(paramMap);
		 
		 if(result == 1) {
			 model.addAttribute("result", "Y");
			 
			 HttpSession session = request.getSession(true);
			 session.setMaxInactiveInterval(1 * 60); // test 1분
			 session.setAttribute("sessionId", userVO.getUserId());
			 session.setAttribute("sessionUserNm", userVO.getUserNm());
			 session.setAttribute("sessionLoginChk", "Y");
		 }else if(result == 0) {
			 model.addAttribute("result", "N");
		 }
		 
		 model.addAttribute("submit", "login");
		 return "/login/result";
	 }
	 
	 @RequestMapping(value="/logout")
	 public String logout(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {

		 HttpSession session = request.getSession(true);
		 session.invalidate();
		 
		 model.addAttribute("result", "Y");
		 model.addAttribute("submit","logout");
		 return "/login/result";
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
		 return "/login/result";
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