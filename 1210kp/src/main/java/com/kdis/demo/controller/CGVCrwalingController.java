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

import com.google.gson.Gson;
import com.kdis.demo.vo.InfoDto;
import com.kdis.movieList.MovieListController;
import com.kdis.movieList.MovieListService;

@RestController
public class CGVCrwalingController {
	
	@Inject
	private MovieListController movieList;
	
	
	private static Logger logger = LoggerFactory.getLogger(CGVCrwalingController.class);
	
	@GetMapping(value = "/crawling", produces = "application/text; charset=utf-8")
	String getCrawling() throws IOException {
		Document doc;
		String gson="";
		
		doc = Jsoup.connect("http://www.cgv.co.kr/movies/").get();
		Elements ranks = doc.select(".rank");
		Elements imgs = doc.select(".thumb-image > img");
		Elements movieAges = doc.select(".ico-grade");
		Elements movieTitles = doc.select(".box-contents strong.title");
		Elements movieRates = doc.select(".percent span");
		Elements movieOpenDates = doc.select(".txt-info strong");
		
		List<InfoDto> list = new ArrayList<InfoDto>();
		
		for(int i=0;i<ranks.size();i++) {
			int seq = i;
			String rank = ranks.get(i).text();
			String img = imgs.get(i).attr("src");
			//kpkim 
		    rank=rank.substring(3);
	
			movieList.Crwaling(img,rank);
			
			
			String movieAge = movieAges.get(i).text();
			String movieTitle = movieTitles.get(i).text();
			String movieRate = movieRates.get(i).text();
			String movieOpenDate = movieOpenDates.get(i).text();
			
			InfoDto dto = new InfoDto(seq, rank, img, movieAge, movieTitle, movieRate, movieOpenDate);
			
			//logger.info(dto.toString());
			list.add(dto);
		}
		
		gson = new Gson().toJson(list);
		
		return gson;
	}
}
