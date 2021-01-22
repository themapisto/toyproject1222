//package com.kdis.demo;
//
//
//import java.io.BufferedReader;
//import java.io.InputStreamReader;
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.text.SimpleDateFormat;
//import java.util.Calendar;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.Map;
//
//import org.json.JSONArray;
//import org.json.JSONObject;
//
//
//public class DailyBoxOfficeAPI {
//
//	private final String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
//	private final String AUTH_KEY = "d121c3cb6ee7d828eebd54edf42e84a3";
//
//
//	private final SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd");
//
//	public String makeQueryString(Map<String, String> paramMap) {
//		final StringBuilder sb = new StringBuilder();
//
//		paramMap.entrySet().forEach((entry) -> {
//			if (sb.length() > 0) {
//				sb.append("&");
//			}
//			sb.append(entry.getKey()).append('=').append(entry.getValue());
//		});
//		return sb.toString();
//	}
//
//	public void requestAPI() {
//		Calendar cal = Calendar.getInstance();
//		cal.setTime(new Date());
//		cal.add(Calendar.DATE, -1);
//
//
//		Map<String, String> paramMap = new HashMap<String, String>();
//		paramMap.put("key", AUTH_KEY);
//		paramMap.put("targetDt", DATE_FMT.format(cal.getTime()));
//		paramMap.put("itemPerPage", "10");
//		paramMap.put("multiMovieYn", "Y");
//		paramMap.put("repNationCd", "K");
//
//		try {
//			URL requestURL = new URL(REQUEST_URL+"?"+makeQueryString(paramMap));
//			HttpURLConnection conn = (HttpURLConnection)requestURL.openConnection();
//
//			conn.setRequestMethod("GET");
//			conn.setDoInput(true);
//
//			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
//			String readline = null;
//			StringBuffer response = new StringBuffer();
//			while ((readline = br.readLine()) != null) {
//				response.append(readline);
//			}
//			System.out.println(response);
//
//			JSONObject responseBody = new JSONObject(response.toString());
//			System.out.println(responseBody);
//
//			JSONObject boxOfficeResult = responseBody.getJSONObject("boxOfficeResult");
//
//			String boxofficeType = boxOfficeResult.getString("boxofficeType");
//			System.out.println(boxofficeType);
//
//
//			JSONArray dailyBoxOfficeList = boxOfficeResult.getJSONArray("dailyBoxOfficeList");
//			Iterator<Object> iter = dailyBoxOfficeList.iterator();
//			System.out.println(dailyBoxOfficeList);
//			while (iter.hasNext()) {
//				JSONObject boxOffice = (JSONObject) iter.next();
//				System.out.printf("{순위:%s, 제목:%s, 개봉일:%s, 누적관객수:%s}\n", 
//						boxOffice.get("rank"), boxOffice.get("movieNm"), boxOffice.get("openDt"),
//						boxOffice.get("audiAcc"));	
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	public static void main(String[] args) {
//		DailyBoxOfficeAPI api = new DailyBoxOfficeAPI();
//
//		api.requestAPI();
//	}
//
//}
