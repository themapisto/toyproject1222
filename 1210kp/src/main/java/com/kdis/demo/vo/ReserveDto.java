package com.kdis.demo.vo;

public class ReserveDto {
	private String title;
	private String movieAge;
	private String selectedTheater;
	private String movieDate;
	private String runningTime;
	private String reserveDate;
	private int price;
	private String selectedSeat;
	
	public ReserveDto() {
		super();
	}

	public ReserveDto(String title, String movieAge, String selectedTheater, String movieDate, String runningTime,
			String reserveDate, int price, String selectedSeat) {
		super();
		this.title = title;
		this.movieAge = movieAge;
		this.selectedTheater = selectedTheater;
		this.movieDate = movieDate;
		this.runningTime = runningTime;
		this.reserveDate = reserveDate;
		this.price = price;
		this.selectedSeat = selectedSeat;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMovieAge() {
		return movieAge;
	}

	public void setMovieAge(String movieAge) {
		this.movieAge = movieAge;
	}

	public String getSelectedTheater() {
		return selectedTheater;
	}

	public void setSelectedTheater(String selectedTheater) {
		this.selectedTheater = selectedTheater;
	}

	public String getMovieDate() {
		return movieDate;
	}

	public void setMovieDate(String movieDate) {
		this.movieDate = movieDate;
	}

	public String getRunningTime() {
		return runningTime;
	}

	public void setRunningTime(String runningTime) {
		this.runningTime = runningTime;
	}

	public String getReserveDate() {
		return reserveDate;
	}

	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getSelectedSeat() {
		return selectedSeat;
	}

	public void setSelectedSeat(String selectedSeat) {
		this.selectedSeat = selectedSeat;
	}

	@Override
	public String toString() {
		return "ReserveDto [title=" + title + ", movieAge=" + movieAge + ", selectedTheater=" + selectedTheater
				+ ", movieDate=" + movieDate + ", runningTime=" + runningTime + ", reserveDate=" + reserveDate
				+ ", price=" + price + ", selectedSeat=" + selectedSeat + "]";
	}
}
