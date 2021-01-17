package com.kdis.demo;



import java.util.List;

import javax.inject.Inject;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	 private BoardService service;


	@RequestMapping(value = "/list", method = RequestMethod.GET)
	 public void getList(Model model) throws Exception {
		//kd
		 
	  List<BoardVO> list = null;
	  list = service.list();
	  model.addAttribute("list", list);
	  
	 }
}