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
	
	<div class="navi">
		<li class='blue'>회원정보</li>
		<li><a href="/member/myInfo">회원정보</a></li>
	    <li><a href="/">home</a></li>
	</div>
	<br><hr>
	
	<div class="myInfoContents">
		<h1>회원정보</h1>
		<table>
			<colgroup>
				<col style="width: 20%">
				<col style="width: 30%">
				<col style="width: 20%">
				<col style="width: 30%">
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td>${userVO.userId}</td>
					<th>회원등급</th>
					<td>${userVO.grade}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${userVO.userNm}</td>
					<th>생년월일</th>
					<td>${userVO.birthday}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${userVO.email}</td>
					<th>핸드폰번호</th>
					<td>${userVO.phoneNumber}</td>
				</tr>
			</tbody>
		</table>
		<a href="/member/userWithdrawal">회원탈퇴</a>
		<a href="/member/pwdChange">비밀번호 변경</a>
		<a href="/member/myInfoModify">회원정보 수정</a>
	</div>
</body>
</html>