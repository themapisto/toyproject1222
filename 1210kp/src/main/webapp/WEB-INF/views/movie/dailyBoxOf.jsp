<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>마이페이지</title>
	
	
	<link rel="stylesheet" href="/resources/css/list.css" type="text/css">
	<%@include file="/WEB-INF/views/common/common.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>

	


	<h2>MOVIE LIST 검색 </h2>
	<div class="header">
		<div>
			<a href="/movie/dailyBoxOf" title="일별 박스오피스">일별 박스오피스</a>
		&nbsp;|&nbsp;
			<a href="/movie/movieMain" title="주간 박스오피스">주간 박스오피스</a>
		&nbsp;|&nbsp;
		</div>
	</div> 
	<!-- thumnail -->
	<div>


			
			
		    <c:forEach items="${list}" var="list">
		    
		    <ol id="list" style="display:inline-block; width:15%">
		    
			<img src="${list.image}"  class="img-thumbnail">
			<button type="button" class="btn btn-light" style= "position:static; width:100%">예매</button>
			
			</ol>
			
			</c:forEach>
			

			
		
	</div>
</body>




<script type="text/javascript">


// ajax 기본
 /*    $(document).ready(function(){
    	getMovieList();
    })
    
	function getMovieList(){
		
		$.ajax({
		  url: '/movie/movieList',
		  data: {},
		  success: function(d){
			  console.log("hello")
		  }
		})
		
	} */

	
	
</script>



</html>

