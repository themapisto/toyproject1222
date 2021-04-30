package com.kdis.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kdis.demo.vo.ReserveDto;



@Controller
public class TicketingController {
	
	@RequestMapping("/reserve")
	public String ticketing(){
		return "/ticketing/reserve";
	}
	
	@PostMapping("/moveSeat")
	public String moveSeat(ModelMap model, ReserveDto dto) {
		
		model.addAttribute("reserve", dto);
	    
		return "/ticketing/seat";
	}
	
}
