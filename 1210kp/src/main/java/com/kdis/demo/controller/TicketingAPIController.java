package com.kdis.demo.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TicketingAPIController {

	private final String serviceKey = "03068a0e0575c2e33d020ec2dd65f2f9";

	// 일별 박스오피스 조회
	
	  @GetMapping(value = "/api/getDailyBoxOffice", produces = "application/text; charset=utf-8") 
	  public String getDailyBoxOffice() throws IOException { 
		  SimpleDateFormat Format = new SimpleDateFormat("yyyyMMdd");
		  Calendar cal = Calendar.getInstance(); 
		  cal.add(Calendar.DATE, -1); 
		  String targetDt = Format.format(cal.getTime());
	  
		  StringBuilder urlBuilder = new StringBuilder("http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml");
		  urlBuilder.append("?" + URLEncoder.encode("key","UTF-8") + "="+serviceKey);
		  urlBuilder.append("&" + URLEncoder.encode("targetDt","UTF-8") + "=" +targetDt); //검색할 날짜 조회(당일은 조회가안되므로 하루 전으로 조회)
		  URL url = new URL(urlBuilder.toString()); HttpURLConnection
		  conn = (HttpURLConnection) url.openConnection();
		  conn.setRequestMethod("GET"); conn.setRequestProperty("Content-type","application/text"); 
		  BufferedReader rd; 
		  if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) { 
			  rd = new BufferedReader(new InputStreamReader(conn.getInputStream())); 
		  } 
		  else { 
			  rd = new BufferedReader(new InputStreamReader(conn.getErrorStream())); 
		  }
		  StringBuilder sb = new StringBuilder();
		  String line;
		  while ((line = rd.readLine()) != null){ 
			  sb.append(line); 
		  }
		  rd.close();
		  conn.disconnect();
		  return sb.toString();
	  }
	 

//	@GetMapping(value = "/api/getDailyBoxOffice", produces = "application/json; charset=utf-8")
//	public HashMap<String, String> getDailyBoxOffice() throws IOException {
//		SimpleDateFormat Format = new SimpleDateFormat("yyyyMMdd");
//		Calendar cal = Calendar.getInstance();
//		cal.add(Calendar.DATE, -1);
//		String targetDt = Format.format(cal.getTime());
//
//		StringBuilder urlBuilder = new StringBuilder(
//				"http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"); /* URL */
//		urlBuilder.append("?" + URLEncoder.encode("key", "UTF-8") + "=" + serviceKey); /* Service Key */
//		urlBuilder.append(
//				"&" + URLEncoder.encode("targetDt", "UTF-8") + "=" + targetDt); /* 검색할 날짜 조회(당일은 조회가 안되므로 하루 전으로 조회) */
//		URL url = new URL(urlBuilder.toString());
//		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//		conn.setRequestMethod("GET");
//		conn.setRequestProperty("Content-type", "application/json");
//		BufferedReader rd;
//		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
//			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//		} else {
//			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
//		}
//		StringBuilder sb = new StringBuilder();
//		String line;
//		while ((line = rd.readLine()) != null) {
//			sb.append(line);
//		}
//		
//		String jsonString = sb.toString();
//		JSONObject obj = new JSONObject(jsonString);
//		JSONArray dailyBoxOfficeList = obj.getJSONObject("boxOfficeResult").getJSONArray("dailyBoxOfficeList");
//		HashMap<String, String> map = new HashMap<String, String>(); // movieNm, grade
//		for(int i=0;i<dailyBoxOfficeList.length();i++) {
//			String movieCd = dailyBoxOfficeList.getJSONObject(i).getString("movieCd");
//			String movieNm = dailyBoxOfficeList.getJSONObject(i).getString("movieNm");
//			String watchGrade = getWatchGrade(movieCd);
//			map.put(movieNm, watchGrade);
//		}
//		
//		rd.close();
//		conn.disconnect();
//		return map;
//	}
//	
//	public String getWatchGrade(String movieCd) throws IOException {
//		StringBuilder urlBuilder = new StringBuilder(
//				"http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"); /* URL */
//		urlBuilder.append("?" + URLEncoder.encode("key", "UTF-8") + "=" + serviceKey); /* Service Key */
//		urlBuilder.append("&" + URLEncoder.encode("movieCd", "UTF-8") + "=" + movieCd); /* 영화 코드 */
//		URL url = new URL(urlBuilder.toString());
//		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//		conn.setRequestMethod("GET");
//		conn.setRequestProperty("Content-type", "application/json");
//		BufferedReader rd;
//		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
//			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//		} else {
//			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
//		}
//		StringBuilder sb = new StringBuilder();
//		String line;
//		while ((line = rd.readLine()) != null) {
//			sb.append(line);
//		}
//		
//		String jsonString = sb.toString();
//		JSONObject obj = new JSONObject(jsonString);
//		String watchGrade = obj.getJSONObject("movieInfoResult").getJSONObject("movieInfo")
//								.getJSONArray("audits").getJSONObject(0).getString("watchGradeNm");
//		
//		rd.close();
//		conn.disconnect();
//		return watchGrade;
//	}
	
	// 영화 등급 조회
	@GetMapping(value = "/api/getGrade", produces = "application/text; charset=utf-8")
	public String getWatchRank(@RequestParam(value = "movieCd") String movieCd) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml"); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("key", "UTF-8") + "=" + serviceKey); /* Service Key */
		urlBuilder.append("&" + URLEncoder.encode("movieCd", "UTF-8") + "=" + movieCd); /* 영화 코드 */
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/text");
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		return sb.toString();
	}
}
