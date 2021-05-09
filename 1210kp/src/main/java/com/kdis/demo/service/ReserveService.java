package com.kdis.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdis.demo.dao.ReserveDao;

@Service
public class ReserveService implements ReserveDao{
	@Autowired
	public ReserveDao reserveDao;
	
	public Long getCoupon(String couponName){
		return reserveDao.getCoupon(couponName);
	}
}
