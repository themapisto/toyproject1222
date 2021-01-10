<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
	<%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp" %>

<h1>
	Hello 
</h1>
<p><a href="/board/list">게시물 목록</a></p>
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
