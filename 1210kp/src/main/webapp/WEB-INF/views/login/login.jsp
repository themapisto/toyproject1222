<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>로그인</title>
	<%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp" %>

	<h2>MOVIE BOX 로그인</h2>
	<hr>
	<div class="loginContents">
		<h1>로그인</h1>
		<form id="loginForm" name="loginForm" action="loginSubmit" method="post" onsubmit="return loginChk();">
			<div class="inputBox">
				<label for="userId">아이디</label>
				<input type="text" id="userId" name="userId" title="아이디" autofocus="on">
			</div>
			<div class="inputBox">
				<label for="password">비밀번호</label>
				<input type="password" id="password" name="password" title="비밀번호">
			</div>
			<div id="loginMsg" data-idFlag="false" data-pwFlag="false"><span></span></div>
			<button type="submit" title="로그인버튼">로그인</button>
			<div>
				<a href="#" title="아이디찾기">아이디 찾기</a>
				&nbsp;|&nbsp;
				<a href="#" title="비밀번호찾기">비밀번호 찾기</a>
				&nbsp;|&nbsp;
				<a href="/login/join" title="회원가입">회원가입</a>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
		document.getElementById('userId').addEventListener("blur",function(){
			var userId = document.getElementById('userId');
			var loginMsg = document.getElementById('loginMsg');
			
			var regType = /^.*(?=^.{5,20}$)[a-z0-9+]*$/;
			
			if(userId.value == ""){
				loginMsg.innerHTML = "<span style='color:red'>아이디를 입력하시기 바랍니다.</span>"
				loginMsg.dataset.idFlag = "false";
			}else{
				if(regType.test(userId.value)){
					loginMsg.innerHTML = "<span></span>"
					loginMsg.dataset.idFlag = "true";
				}else{
					loginMsg.innerHTML = "<span style='color:red'>아이디를 확인하시기 바랍니다.</span>"
					loginMsg.dataset.idFlag = "false";
				}
			}
		}); 
		
		document.getElementById('password').addEventListener("blur",function(){
			var password = document.getElementById('password');
			var loginMsg = document.getElementById('loginMsg');
			
			var regType = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;	
			var regType2 = /^[^<>]*$/;
			
			if(password.value == ""){
				loginMsg.innerHTML = "<span style='color:red'>비밀번호를 입력하시기 바랍니다.</span>"
				loginMsg.dataset.pwFlag = "false";
			}else{
				if(regType.test(password.value) && regType2.test(password.value)){
					loginMsg.innerHTML = "<span></span>"
					loginMsg.dataset.pwFlag = "true";
				}else{
					loginMsg.innerHTML = "<span style='color:red'>비밀번호를 확인하시기 바랍니다.</span>"
					loginMsg.dataset.pwFlag = "false";
				}
			}
		});
	
		function loginChk(){
			
			var loginMsg = document.getElementById('loginMsg');
			
			if(loginMsg.dataset.idFlag == "true" && loginMsg.dataset.pwFlag == "true"){
				return;
			}else if(loginMsg.dataset.idFlag == "false"){
				loginMsg.innerHTML = "<span style='color:red'> 아이디를 확인하세요.";
				return false;
			}else if(loginMsg.dataset.pwFlag == "false"){
				loginMsg.innerHTML = "<span style='color:red'> 비밀번호를 확인하세요.";
				return false;
			}else {
				
			}
				
			
		}
	</script>
</body>
</html>
