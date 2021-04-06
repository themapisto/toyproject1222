package com.kdis.movieList;
import com.kdis.movieList.MovieVO;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface MovieListDAO {

	public List<MovieVO> list(@Param("movieVal")String movieVal, @Param("insertDt")String insertDt) throws Exception;

	public MovieVO listOne(String rank); 
		
 }


