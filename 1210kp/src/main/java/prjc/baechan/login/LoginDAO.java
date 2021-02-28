package prjc.baechan.login;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface LoginDAO{
	
	public Integer userJoin(Map<String, Object> paramMap) throws Exception;

	public Integer idCheck(String userId) throws Exception;

	public Integer loginSubmit(HashMap<String, Object> paramMap) throws Exception;

	public String getUserSalt(String userId) throws Exception;

	public String searchIdChk(HashMap<String, Object> paramMap) throws Exception; 
	
	public String searchPwdChk(HashMap<String, Object> paramMap) throws Exception; 

	public Integer updateLoginFailCount(HashMap<String, Object> paramMap) throws Exception;
	
	public Integer insertLoginHistory(Map<String,Object> paramMap) throws Exception;

	public Integer adminLoginSubmit(HashMap<String, Object> paramMap) throws Exception;

}
