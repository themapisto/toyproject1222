package com.kdis.demo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kdis.demo.dao.BoardDAO;


	
	@Service
	public class BoardService implements BoardDAO  {

	 @Inject
	 private BoardDAO dao;
	 
	 public List list() throws Exception {

	  return dao.list();
	 }
}
