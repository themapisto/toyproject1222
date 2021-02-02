package com.kdis.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common/*")
public class commonController {
	
	@RequestMapping(value = "/result")
	public String result() throws Exception {
		return "/common/result";
	}
	
	@RequestMapping(value = "/sessionExpire")
	public String sessionExpire() throws Exception {
		return "/common/sessionExpire";
	}
	
	@RequestMapping(value = "/errorDefault")
	public String errorDefault() throws Exception{
		return "/exception/errorDefault";
	}
}
