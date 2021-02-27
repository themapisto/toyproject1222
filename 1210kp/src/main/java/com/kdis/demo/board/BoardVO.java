package com.kdis.demo.board;

import java.util.Date;

public class BoardVO {

	private int movieCd;
	private String movieNm;
	public int getMovieCd() {
		return movieCd;
	}
	public void setMovieCd(int movieCd) {
		this.movieCd = movieCd;
	}
	public String getMovieNm() {
		return movieNm;
	}
	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}
	@Override
	public String toString() {
		return "BoardVO [movieCd=" + movieCd + ", movieNm=" + movieNm + "]";
	}

	

}
