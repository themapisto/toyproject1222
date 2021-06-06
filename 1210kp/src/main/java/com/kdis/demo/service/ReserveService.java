package com.kdis.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdis.demo.dao.ReserveDao;
import com.kdis.demo.vo.UserCouponDto;

@Service
public class ReserveService implements ReserveDao{
	@Autowired
	public ReserveDao reserveDao;
	
	public List<UserCouponDto> getCoupon(String userId){
		return reserveDao.getCoupon(userId);
	}
}
