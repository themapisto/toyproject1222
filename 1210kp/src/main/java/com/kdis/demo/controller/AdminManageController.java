package com.kdis.demo.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdis.demo.service.AdminManageService;
import com.kdis.demo.vo.PaginationDto;
import com.kdis.demo.vo.UserVo;

@Controller
@RequestMapping("/manage/*")
public class AdminManageController {
	@Inject
	private AdminManageService adminManageService;
	
		// 유저 리스트 
		@RequestMapping(value = "userList")
		public String adminLogin(PaginationDto dto, ModelMap model, 
//				@RequestParam(value="page", required=false)String page, 
//				@RequestParam(value="option", required=false)String option,
//				@RequestParam(value="keyword", required=false)String keyword,
				HttpServletRequest request,HttpServletResponse response) throws Exception {
			//dto = new PaginationDto();
//			if(page!=null) {
//				dto.setPage(Integer.parseInt(page));
//			}
//			if(keyword!=""&&keyword!=null) {
//				dto.setOption(option);
//				dto.setKeyword(keyword);
//			}
			dto.setTotal(adminManageService.countTotal(dto));
			List<UserVo> userList = adminManageService.showAllUser(dto);
			model.addAttribute("pageDto", dto);
			model.addAttribute("userList",userList);
			System.out.println(dto.toString());
			return "/admin/userList";
		}
		
		
}
