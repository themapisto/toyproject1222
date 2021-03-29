package com.kdis.demo.vo;

import java.util.Date;

public class UserCouponDto {
	private String couponId; // 쿠폰번호
	private String couponNm; // 쿠폰이름
	private int dscntRate; // 할인율
	private Date registDt; // user의 쿠폰 등록일
	private Date expireDt; // user의 쿠폰 만료일
	private String useChk; // user의 쿠폰 사용 여부
	private Date useDt; // user의 쿠폰 사용일
	private String registChk; // 관리자가 쿠폰 사용 등록했는지 확인
	
	public UserCouponDto() {
		
	}
	
	public UserCouponDto(String couponId, String couponNm, int dscntRate,
			Date registDt, Date expireDt, String useChk, Date useDt, String registChk) {
		super();
		this.couponId = couponId;
		this.couponNm = couponNm;
		this.dscntRate = dscntRate;
		this.registDt = registDt;
		this.expireDt = expireDt;
		this.useChk = useChk;
		this.useDt = useDt;
		this.registChk = registChk;
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

	public Date getRegistDt() {
		return registDt;
	}

	public void setRegistDt(Date registDt) {
		this.registDt = registDt;
	}

	public Date getExpireDt() {
		return expireDt;
	}

	public void setExpireDt(Date expireDt) {
		this.expireDt = expireDt;
	}

	public String getUseChk() {
		return useChk;
	}

	public void setUseChk(String useChk) {
		this.useChk = useChk;
	}

	public Date getUseDt() {
		return useDt;
	}

	public void setUseDt(Date useDt) {
		this.useDt = useDt;
	}

	public String getRegistChk() {
		return registChk;
	}

	public void setRegistChk(String registChk) {
		this.registChk = registChk;
	}

	@Override
	public String toString() {
		return "UserCouponDto [couponId=" + couponId + ", couponNm=" + couponNm + ", dscntRate=" + dscntRate
				+ ", registDt=" + registDt + ", expireDt=" + expireDt + ", useChk=" + useChk
				+ ", useDt=" + useDt + ", registChk=" + registChk + "]";
	}
}
