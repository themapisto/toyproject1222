<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>

<title>회원관리 리스트</title>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>    

</head>
<body>
<form id="filter" name="filter">
    &nbsp;&nbsp;회원등급 :
    <select id="grade">
        <option value="all">전체</option>
        <option value="1">일반회원</option>
        <option value="2">관리자</option>
    </select>
    이름 :<input type="text" id="userName" name="userName">
    아이디 :<input type="text" id="userId" name="userId">
    회원상태 :
    <select id="state" name="state">
        <option value="all">전체</option>
        <option value="1">가입</option>
        <option value="2">탈퇴</option>
        <option value="3">잠김</option>
    </select>
    가입일자 :
    <span>
        <input type="text" id="datepickerStart" readonly >
        ~
        <input type="text" id="datepickerEnd" readonly >
    </span>
    
    
    <button type="button">검색</button>
</form>    
<table class="userTable">
    <colgroup>
        <col style="width:10%;">
        <col style="width:10%;">
        <col style="width:15%;">
        <col style="width:30%;">
        <col style="width:20%;">
        <col style="width:15%;">
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
        <tr align: "center">
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


<script type="text/javascript">
    $("#datepickerStart, #datepickerEnd").datepicker({
        dateFormat:'yy-mm-dd',
        changeYear:true,
        changeMonth:true
    });
</script>
</body>
</html>