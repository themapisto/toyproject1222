package com.kdis.demo.vo;

import java.util.Date;

public class BoardVO {

	private int userId;
	private String userNm;
	private String password;
	private String phoneNumber;
	private String email;
	private Date regDt;
	private String grade;
	private String userState;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getPassword() {
		return password;
	}
	@Override
	public String toString() {
		return "BoardVO [userId=" + userId + ", userNm=" + userNm + ", password=" + password + ", phoneNumber="
				+ phoneNumber + ", email=" + email + ", regDt=" + regDt + ", grade=" + grade + ", userState="
				+ userState + "]";
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getUserState() {
		return userState;
	}
	public void setUserState(String userState) {
		this.userState = userState;
	}
	
	

}
