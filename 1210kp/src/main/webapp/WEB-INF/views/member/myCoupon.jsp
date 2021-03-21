<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>나의 쿠폰 내역</title>
	<%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<%@include file="/WEB-INF/views/common/sidebar.jsp" %>
	
	<div class="myInfoContents">
		<div>
			<button type="button" class="couponUseViewBtn" id="able">사용가능한 쿠폰</button>
			<button type="button" class="couponUseViewBtn" id="unable">종료된 쿠폰</button>
		</div>
		<span style="position:relative;left:90px;">*1년 이내의 정보만 제공합니다.</span>
		
		<table id="ableList" class="userTable on">
		    <thead>
		        <tr>
		            <th scope="col">쿠폰번호</th>
		            <th scope="col">쿠폰명</th>
		            <th scope="col">할인금액</th>
		            <th scope="col">유효기간</th>
		            <th scope="col">사용여부</th>
		        </tr>
		    </thead>
		    <tbody>
		    	<c:forEach items="${list}" var="coupon" varStatus="status">
		    		<c:if test="${coupon.useChk eq 1}">
				        <tr>
				            <td>${coupon.couponId}</td>
				            <td>${coupon.couponNm}</td>
				            <td>${coupon.dscntRate}%</td>
				            <td>
				            	<fmt:formatDate value="${coupon.registDt}" pattern="yyyy-MM-dd"/>
				            	~
				            	<fmt:formatDate value="${coupon.expireDt}" pattern="yyyy-MM-dd"/>
				            </td>
				        	<td>
				        		<c:choose>
				        			<c:when test="${coupon.useChk eq 1}">사용가능</c:when>
				        			<c:when test="${coupon.useChk eq 2}">사용완료</c:when>
				        			<c:when test="${coupon.useChk eq 3}">기간만료</c:when>
			        			</c:choose>
							</td>
				        </tr>
			        </c:if>
		        </c:forEach>
		    </tbody>
		</table>
		
		<table id="unableList" class="userTable off">
		    <thead>
		        <tr>
		            <th scope="col">쿠폰번호</th>
		            <th scope="col">쿠폰명</th>
		            <th scope="col">할인금액</th>
		            <th scope="col">유효기간</th>
		            <th scope="col">사용여부</th>
		            <th scope="col">사용일자</th>
		        </tr>
		    </thead>
		    <tbody>
		    	<c:forEach items="${list}" var="coupon" varStatus="status">
		    		<fmt:formatDate var="registDt" value="${coupon.registDt}" pattern="yyyy-MM-dd"/>
		    		<fmt:formatDate var="expireDt" value="${coupon.expireDt}" pattern="yyyy-MM-dd"/>
		    		<fmt:formatDate var="useDt" value="${coupon.useDt}" pattern="yyyy-MM-dd"/>
		    		
		    		<c:if test="${(coupon.useChk eq 2 && useDt gt todayMinusOneYear)
		    						|| (coupon.useChk eq 3 && expireDt gt todayMinusOneYear)}">
				        <tr>
				            <td>${coupon.couponId}</td>
				            <td>${coupon.couponNm}</td>
				            <td>${coupon.dscntRate}%</td>
				            <td>${registDt}~${expireDt}</td>
				        	<td>
				        		<c:choose>
				        			<c:when test="${empty useDt && today gt expireDt}">기간만료</c:when>
				        			<c:when test="${empty useDt}">사용가능</c:when>
				        			<c:when test="${!empty useDt}">사용완료</c:when>
			        			</c:choose>
							</td>
				            <td>${useDt}</td>
				        </tr>
			        </c:if>
		        </c:forEach>
		    </tbody>
		</table>
	</div>

	<script type="text/javascript">
		window.onload = function(){
 			
			var able = document.getElementById('able');
			var unable = document.getElementById('unable');
			var ableList = document.getElementById('ableList');
			var unableList = document.getElementById('unableList');
			
			able.style.backgroundColor = '#034f84';
		};
		
		unable.addEventListener('click',function(){
			unable.style.backgroundColor = '#034f84';
			able.style.backgroundColor = '#7aa5d2';
			ableList.className = 'userTable off';
			unableList.className = 'userTable on';
		})

		able.addEventListener('click',function(){
			unable.style.backgroundColor = '#7aa5d2';
			able.style.backgroundColor = '#034f84';
			unableList.className = 'userTable off';
			ableList.className = 'userTable on';
		})   	
	</script>
</body>
</html>