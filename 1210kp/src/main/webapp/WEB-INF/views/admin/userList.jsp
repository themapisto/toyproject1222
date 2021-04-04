<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>

<title>회원관리 리스트</title>
<link href="/resources/css/default.css?h" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.5.1.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/admin/header.jsp" %>
<%@include file="/WEB-INF/views/admin/sidebar.jsp" %>
<form id="filter" name="filter" method="get" action="/admin/userList">
		&nbsp;&nbsp;<select id="option" name="option">
			<option value="userNm" ${pageDto.option eq userNm? selected:"" }>이름</option>
			<option value="userId" ${pageDto.option eq userId? selected:"" }>아이디</option>
		</select>
		<input type="text" id="keyword" name="keyword" value="${pageDto.keyword}">
    <button type="button" onclick="searchChk()">검색</button>
</form>
<table id="userTable">
    <colgroup>
        <col style="width:10%;">
        <col style="width:10%;">
        <col style="width:15%;">
        <col style="width:20%;">
        <col style="width:20%;">
        <col style="width:25%;">
    </colgroup>

    <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">회원등급</th>
            <th scope="col">이름</th>
            <th scope="col">아이디</th>
            <th scope="col">회원상태(가입/탈퇴/잠김/휴면)</th>
            <th scope="col">가입일자</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach items="${userList}" var="user" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>일반회원</td>
            <td>${user.userNm}</td>
            <td>${user.userId}</td>
            <td>
            	<c:choose>
					<c:when test="${user.userState eq 1}">가입</c:when>
					<c:when test="${user.userState eq 8}">잠금</c:when>
					<c:when test="${user.userState eq 9}">탈퇴</c:when>
					<c:otherwise>휴면</c:otherwise>
				</c:choose>
            </td>
            <td>
            	<fmt:formatDate value="${user.regDt}" pattern="yyyy-MM-dd"/>
            </td>
        </tr>
        </c:forEach>   
    </tbody>
</table>
<div style="display: block; text-align: center;">		
		<c:if test="${pageDto.prev == true }">
			<a href="/admin/userList?keyword=${pageDto.keyword}&option=${pageDto.option}&page=${pageDto.startPage - 1 }">&lt;</a>
		</c:if>
		<c:forEach begin="${pageDto.startPage}" end="${pageDto.endPage}" var="p">
			<c:choose>
				<c:when test="${p == pageDto.page}">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != pageDto.page}">
					<a href="/admin/userList?keyword=${pageDto.keyword}&option=${pageDto.option}&page=${p }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${pageDto.next == true}">
			<a href="/admin/userList?keyword=${pageDto.keyword}&option=${pageDto.option}&page=${pageDto.endPage+1 }">&gt;</a>
		</c:if>
	</div>

<script type="text/javascript">
    
    function searchChk(){
		var option = document.getElementById("option").value;
		if(option!=""){
			filter.submit();
		}else{
			alert("검색어를 입력해주세요" );
		}	
    }
</script>
</body>
</html>