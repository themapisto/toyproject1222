package com.kdis.demo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kdis.demo.vo.UserVO;

@Repository
public interface AdminManageDao {

	List<UserVO> showAllUser() throws Exception;


}
