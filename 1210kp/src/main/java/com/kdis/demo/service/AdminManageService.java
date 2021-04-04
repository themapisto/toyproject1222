package com.kdis.demo.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kdis.demo.dao.AdminManageDao;
import com.kdis.demo.vo.PaginationDto;
import com.kdis.demo.vo.UserVo;

@Service
public class AdminManageService implements AdminManageDao{
	@Inject
	private AdminManageDao adminManagerDao;
	
	public List<UserVo> showAllUser(PaginationDto page) throws Exception {
		return adminManagerDao.showAllUser(page);
	}

	public int countTotal(PaginationDto page) throws Exception{
		return adminManagerDao.countTotal(page);
	}

	

	

	
}
