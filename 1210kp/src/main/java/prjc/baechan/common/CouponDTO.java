package prjc.baechan.common;

import java.util.Date;

public class CouponDTO {

	private String couponId;			// 쿠폰ID
	private String couponNm;			// 쿠폰이름
	private int dscntRate;				// 할인율
	private String registStartDt;			// 쿠폰등록시작일자
	private String registEndDt;			// 쿠폰등록만료일자
	private String registChk;			// 쿠폰등록진행여부(1.진행 2.종료)
	private int usePeriod;				// 쿠폰사용가능기간(userCoupon 쿠폰만료일자 - 쿠폰등록일자) 
	private String couponChk;			// 쿠폰삭제여부(Y.삭제 N.삭제x)
	
	public String getCouponId() {
		return couponId;
	}
	public String getCouponNm() {
		return couponNm;
	}
	public int getDscntRate() {
		return dscntRate;
	}
	public String getRegistStartDt() {
		return registStartDt;
	}
	public String getRegistEndDt() {
		return registEndDt;
	}
	public String getRegistChk() {
		return registChk;
	}
	public int getUsePeriod() {
		return usePeriod;
	}
	public String getCouponChk() {
		return couponChk;
	}
	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}
	public void setCouponNm(String couponNm) {
		this.couponNm = couponNm;
	}
	public void setDscntRate(int dscntRate) {
		this.dscntRate = dscntRate;
	}
	public void setRegistStartDt(String registStartDt) {
		this.registStartDt = registStartDt;
	}
	public void setRegistEndDt(String registEndDt) {
		this.registEndDt = registEndDt;
	}
	public void setRegistChk(String registChk) {
		this.registChk = registChk;
	}
	public void setUsePeriod(int usePeriod) {
		this.usePeriod = usePeriod;
	}
	public void setCouponChk(String couponChk) {
		this.couponChk = couponChk;
	}
	
}
