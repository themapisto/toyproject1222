<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- header -->
	<header class="adminHeader">
	    <span>MOVIEBOX 관리자 사이트</span>
	    <span class="right">
	    	<c:choose>
				<c:when test="${sessionLoginChk eq 'admin'}">
					<div class="afterLogin">
						<span title="관리자이름">${sessionUserNm}</span>
						|
						<a href="#" title="로그아웃">로그아웃</a>
					</div>
				</c:when>
			</c:choose>
	    </span>
	</header>
<!-- /header -->
