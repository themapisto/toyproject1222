package com.kdis.movieList;

import com.kdis.movieList.MovieVO;
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

import org.apache.ibatis.session.SqlSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.mariadb.jdbc.internal.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/movie/*")
public class MovieListController {

	@Inject
	private MovieListService service;

	MovieVO vo = new MovieVO();

	@Inject
	private SqlSession sqlSession;

	@RequestMapping(value = "/dailyBoxOf", method = RequestMethod.GET)
	public String list(Model model) throws Exception {

		String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
		String AUTH_KEY = "0a49df840ef75532829c0570cee0b18b";
		SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, -1);

		Map<String, String> paramMap = new HashMap<String, String>();

		paramMap.put("key", AUTH_KEY);
		paramMap.put("targetDt", DATE_FMT.format(cal.getTime()));
		paramMap.put("itemPerPage", "0");
		paramMap.put("multiMovieYn", "N");
		paramMap.put("repNationCd", "K");

		StringBuilder sb = new StringBuilder();

		for (String mapkey : paramMap.keySet()) {
			System.out.println("Key:" + mapkey + ", Value:" + paramMap.get(mapkey));

			sb.append("&");
			sb.append(mapkey).append('=').append(paramMap.get(mapkey));

		}

		try {

			URL requestURL = new URL(REQUEST_URL + "?" + sb.toString());
			System.out.println(requestURL);
			HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();

			Date now = new Date();
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

				// 기존 데이터와 비교해서 중복되지 않도록 처리

				JSONObject boxOffice = (JSONObject) iter.next();
				System.out.print("??" + boxOffice.get("movieNm"));
			
				vo.setMovieCd(boxOffice.get("movieCd").toString());
				vo.setMovieNm(boxOffice.get("movieNm").toString());
				vo.setRank(boxOffice.get("rank").toString());
				vo.setOpenDt(boxOffice.get("openDt").toString());
				vo.setAudiAcc(boxOffice.get("audiAcc").toString());
				vo.setSalesAmt(boxOffice.get("salesAmt").toString());
				// System.out.println(DATE_FMT);

				System.out.print("??" + vo.getAudiAcc() + "???" + vo.getMovieNm() + "sddd" + vo.getMovieCd() + "???"
						+ vo.getRank());
				sqlSession.insert("movieInsert", vo);

				System.out.printf("{순위:%s, 제목:%s, 개봉일:%s, 누적관객수:%s}\n", boxOffice.get("rank"), boxOffice.get("movieNm"),
						boxOffice.get("openDt"), boxOffice.get("audiAcc"));

			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		model.addAttribute("list", service.list());
		System.out.println("dddd" + service.list());

		return "/movie/dailyBoxOf";
	}

	@RequestMapping(value = "/weeklyBoxOf")
	public String weeklyList(Model model) throws Exception {

		String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json";
		String AUTH_KEY = "0a49df840ef75532829c0570cee0b18b";
		SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, -1);

		Map<String, String> paramMap = new HashMap<String, String>();

		paramMap.put("key", AUTH_KEY);
		paramMap.put("targetDt", DATE_FMT.format(cal.getTime()));
		paramMap.put("itemPerPage", "0");
		paramMap.put("itemPerPage", "10");
		paramMap.put("multiMovieYn", "N");
		paramMap.put("repNationCd", "K");

		StringBuilder sb = new StringBuilder();

		for (String mapkey : paramMap.keySet()) {
			System.out.println("Key:" + mapkey + ", Value:" + paramMap.get(mapkey));

			sb.append("&");
			sb.append(mapkey).append('=').append(paramMap.get(mapkey));

		}

		try {

			URL requestURL = new URL(REQUEST_URL + "?" + sb.toString());
			System.out.println(requestURL);
			HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();

			Date now = new Date();
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

				// 기존 데이터와 비교해서 중복되지 않도록 처리

				JSONObject boxOffice = (JSONObject) iter.next();
				System.out.print("??" + boxOffice.get("movieNm"));			
				vo.setMovieCd(boxOffice.get("movieCd").toString());
				vo.setMovieNm(boxOffice.get("movieNm").toString());
				vo.setRank(boxOffice.get("rank").toString());
				vo.setOpenDt(boxOffice.get("openDt").toString());
				vo.setAudiAcc(boxOffice.get("audiAcc").toString());
				vo.setSalesAmt(boxOffice.get("salesAmt").toString());
				// System.out.println(DATE_FMT);

				System.out.print("??" + vo.getAudiAcc() + "???" + vo.getMovieNm() + "sddd" + vo.getMovieCd() + "???"
						+ vo.getRank());
				sqlSession.insert("movieInsert", vo);

				System.out.printf("{순위:%s, 제목:%s, 개봉일:%s, 누적관객수:%s}\n", boxOffice.get("rank"), boxOffice.get("movieNm"),
						boxOffice.get("openDt"), boxOffice.get("audiAcc"));

			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		model.addAttribute("list", service.list());
		System.out.println("dddd" + service.list());
		return "/movie/weeklyBoxOf";
	}

	@RequestMapping(value = "/movieMain")
	public String movieMain() throws Exception {
		return "/movie/movieMain";

	}

}
