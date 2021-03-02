package com.kdis.demo.service;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kdis.demo.dao.MemberDao;
import com.kdis.demo.vo.UserVo;

@Service
public class MemberService implements MemberDao{
	@Inject
	private MemberDao MemberDAO;
	 
	public UserVo selectMyInfo(Map<String,Object> paramMap) throws Exception{
		return MemberDAO.selectMyInfo(paramMap);
	}

	public int updateMyInfo(HashMap<String, Object> paramMap) throws Exception {
		return MemberDAO.updateMyInfo(paramMap);
	}

	public int updatePwd(HashMap<String, Object> paramMap) throws Exception{
		return MemberDAO.updatePwd(paramMap);
	}
	
	public int userWithdrawal(HashMap<String,Object> paramMap) throws Exception{
		return MemberDAO.userWithdrawal(paramMap);
	}
	
	public int updateUserState(HashMap<String,Object> paramMap) throws Exception{
		return MemberDAO.updateUserState(paramMap);
	}

}