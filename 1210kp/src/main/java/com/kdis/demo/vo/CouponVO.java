package com.kdis.demo.vo;

import java.util.Date;

public class CouponVO {

	private String couponId;			// 쿠폰ID
	private String couponNm;			// 쿠폰이름
	private int dscntRate;				// 할인율
	private Date registStartDt;			// 쿠폰등록시작일자
	private Date registEndDt;			// 쿠폰등록만료일자
	private String registChk;			// 쿠폰등록진행여부(1.진행 2.종료)
	private int usePeriod;				// 쿠폰사용가능기간(userCoupon 쿠폰만료일자 - 쿠폰등록일자) 
	
	public String getCouponId() {
		return couponId;
	}
	public String getCouponNm() {
		return couponNm;
	}
	public int getDscntRate() {
		return dscntRate;
	}
	public Date getRegistStartDt() {
		return registStartDt;
	}
	public Date getRegistEndDt() {
		return registEndDt;
	}
	public String getRegistChk() {
		return registChk;
	}
	public int getUsePeriod() {
		return usePeriod;
	}
	
}
