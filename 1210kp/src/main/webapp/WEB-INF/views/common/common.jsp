<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- common -->
	<link href="/css/baechan.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.5.1.js" type="text/javascript"></script>
	
	<!-- favicon -->
	<link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/image/favicon.ico" type="image/x-icon">
	<!-- /favicon -->
	
	<c:set var ="now" value="<%=new Date()%>"/>
	<c:set var="todayMinusOneYear" value="<%=new Date(new Date().getTime() - 60*60*24*1000*365L) %>"/>

	<fmt:formatDate type="date" var="today" value="${now}" pattern="yyyy-MM-dd"/>
	<fmt:formatDate type="date" var="todayMinusOneYear" value="${todayMinusOneYear}" pattern="yyyy-MM-dd"/>

<!-- /common -->