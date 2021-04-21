package com.kdis.demo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kdis.demo.dao.AdminManageDao;
import com.kdis.demo.vo.UserVO;

@Service
public class AdminManageService implements AdminManageDao{
	@Inject
	private AdminManageDao adminManagerDao;
	
	public List<UserVO> showAllUser() throws Exception {
		return adminManagerDao.showAllUser();
	}

	
}
