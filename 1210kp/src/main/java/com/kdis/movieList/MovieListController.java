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

				// 湲곗〈 �뜲�씠�꽣�� 鍮꾧탳�빐�꽌 以묐났�릺吏� �븡�룄濡� 泥섎━

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

		// TODO �쁽�옱�궇吏�-1 day濡�
		List<MovieVO> vos = service.list("daily", "20210402");
		System.out.println(vos.toString());

		movieListCommon common = new movieListCommon();
		common.sortListVO(vos, "1", "ASC");
		model.addAttribute("list", vos);

		return "/movie/dailyBoxOf";
	}

	@RequestMapping(value = "/weeklyBoxOf")
	public String weeklyList(Model model) throws Exception {

		System.out.print("weeklyBoxOf�뿉 ���븳 而⑦듃濡ㅻ윭 硫붿꽌�뱶媛� �떆�옉�맗�땲�떎.");
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

				// 湲곗〈 �뜲�씠�꽣�� 鍮꾧탳�빐�꽌 以묐났�릺吏� �븡�룄濡� 泥섎━

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

				// TODO 湲곕낯�궎�� index瑜� �엯�젰�븯�뿬, insert媛� �릺吏� �븡吏�留�, 1二쇱씪�뿉 �븳踰덈쭔 insert媛� �릺�룄濡� �닔�젙�빐�빞�븿.

				sqlSession.insert("movieInsert", vo);

			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		// TODO �쁽�옱�궇吏�-7day 濡� 諛붽퓭�빞�븿
		List<MovieVO> vos = service.list("weekly", "20210322");

		movieListCommon common = new movieListCommon();
		common.sortListVO(vos, "1", "ASC");
		model.addAttribute("list", vos);

		return "/movie/weeklyBoxOf";
	}

	@RequestMapping(value = "/movieMain")
	public String movieMain(Model model) throws Exception {

		// TODO �쁽�옱�궇吏�-7day 濡� 諛붽퓭�빞�븿
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

		// TODO �쁺�솕 吏꾪씎�썝api瑜� �넻�빐 諛쏆븘�삩 rank�� �쁺�솕�젣紐⑹쓣 鍮꾧탳�븯�뿬, �젙�솗�븳 �씠誘몄� �겕濡ㅻ쭅 二쇱냼瑜� �엯�젰�븯�뿬�빞�븿.

		sqlSession.update("movieInsertImage", vo);

	}

}
