package com.kdis.demo.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;


	
	@Service
	public class BoardService implements BoardDAO  {

	 @Inject
	 private BoardDAO dao;
	 
	 public List list() throws Exception {

	  return dao.list();
	 }
}
