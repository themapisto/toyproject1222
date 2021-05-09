package com.kdis.demo.service;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kdis.demo.dao.LoginDao;

@Service
public class LoginService implements LoginDao{

	@Inject
	private LoginDao LoginDAO;
	 
	public Integer userJoin(Map<String, Object> paramMap) throws Exception{
		return LoginDAO.userJoin(paramMap);
	}

	public Integer idCheck(String userId) throws Exception {
		return LoginDAO.idCheck(userId);
	}

	public Integer loginSubmit(HashMap<String, Object> paramMap) throws Exception{
		return LoginDAO.loginSubmit(paramMap);
	}

	public String getUserSalt(String userId) throws Exception {
		return LoginDAO.getUserSalt(userId);
	}

	public String searchIdChk(HashMap<String, Object> paramMap) throws Exception{
		return LoginDAO.searchIdChk(paramMap);
	}
	
	public String searchPwdChk(HashMap<String, Object> paramMap) throws Exception{
		return LoginDAO.searchPwdChk(paramMap);
	}
	
	public Integer updateLoginFailCount(HashMap<String, Object> paramMap) throws Exception {
		return LoginDAO.updateLoginFailCount(paramMap);
	}

	@Override
	public Integer insertLoginHistory(Map<String, Object> paramMap) throws Exception {
		return LoginDAO.insertLoginHistory(paramMap);
	}

	public Integer adminLoginSubmit(HashMap<String, Object> paramMap) throws Exception {
		return LoginDAO.adminLoginSubmit(paramMap);
	}
	

}
