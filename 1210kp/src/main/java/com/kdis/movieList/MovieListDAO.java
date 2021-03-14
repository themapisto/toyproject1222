package com.kdis.movieList;
import com.kdis.movieList.MovieVO;
import java.util.List;

public interface MovieListDAO {

	public List<MovieVO> list(String movieVal, String insertDt) throws Exception; 
		
 }


