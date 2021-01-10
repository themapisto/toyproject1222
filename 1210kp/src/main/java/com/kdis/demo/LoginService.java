package com.kdis.demo;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class LoginService implements LoginDAO{

	@Inject
	private LoginDAO LoginDAO;
	 
	public Integer userJoin(Map<String, Object> paramMap) throws Exception{
		return LoginDAO.userJoin(paramMap);
	}

	public Integer idCheck(String userId) throws Exception {
		return LoginDAO.idCheck(userId);
	}

	public Integer loginSubmit(HashMap<String, Object> paramMap) throws Exception{
		return LoginDAO.loginSubmit(paramMap);
	}
	

}
