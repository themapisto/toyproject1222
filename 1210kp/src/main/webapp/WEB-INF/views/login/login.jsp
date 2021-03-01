<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>로그인</title>
	<link rel="stylesheet" href="/resources/css/default.css">
	<script src="https://code.jquery.com/jquery-3.5.1.js" type="text/javascript"></script>
	
	<!-- favicon -->
	<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/resources/images/favicon.ico" type="image/x-icon">
	<!-- /favicon -->
</head>
<body>
	<!-- header -->
	<header class="header">
		<div class="gnb">
			<div class="right">
				<c:choose>
					<c:when test="${sessionLoginChk eq 'user'}">
						<div class="afterLogin">
							<span title="회원이름">${sessionUserNm}</span>
							|
							<a href="/member/myInfo" title="마이페이지">마이페이지</a>
							|
							<a href="/login/logout" title="로그아웃">로그아웃</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="beforeLogin">
							<a href="/login/login" title="로그인">로그인</a>
							|
							<a href="/login/join" title="회원가입">회원가입</a>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="img">
			<a href="/">
				<img src="/resources/images/logo.png" alt="로고">
			</a>
		</div>
		<br>
		<div class="nav">
			<div class="navList">
				<button>
					<img src="/resources/images/menu.png" alt="사이트맵">
				</button>
				<ul>
					<li>
						<a href="#" title="예매">예매</a>
						<div style="display:none;">
							<ul style="opacity:0;">
								<li>
									<a href="#" title="예매하기">예매하기</a>
								</li>
								<li>
									<a href="#" title="상영시간표">상영시간표</a>
								</li>
							</ul>
						</div>	
					</li>
					<li>
						<a href="#" title="영화">영화</a>
						<div style="display:none;">
							<ul style="opacity:0;">
								<li>
									<a href="#" title="홈">홈</a>
								</li>
								<li>
									<a href="#" title="현재상영작">현재상영작</a>
								</li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</header>
<!-- /header -->
	<h2>MOVIE BOX 로그인</h2>
	<hr>
	<div class="loginContents">
		<h1>로그인</h1>
		<form id="loginForm" name="loginForm">
			<div class="inputBox">
				<label for="userId">아이디</label>
				<input type="text" id="userId" name="userId" title="아이디" onkeydown="javascript:if(event.keyCode == 13){loginChk(); return false;}">
			</div>
			<div class="inputBox">
				<label for="password">비밀번호</label>
				<input type="password" id="password" name="password" title="비밀번호" onkeydown="javascript:if(event.keyCode == 13){loginChk(); return false;}">
			</div>
		</form>
		<div id="loginMsg" data-id-flag="false" data-pw-flag="false"><span></span></div>
		<button type="button" title="로그인버튼" onclick="loginChk();">로그인</button>
		<div>
			<a href="javascript:window.open('/login/idSearchPopup','_blank','width=900px,height=500px');" title="아이디찾기">아이디 찾기</a>
			&nbsp;|&nbsp;
			<a href="javascript:window.open('/login/pwdSearchPopup','_blank','width=900px,height=500px');" title="비밀번호찾기">비밀번호 찾기</a>
			&nbsp;|&nbsp;
			<a href="/login/join" title="회원가입">회원가입</a>
		</div>
		
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
			
			var regType = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&-_`~]).*$/;	
			var regType2 = /^[^<>+=]*$/;
			
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
			
			var userId = document.getElementById("userId").value;
	    	var password = document.getElementById("password").value;
			
			var loginMsg = document.getElementById('loginMsg');
			
			if(loginMsg.dataset.idFlag == "true" && loginMsg.dataset.pwFlag == "true"){
				var xhr = new XMLHttpRequest();
				xhr.open("post","/login/loginSubmit",true);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == xhr.DONE){
						if(xhr.status == 200){
							var data = xhr.responseText;	
							data = JSON.parse(data);
							if(data.result == "success"){
								alert("로그인에 성공하셨습니다. 홈페이지로 이동합니다." );
								location.href="/";
							}else if(data.result == "locked"){
								alert("계정이 잠겼습니다. 관리자에게 문의하시거나 \n"+ data.loginFailTime + "에 다시 시도해주시기 바랍니다.");
								return false;
							}else if(data.result == "error"){
								//로그인실패횟수증감오류 에러페이지 호출
								return false;
							}else if(data.result == "loginFailLocked"){
								alert("로그인 실패 횟수가 5회가 되어 계정이 잠겼습니다.\n" + data.loginFailTime + "에 다시 시도해주시기 바랍니다.");
								return false;
							}else if(data.result == "userWithdrawal"){
								alert("탈퇴한 회원입니다.");
								return false;
							}else{
								alert("로그인을 "+data.result+"회 실패하였습니다. 로그인 5회 실패 시 계정이 잠깁니다.");
								return false;
							}
						}else{
							alert("요청 오류 : "+xhr.status);
						}
					}
				}
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				xhr.send("userId="+userId+"&password="+encodeURIComponent(password));
				
			}else if(loginMsg.dataset.idFlag == "false"){
				loginMsg.innerHTML = "<span style='color:red'> 아이디를 확인하세요.";
				return false;
			}else if(loginMsg.dataset.pwFlag == "false"){
				loginMsg.innerHTML = "<span style='color:red'> 비밀번호를 확인하세요.";
				return false;
			}else {
				// TODO : 에러페이지
				return false;
			}
				
			
		}
	</script>
</body>
</html>
