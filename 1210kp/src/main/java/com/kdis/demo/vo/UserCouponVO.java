package com.kdis.demo.vo;

import java.util.Date;

public class UserCouponVO {

	private int userCouponId;			// 회원등록쿠폰ID
	private String couponId;			// 쿠폰번호
	private String userId;				// 회원아이디
	private Date registDt;				// 쿠폰등록일자
	private Date expireDt;				// 쿠폰만료일자
	private String useChk;				// 쿠폰사용여부(1.사용가능 2.만료)
	private Date useDt;					// 쿠폰사용일자
	
	private String couponNm;			// 쿠폰이름
	private int dscntRate;				// 할인율
	
	
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
