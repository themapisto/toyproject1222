package com.kdis.demo;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/login/*")
public class LoginController{

	 @Inject
	 private LoginService LoginService;
	
	 @RequestMapping(value = "/login")
	 public String login() throws Exception {
		 return "/login/login";
	 }
	 
	 @RequestMapping(value = "/join")
	 public String join() throws Exception {
		 return "/login/join";
	 }
	 
	 @RequestMapping(value = "/joinResult")
	 public String joinResult() throws Exception {
		 return "/login/joinResult";
	 }
	 
	 @RequestMapping(value = "/loginSubmit")
	 public String loginSubmit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		 HashMap<String,Object> paramMap = new HashMap<String,Object>();
		 
		 String userId = request.getParameter("userId");
		 String password = request.getParameter("password");
		
		 if(userId == null) {
			 userId = "";
		 }else if(password == null){
			 password = "";
		 }else {
			 
		 }
		 
		 paramMap.put("userId", userId);
		 paramMap.put("password", password);
		 
		 System.out.println("paramMap:::"+paramMap);
		 
		 int result = 0;
		 result = LoginService.loginSubmit(paramMap);
		 
		 if(result == 1) {
			 model.addAttribute("result", "Y");
		 }else if(result == 0) {
			 model.addAttribute("result", "N");
		 }
		 
		 model.addAttribute("submit", "login");
		 System.out.println("result:::"+result);
		 return "/login/result";
	 }
	 
	 @ResponseBody
	 @RequestMapping(value="/idCheckAjax")
	 public String idCheckAjax(ModelMap model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		 int check = 0;
		 String result = "";
		 
		 String userId = request.getParameter("userId");
		 check = LoginService.idCheck(userId);
		 
		 if(check == 1) {
			 result = "N";
		 }else if(check == 0) {
			 result = "Y";
		 }
		 
		 return result;
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
	
		 if(userId == null) {
			 userId = "";
		 }else if(password == null){
			 password = "";
		 }else if(userNm == null){
			 userNm = "";
		 }else if(birthday == null){
			 birthday = "";
		 }else if(email == null){
			 email = "";
		 }else if(phoneNumber == null){
			 phoneNumber = "";
		 }else {
			// TODO : 에러페이지
		 }
		 
		 paramMap.put("userId", userId);
		 paramMap.put("userNm", userNm);
		 paramMap.put("password", password);
		 paramMap.put("birthday", birthday);
		 paramMap.put("phoneNumber", phoneNumber);
		 paramMap.put("email", email);
		 paramMap.put("grade", '1');
		 paramMap.put("userState", '1');
		 System.out.println("paramMap:::"+paramMap);
		 
		 int result = 0;
		 result = LoginService.userJoin(paramMap);
		 
		 if(result == 1) {
			 model.addAttribute("result", "Y");
		 }else if(result == 0) {
			 model.addAttribute("result", "N");
		 }
		 
		 model.addAttribute("submit", "join");
		 System.out.println("result:::"+result);
		 return "/login/result";
	 }
}