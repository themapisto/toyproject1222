package com.kdis.demo.vo;

import java.util.Date;
import java.util.List;

public class UserCouponVO {

	private int userCouponId;			// �쉶�썝�벑濡앹퓼�룿ID
	private String couponId;			// 荑좏룿踰덊샇
	private String userId;				// �쉶�썝�븘�씠�뵒
	private Date registDt;				// 荑좏룿�벑濡앹씪�옄
	private Date expireDt;				// 荑좏룿留뚮즺�씪�옄
	private String useChk;				// 荑좏룿�궗�슜�뿬遺�(1.�궗�슜媛��뒫 2.留뚮즺)
	private Date useDt;					// 荑좏룿�궗�슜�씪�옄
	
	private String couponNm;			// 荑좏룿�씠由�
	private int dscntRate;				// �븷�씤�쑉
	private List<UserCouponDto> list;
	
	public List<UserCouponDto> getList() {
		return list;
	}
	public void setList(List<UserCouponDto> list) {
		this.list = list;
	}
	public int getUserCouponId() {
		return userCouponId;
	}
	public String getCouponId() {
		return couponId;
	}
	public String getUserId() {
		return userId;
	}
	public Date getRegistDt() {
		return registDt;
	}
	public Date getExpireDt() {
		return expireDt;
	}
	public String getUseChk() {
		return useChk;
	}
	public Date getUseDt() {
		return useDt;
	}
	
	public String getCouponNm() {
		return couponNm;
	}
	public int getDscntRate() {
		return dscntRate;
	}
	
}
