package com.kdis.demo.dao;

import java.util.List;

import com.kdis.demo.vo.UserCouponDto;

public interface ReserveDao {
	// 쿠폰 번호 조회
	public List<UserCouponDto> getCoupon(String userId);
}
