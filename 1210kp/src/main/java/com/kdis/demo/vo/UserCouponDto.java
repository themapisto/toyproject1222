package com.kdis.demo.vo;

import java.util.Date;

public class UserCouponDto {
	private String couponId; // 荑좏룿 踰덊샇
	private String couponNm; // 荑좏룿 �씠由�
	private int dscntRate; // �븷�씤�쑉
	private Date registDt; // user�쓽 荑좏룿 �벑濡� �씪�옄
	private Date expireDt; // user�쓽 荑좏룿 醫낅즺 �씪�옄
	private String useChk; // user�쓽 荑좏룿 �궗�슜 �뿬遺�(誘몄궗�슜: 0, �궗�슜: 1)
	private Date useDt; // user�쓽 荑좏룿 �궗�슜 �씪�옄
	private String registChk; // 荑좏룿 �벑濡� 吏꾪뻾 �뿬遺�(吏꾪뻾 : 1, 醫낅즺 : 0)
	
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
