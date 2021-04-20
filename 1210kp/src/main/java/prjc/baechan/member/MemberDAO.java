package prjc.baechan.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import prjc.baechan.common.CouponVO;
import prjc.baechan.common.UserVO;

@Repository
public interface MemberDAO {

	public UserVO selectMyInfo(Map<String, Object> paramMap) throws Exception;

	public int updateMyInfo(HashMap<String, Object> paramMap) throws Exception;

	public int updatePwd(HashMap<String, Object> paramMap) throws Exception;

	public int userWithdrawal(HashMap<String,Object> paramMap) throws Exception;
	
	public int updateUserState(HashMap<String,Object> paramMap) throws Exception;
	
	public CouponVO selectCouponInfo(String couponId) throws Exception;
	
	public int insertCouponRegister(HashMap<String, Object> paramMap) throws Exception;

	public ArrayList<HashMap<String, Object>> selectMyCoupon(HashMap<String, Object> paramMap) throws Exception;
	
	public int countTotal(HashMap<String, Object> paramMap) throws Exception;

}
