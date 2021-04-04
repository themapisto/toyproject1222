package com.kdis.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.kdis.demo.vo.PaginationDto;
import com.kdis.demo.vo.UserVo;

@Repository
public interface AdminManageDao {

	List<UserVo> showAllUser(PaginationDto page) throws Exception;

	int countTotal(PaginationDto page) throws Exception;


}
