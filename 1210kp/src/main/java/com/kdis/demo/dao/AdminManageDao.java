package com.kdis.demo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kdis.demo.vo.UserVo;

@Repository
public interface AdminManageDao {

	List<UserVo> showAllUser() throws Exception;


}
