package com.kdis.demo.vo;

import java.util.Date;

public class UserCouponDto {
	private String couponId; // 쿠폰번호
	private String couponNm; // 쿠폰이름
	private int dscntRate; // 할인율
	private Date expireDt; // user의 쿠폰 만료일
	
	public UserCouponDto() {
		
	}
	
	public UserCouponDto(String couponId, String couponNm, int dscntRate,
			Date expireDt) {
		super();
		this.couponId = couponId;
		this.couponNm = couponNm;
		this.dscntRate = dscntRate;
		this.expireDt = expireDt;
	}

	public String getCouponId() {
		return couponId;
	}

	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}

	public String getCouponNm() {
		return couponNm;
	}

	public void setCouponNm(String couponNm) {
		this.couponNm = couponNm;
	}

	public int getDscntRate() {
		return dscntRate;
	}

	public void setDscntRate(int dscntRate) {
		this.dscntRate = dscntRate;
	}

	public Date getExpireDt() {
		return expireDt;
	}

	public void setExpireDt(Date expireDt) {
		this.expireDt = expireDt;
	}

	@Override
	public String toString() {
		return "UserCouponDto [couponId=" + couponId + ", couponNm=" + couponNm + ", dscntRate=" + dscntRate
				+ ", expireDt=" + expireDt + "]";
	}
}
