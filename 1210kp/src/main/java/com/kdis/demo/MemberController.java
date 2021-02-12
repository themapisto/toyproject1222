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

import prjc.baechan.login.LoginService;

@Controller
@RequestMapping("/member/*")
public class MemberController{

	 @Inject
	 private MemberService MemberService;
	 
	 @Inject
	 private LoginService LoginService;
	 
	 @RequestMapping(value = "/pwdChange")
	 public String pwdChange() throws Exception {
		 return "/member/pwdChange";
	 }
	 
	 @RequestMapping(value = "/userWithdrawal")
	 public String userWithdrawal() throws Exception {
		 return "/member/userWithdrawal";
	 }
	 
	 @RequestMapping(value = "/myInfo")
	 public String myInfo(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		 
		 HttpSession session = request.getSession(true);
		 String userId = (String) session.getAttribute("sessionId");
		 
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();
		 paramMap.put("userId", userId);
		 
		 UserVO userVO = MemberService.selectMyInfo(paramMap);
		 
		 model.addAttribute("userVO",userVO);
		 return "/member/myInfo";
	 }
	 
	 @RequestMapping(value = "/myInfoModify")
	 public String myInfoModify(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		 HttpSession session = request.getSession(true);
		 String userId = (String) session.getAttribute("sessionId");
		 
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();
		 paramMap.put("userId", userId);
		 
		 UserVO userVO = MemberService.selectMyInfo(paramMap);
		 
		 if("-".equals(userVO.getEmail())) {
			 userVO.setEmail("");
		 }
		 if("-".equals(userVO.getPhoneNumber())) {
			 userVO.setPhoneNumber("");
		 }
		 
		 model.addAttribute("userVO",userVO);
		 return "/member/myInfoModify";
	 }
	 
	 @RequestMapping(value = "/myInfoModifySubmit")
	 public String myInfoModifySubmit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();
	
		 HttpSession session = request.getSession(true);
		 
		 String userId = (String) session.getAttribute("sessionId");
		 String userNm = request.getParameter("userNm");
		 String birthday = request.getParameter("birthday");
		 String email = request.getParameter("email");
		 String phoneNumber = request.getParameter("phoneNumber");
	
		 paramMap.put("userId", userId);
		 paramMap.put("userNm", userNm);
		 paramMap.put("birthday", birthday);
		 paramMap.put("email", email);
		 paramMap.put("phoneNumber", phoneNumber);
		 
		 int result = 0;
		 result = MemberService.updateMyInfo(paramMap);		 
		 if(result == 1) {
			 model.addAttribute("result", "Y");
		 }else if(result == 0) {
			 model.addAttribute("result", "N");
		 }
		 
		 model.addAttribute("submit", "updateMyInfo");		 
		 return "/common/result";
	 }
	 
	 @ResponseBody
	 @RequestMapping("/pwdChangeSubmit")
	 public Map<String,String> pwdChangeSubmit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();
		 Map<String,String> resultMap = new HashMap<String,String>();

		 HttpSession session = request.getSession(true);
		 String userId = (String) session.getAttribute("sessionId");
		 String pwOld = request.getParameter("pwOld");
		 String pwNew = request.getParameter("pwNew");
		 
		 String salt = LoginService.getUserSalt(userId);

		 paramMap.put("userId", userId);
		 paramMap.put("password", SHA256Util.encrypt(pwOld,salt));
		 
		 String result = "";
		 int pwOldSelect = 0;
		 int pwNewUpdate = 0;
		 pwOldSelect = LoginService.loginSubmit(paramMap);
		 
		 if(pwOldSelect == 1) {
			 salt = SHA256Util.getNewSalt();
			 
			 paramMap.put("password", SHA256Util.encrypt(pwNew,salt));
			 paramMap.put("salt", salt);
			 
			 pwNewUpdate = MemberService.updatePwd(paramMap);
			 if(pwNewUpdate == 1) {
				result = "success";
				session.invalidate();
			 }else{
				 result = "updateFail";
			 }
		 }else {
			 result = "selectFail";
		 }
		 resultMap.put("result", result);
		 return resultMap;
	 }
	 
	 @RequestMapping(value = "/userWithdrawalSubmit")
	 public String userWithdrawalSubmit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {		 
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();

		 HttpSession session = request.getSession(true);
		 String userId = (String) session.getAttribute("sessionId");
		 String password = request.getParameter("password");
		 
		 String salt = LoginService.getUserSalt(userId);
		 
		 paramMap.put("userId", userId);
		 paramMap.put("password", SHA256Util.encrypt(password,salt));
		 
		 int check = 0;
		 check = LoginService.loginSubmit(paramMap);
		 
		 if(check == 1) {
			 int result = 0;
			 result = MemberService.userWithdrawal(paramMap);
			 if(result == 1) {
				 model.addAttribute("result", "success");
				 session.invalidate();
			 }else {
				 model.addAttribute("result", "updateFail");
			 }
		 }else {
			 model.addAttribute("result", "selectFail");
		 }
		 model.addAttribute("submit", "userWithdrawal");		 
		 return "/common/result";

	 }
	
}