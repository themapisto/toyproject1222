package prjc.baechan.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import prjc.baechan.common.UserVO;

@Repository
public interface MemberDAO {

	public UserVO selectMyInfo(Map<String, Object> paramMap) throws Exception;

	public int updateMyInfo(HashMap<String, Object> paramMap) throws Exception;

	public int updatePwd(HashMap<String, Object> paramMap) throws Exception;

	public int userWithdrawal(HashMap<String,Object> paramMap) throws Exception;
	
	public int updateUserState(HashMap<String,Object> paramMap) throws Exception;
}
