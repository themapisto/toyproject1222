package com.kdis.demo.controller;



import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	// 일일 박스 오피스 목록 조회
	//hi
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
				System.out.printf("{�닚�쐞:%s, �젣紐�:%s, 媛쒕큺�씪:%s, �늻�쟻愿�媛앹닔:%s}\n", 
						boxOffice.get("rank"), boxOffice.get("movieNm"), boxOffice.get("openDt"),
						boxOffice.get("audiAcc"));	
			}

			}catch(Exception e){
				
			e.printStackTrace();
			}
			}
				
			
	}
			
			
			
			
	
