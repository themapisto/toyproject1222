package com.kdis.demo.dao;

import java.util.List;

import com.kdis.demo.vo.BoardVO;


public interface BoardDAO {
	 public List<BoardVO> list() throws Exception; 
}
