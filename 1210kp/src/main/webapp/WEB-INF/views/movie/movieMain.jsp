<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>마이페이지</title>
	<%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<%@include file="/WEB-INF/views/common/sidebar.jsp" %>
	<link rel="stylesheet" href="/resources/css/list.css" type="text/css">


	<h2>MOVIE LIST 검색 </h2>
	<div class=header">
		<div>
			<a href="javascript:window.open('/movie/dailyBoxOf','_blank','width=1000px,height=500px');" title="일별 박스오피스">일별 박스오피스</a>
			&nbsp;|&nbsp;
			<a href="javascript:window.open('/movie/weeklyBoxOf','_blank','width=1000px,height=500px');" title="주간 박스오피스">주간 박스오피스</a>
			&nbsp;|&nbsp;
		</div>
	</div> 
	<!-- thumnail -->
	<div>
		<ol class="list" id="movieList">
		    <c:forEach items="${list}" var="list">
			<img src="${list.image}"  class="img-thumbnail">
			</c:forEach>
			
		</ol>
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

