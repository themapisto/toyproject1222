package com.kdis.movieList;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class MovieListService { 

	@Inject
	private MovieListDAO dao;

	public List<MovieVO> list() throws Exception {
		return dao.list();
	}

}
