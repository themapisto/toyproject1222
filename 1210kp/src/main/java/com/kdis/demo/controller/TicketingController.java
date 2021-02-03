package com.kdis.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TicketingController {

	@RequestMapping("/ticketing")
	public String ticketing() {
		return "/ticketing/ticketing";
	}
}
