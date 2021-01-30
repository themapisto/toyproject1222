package com.kdis.demo;



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
	  
	@RequestMapping(value= "/ticketing", method= RequestMethod.GET)
	public void ticketing() throws Exception{
	
	}
	
	
	
	@RequestMapping(value ="/api", method= RequestMethod.GET)
	public void getApi() throws Exception {
		 
		String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
		 String AUTH_KEY = "0a49df840ef75532829c0570cee0b18b";
		 SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd");
		 
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			cal.add(Calendar.DATE, -1);
		 
		 
		 
			Map<String, String> paramMap = new HashMap<String, String>();
			
			paramMap.put("key", AUTH_KEY);
			paramMap.put("targetDt", DATE_FMT.format(cal.getTime()));
			paramMap.put("itemPerPage", "10");
			paramMap.put("multiMovieYn", "Y");
			paramMap.put("repNationCd", "K");
		
			StringBuilder sb= new StringBuilder();
		
		    for (String mapkey : paramMap.keySet()){
		        System.out.println("Key:"+mapkey+", Value:"+paramMap.get(mapkey));
		        
		        sb.append("&");
		        sb.append(mapkey).append('=').append(paramMap.get(mapkey));
		       
		    }
		
			try {
			
			URL requestURL = new URL(REQUEST_URL+"?"+sb.toString());
			System.out.println(requestURL);
			HttpURLConnection conn = (HttpURLConnection)requestURL.openConnection();

			conn.setRequestMethod("GET");
			conn.setDoInput(true);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String readline = null;
			StringBuffer response = new StringBuffer();
			while ((readline = br.readLine()) != null) {
				response.append(readline);
			}
			
			System.out.println(response);

			JSONObject responseBody = new JSONObject(response.toString());
			System.out.println(responseBody);

			JSONObject boxOfficeResult = responseBody.getJSONObject("boxOfficeResult");

			String boxofficeType = boxOfficeResult.getString("boxofficeType");
			System.out.println(boxofficeType);


			JSONArray dailyBoxOfficeList = boxOfficeResult.getJSONArray("dailyBoxOfficeList");
			Iterator<Object> iter = dailyBoxOfficeList.iterator();
			System.out.println(dailyBoxOfficeList);
			while (iter.hasNext()) {
				JSONObject boxOffice = (JSONObject) iter.next();
				System.out.printf("{순위:%s, 제목:%s, 개봉일:%s, 누적관객수:%s}\n", 
						boxOffice.get("rank"), boxOffice.get("movieNm"), boxOffice.get("openDt"),
						boxOffice.get("audiAcc"));	
			}

			}catch(Exception e){
				
			e.printStackTrace();
			}
			}
				
			
	}
			
			
			
			
	
