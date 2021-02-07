package com.kdis.demo.board;



import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.JSONArray;
import org.json.JSONObject;
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
		
		 
	  List<BoardVO> list = null;
	  list = service.list();
	  model.addAttribute("list", list);
	  
	 }			
	}
			
			
			
			
	