package com.kdis.demo.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kdis.demo.service.AdminManageService;
import com.kdis.demo.vo.UserVO;

@Controller
@RequestMapping("/manage/*")
public class AdminManageController {
	@Inject
	private AdminManageService adminManageService;
	
		// 모든유저 리스트 
		@RequestMapping(value = "userList")
		public String adminLogin(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
			List<UserVO> userList = adminManageService.showAllUser();
			 model.addAttribute("userList",userList);
			return "/admin/userList";
		}
		
		
}
