package com.kdis.demo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.kdis.demo.vo.CouponVO;
import com.kdis.demo.vo.PaginationDto;
import com.kdis.demo.vo.UserVo;

@Repository
public interface MemberDao {

	public UserVo selectMyInfo(Map<String, Object> paramMap) throws Exception;

	public int updateMyInfo(HashMap<String, Object> paramMap) throws Exception;

	public int updatePwd(HashMap<String, Object> paramMap) throws Exception;

	public int userWithdrawal(HashMap<String,Object> paramMap) throws Exception;
	
	public int updateUserState(HashMap<String,Object> paramMap) throws Exception;
	
	public CouponVO selectCouponInfo(String couponId) throws Exception;
	
	public int insertCouponRegister(HashMap<String, Object> paramMap) throws Exception;

	public List<HashMap<String, Object>> selectMyCoupon(HashMap<String, Object> paramMap) throws Exception;
	
	List<UserVo> showAllUser(PaginationDto page) throws Exception;

	int countTotal(PaginationDto page) throws Exception;

	public int modifyState(UserVo user) throws Exception;

	public List<UserVo> showAllAdmin(PaginationDto page) throws Exception;
	
	public int countAdmin(PaginationDto page) throws Exception;

	public int deleteAdmin(UserVo user) throws Exception;
}
