package com.kdis.demo.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kdis.movieList.MovieListController;
import com.kdis.movieList.MovieRankVO;

@RestController
public class BoardController {

	@Inject
	private MovieListController movieList;
	List<MovieRankVO> list = new ArrayList<MovieRankVO>();


	private static Logger logger = LoggerFactory.getLogger(BoardController.class);


	@GetMapping(value = "/movieCrawling", produces = "application/text; charset=utf-8")
	List<MovieRankVO> getMovieCrawling() throws IOException {
		Document doc;

		doc = Jsoup.connect("http://www.cgv.co.kr/movies/").get();
		Elements ranks = doc.select(".rank");
		Elements imgs = doc.select(".thumb-image > img");
		Elements movieAges = doc.select(".ico-grade");
		Elements movieTitles = doc.select(".box-contents strong.title");
		Elements movieRates = doc.select(".percent span");
		Elements movieOpenDates = doc.select(".txt-info strong");

		for (int i = 0; i < ranks.size(); i++) {
			int seq = i;
			String rank = ranks.get(i).text();
			String img = imgs.get(i).attr("src");
			String movieAge = movieAges.get(i).text();
			String movieTitle = movieTitles.get(i).text();
			String movieRate = movieRates.get(i).text();
			String movieOpenDate = movieOpenDates.get(i).text();

			MovieRankVO dto = new MovieRankVO(seq, rank, img, movieAge, movieTitle, movieRate, movieOpenDate);

			list.add(dto);

		}

		return list;
	}
}
