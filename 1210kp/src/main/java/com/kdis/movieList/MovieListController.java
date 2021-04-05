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
		String AUTH_KEY = "92be55421c9d9393f92251cbcb6fea1a";
		SimpleDateFormat DATE_FMT = new SimpleDateFormat("20210402");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, -1);

		System.out.print(DATE_FMT.format(cal.getTime()));

		Map<String, String> paramMap = new HashMap<String, String>();

		paramMap.put("key", AUTH_KEY);
		paramMap.put("targetDt", DATE_FMT.format(cal.getTime()));
		paramMap.put("itemPerPage", "7");
		paramMap.put("multiMovieYn", "N");
		paramMap.put("repNationCd", "K");

		StringBuilder sb = new StringBuilder();

		for (String mapkey : paramMap.keySet()) {

			sb.append("&");
			sb.append(mapkey).append('=').append(paramMap.get(mapkey));

		}

		try {

			URL requestURL = new URL(REQUEST_URL + "?" + sb.toString());

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

			JSONObject responseBody = new JSONObject(response.toString());

			JSONObject boxOfficeResult = responseBody.getJSONObject("boxOfficeResult");
			String boxofficeType = boxOfficeResult.getString("boxofficeType");

			JSONArray dailyBoxOfficeList = boxOfficeResult.getJSONArray("dailyBoxOfficeList");
			Iterator<Object> iter = dailyBoxOfficeList.iterator();

			while (iter.hasNext()) {

				// 기존 데이터와 비교해서 중복되지 않도록 처리

				JSONObject boxOffice = (JSONObject) iter.next();
				vo.setMovieVal("daily");
				vo.setMovieCd(boxOffice.get("movieCd").toString());
				vo.setMovieNm(boxOffice.get("movieNm").toString());
				vo.setRank(boxOffice.get("rank").toString());
				vo.setOpenDt(boxOffice.get("openDt").toString());
				vo.setAudiAcc(boxOffice.get("audiAcc").toString());
				vo.setSalesAmt(boxOffice.get("salesAmt").toString());
				vo.setInsertDt(DATE_FMT.format(cal.getTime()));
				// System.out.println(DATE_FMT);

				sqlSession.insert("movieInsert", vo);

			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		// TODO 현재날짜-1 day로
		List<MovieVO> vos = service.list("daily", "20210402");
		System.out.println(vos.toString());

		movieListCommon common = new movieListCommon();
		common.sortListVO(vos, "1", "ASC");
		model.addAttribute("list", vos);

		return "/movie/dailyBoxOf";
	}

	@RequestMapping(value = "/weeklyBoxOf")
	public String weeklyList(Model model) throws Exception {

		System.out.print("weeklyBoxOf에 대한 컨트롤러 메서드가 시작됩니다.");
		String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json";
		String AUTH_KEY = "92be55421c9d9393f92251cbcb6fea1a";
		SimpleDateFormat DATE_FMT = new SimpleDateFormat("20210322");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, -1);

		Map<String, String> paramMap = new HashMap<String, String>();

		paramMap.put("key", AUTH_KEY);
		paramMap.put("targetDt", "20210322");
		paramMap.put("itemPerPage", "7");

		StringBuilder sb = new StringBuilder();

		for (String mapkey : paramMap.keySet()) {

			sb.append("&");
			sb.append(mapkey).append('=').append(paramMap.get(mapkey));

		}

		try {

			URL requestURL = new URL(REQUEST_URL + "?" + sb.toString());

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
			System.out.print(response.toString());

			JSONObject responseBody = new JSONObject(response.toString());
			JSONObject boxOfficeResult = responseBody.getJSONObject("boxOfficeResult");
			String boxofficeType = boxOfficeResult.getString("boxofficeType");

			JSONArray weeklyBoxOfficeList = boxOfficeResult.getJSONArray("weeklyBoxOfficeList");
			Iterator<Object> iter = weeklyBoxOfficeList.iterator();

			while (iter.hasNext()) {

				// 기존 데이터와 비교해서 중복되지 않도록 처리

				JSONObject boxOffice = (JSONObject) iter.next();
				System.out.println(boxOffice.get("movieNm"));
				vo.setMovieVal("weekly");
				vo.setMovieCd(boxOffice.get("movieCd").toString());
				vo.setMovieNm(boxOffice.get("movieNm").toString());
				vo.setRank(boxOffice.get("rank").toString());
				vo.setOpenDt(boxOffice.get("openDt").toString());
				vo.setAudiAcc(boxOffice.get("audiAcc").toString());
				vo.setSalesAmt(boxOffice.get("salesAmt").toString());
				vo.setInsertDt(DATE_FMT.format(cal.getTime()));

				// TODO 기본키와 index를 입력하여, insert가 되진 않지만, 1주일에 한번만 insert가 되도록 수정해야함.

				sqlSession.insert("movieInsert", vo);

			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		// TODO 현재날짜-7day 로 바꿔야함
		List<MovieVO> vos = service.list("weekly", "20210322");

		movieListCommon common = new movieListCommon();
		common.sortListVO(vos, "1", "ASC");
		model.addAttribute("list", vos);

		return "/movie/weeklyBoxOf";
	}

	@RequestMapping(value = "/movieMain")
	public String movieMain(Model model) throws Exception {

		// TODO 현재날짜-7day 로 바꿔야함
		List<MovieVO> vos = service.list("weekly", "20210322");

		movieListCommon common = new movieListCommon();
		common.sortListVO(vos, "1", "ASC");
		model.addAttribute("list", vos);

		return "/movie/movieMain";

	}

	public void Crwaling(String image, String rank) {

		MovieVO vo = new MovieVO();
		vo.setImage(image);
		vo.setRank(rank);

		// TODO 영화 진흥원api를 통해 받아온 rank와 영화제목을 비교하여, 정확한 이미지 크롤링 주소를 입력하여야함.

		sqlSession.update("movieInsertImage", vo);

	}

}
