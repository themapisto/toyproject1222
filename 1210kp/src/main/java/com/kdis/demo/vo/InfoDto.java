package com.kdis.demo.vo;

public class InfoDto {
	int seq;
	String rank;
	String img;
	String movieAge;
	String movieTitle;
	String movieRate;
	String movieOpenDate;
	
	public InfoDto(int seq, String rank, String img, String movieAge, String movieTitle, String movieRate,
			String movieOpenDate) {
		super();
		this.seq = seq;
		this.rank = rank;
		this.img = img;
		this.movieAge = movieAge;
		this.movieTitle = movieTitle;
		this.movieRate = movieRate;
		this.movieOpenDate = movieOpenDate;
	}
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getMovieAge() {
		return movieAge;
	}
	public void setMovieAge(String movieAge) {
		this.movieAge = movieAge;
	}
	public String getMovieTitle() {
		return movieTitle;
	}
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	public String getMovieRate() {
		return movieRate;
	}
	public void setMovieRate(String movieRate) {
		this.movieRate = movieRate;
	}
	public String getMovieOpenDate() {
		return movieOpenDate;
	}
	public void setMovieOpenDate(String movieOpenDate) {
		this.movieOpenDate = movieOpenDate;
	}

	@Override
	public String toString() {
		return "CGVInfoDto [seq=" + seq + ", rank=" + rank + ", img=" + img + ", movieAge=" + movieAge + ", movieTitle="
				+ movieTitle + ", movieRate=" + movieRate + ", movieOpenDate=" + movieOpenDate + "]";
	}
}
