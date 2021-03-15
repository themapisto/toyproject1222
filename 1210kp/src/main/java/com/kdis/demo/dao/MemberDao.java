package com.kdis.demo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.kdis.demo.vo.UserVo;

@Repository
public interface MemberDao {

	public UserVo selectMyInfo(Map<String, Object> paramMap) throws Exception;

	public int updateMyInfo(HashMap<String, Object> paramMap) throws Exception;

	public int updatePwd(HashMap<String, Object> paramMap) throws Exception;

	public int userWithdrawal(HashMap<String,Object> paramMap) throws Exception;
	
	public int updateUserState(HashMap<String,Object> paramMap) throws Exception;

	public List<UserVo> showAllUser(String grade) throws Exception;
}
