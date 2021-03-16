package com.kdis.demo.vo;

import java.util.Date;

public class UserCouponDto {
	private String couponId; // 쿠폰 번호
	private String couponNm; // 쿠폰 이름
	private int dscntRate; // 할인율
	private Date cupnRgstDt; // user의 쿠폰 등록 일자
	private Date cupnExpryDt; // user의 쿠폰 종료 일자
	private String cupnUseChk; // user의 쿠폰 사용 여부(미사용: 0, 사용: 1)
	private Date cupnUseDt; // user의 쿠폰 사용 일자
	private String cupnRgstChk; // 쿠폰 등록 진행 여부(진행 : 1, 종료 : 0)
	
	public UserCouponDto() {
		
	}
	
	public UserCouponDto(String couponId, String couponNm, int dscntRate,
			Date cupnRgstDt, Date cupnExpryDt, String cupnUseChk, Date cupnUseDt, String cupnRgstChk) {
		super();
		this.couponId = couponId;
		this.couponNm = couponNm;
		this.dscntRate = dscntRate;
		this.cupnRgstDt = cupnRgstDt;
		this.cupnExpryDt = cupnExpryDt;
		this.cupnUseChk = cupnUseChk;
		this.cupnUseDt = cupnUseDt;
		this.cupnRgstChk = cupnRgstChk;
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

	public Date getCupnRgstDt() {
		return cupnRgstDt;
	}

	public void setCupnRgstDt(Date cupnRgstDt) {
		this.cupnRgstDt = cupnRgstDt;
	}

	public Date getCupnExpryDt() {
		return cupnExpryDt;
	}

	public void setCupnExpryDt(Date cupnExpryDt) {
		this.cupnExpryDt = cupnExpryDt;
	}

	public String getCupnUseChk() {
		return cupnUseChk;
	}

	public void setCupnUseChk(String cupnUseChk) {
		this.cupnUseChk = cupnUseChk;
	}

	public Date getCupnUseDt() {
		return cupnUseDt;
	}

	public void setCupnUseDt(Date cupnUseDt) {
		this.cupnUseDt = cupnUseDt;
	}

	public String getCupnRgstChk() {
		return cupnRgstChk;
	}

	public void setCupnRgstChk(String cupnRgstChk) {
		this.cupnRgstChk = cupnRgstChk;
	}

	@Override
	public String toString() {
		return "UserCouponDto [couponId=" + couponId + ", couponNm=" + couponNm + ", dscntRate=" + dscntRate
				+ ", cupnRgstDt=" + cupnRgstDt + ", cupnExpryDt=" + cupnExpryDt + ", cupnUseChk=" + cupnUseChk
				+ ", cupnUseDt=" + cupnUseDt + ", cupnRgstChk=" + cupnRgstChk + "]";
	}
}
