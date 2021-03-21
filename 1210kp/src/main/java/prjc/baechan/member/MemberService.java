package prjc.baechan.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import prjc.baechan.common.CouponVO;
import prjc.baechan.common.UserCouponVO;
import prjc.baechan.common.UserVO;
import prjc.baechan.common.paginationDTO;

@Service
public class MemberService implements MemberDAO{
	@Inject
	private MemberDAO MemberDAO;
	 
	public UserVO selectMyInfo(Map<String,Object> paramMap) throws Exception{
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

	public CouponVO selectCouponInfo(String couponId) throws Exception{
		return MemberDAO.selectCouponInfo(couponId);
	}

	public int insertCouponRegister(HashMap<String, Object> paramMap) throws Exception {
		return MemberDAO.insertCouponRegister(paramMap);
	}

	public List<HashMap<String,Object>> selectMyCoupon(HashMap<String, Object> paramMap) throws Exception {
		return MemberDAO.selectMyCoupon(paramMap);
	}

	public int countTotal(HashMap<String, Object> paramMap) throws Exception{
		return MemberDAO.countTotal(paramMap);
	}

}