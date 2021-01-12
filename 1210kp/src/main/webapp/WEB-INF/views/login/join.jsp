<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>회원가입</title>
	<%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
	<h2>MOVIE BOX 회원가입</h2>	
	<hr>
	<span>* 표시는 필수 항목입니다.</span>
	<button class="right button" style="position:relative;right:10%;" 
			type="button" onclick="javascript:history.back();">뒤로가기</button>
	
	<br><br><br>
	<div class="joinContents">
		<h1>MOVIE BOX <br> 회원가입</h1>
		<form id="joinForm" name="joinForm" action="joinSubmit" method="post" onsubmit='return joinCheck();'>
			<div class="inputBox">
				<label for="userId">*&nbsp;아이디</label>
				<input type="text" id="userId" name="userId" title="아이디" autofocus="on" maxlength="20">
			</div>
			<div id="idMsg" data-flag="false"><span>아이디는 5~20자의 영문 소문자,숫자만 사용 가능합니다.</span></div>
			
			<div class="inputBox">
				<label for="password">*&nbsp;비밀번호</label>
				<input type="password" id="password" name="password" title="비밀번호" oninput="pwChkMsgChange();">
			</div>
			<div id="pwMsg" data-flag="false"><span>8~16자 영문 소문자, 숫자, 특수문자를 3개 이상 사용하세요.</span></div>
			
			<div class="inputBox">
				<label for="pwChk">*&nbsp;비밀번호 재확인</label>
				<input type="password" id="pwChk" name="pwChk" title="비밀번호 재확인" oninput="pwChkMsgChange();">	
			</div>
			<div id="pwChkMsg" data-flag="false"></div>		
			
			<div class="inputBox">
				<label for="userNm">*&nbsp;이름</label>
				<input type="text" id="userNm" name="userNm" title="이름">
			</div>
			<div id="nmMsg" data-flag="false"></div>	
			
			<div class="inputBox">
				<label for="birthday">*&nbsp;생년월일</label>
				<input type="date" id="birthday" name="birthday" title="생년월일">
			</div>
			<div id="birthdayMsg" data-flag="false"></div>	
			
			<!-- 생일도 체크해야함 현재날짜보다적게 -->
			<div class="inputBox">
				<label for="email">이메일</label>
				<input type="email" id="email" name="email" title="이메일">
			</div>
			<div id="emailMsg" data-flag="true"></div>	
			
			<div class="inputBox">
				<label for="phoneNumber">핸드폰 번호</label>
				<input type="tel" id="phoneNumber" name="phoneNumber" title="전화번호">
			</div>
			<div id="phoneNumberMsg" data-flag="true"></div>	
			
			<button type="submit" title="가입하기버튼">가입하기</button>
			<!--  가입하기 후 alert으로 가입완료창 띄운 후 로그인페이지 이동 -->
		</form>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){

		});
		function showMsg(object, msg, successAndFail){
			if(successAndFail == "fail"){
				object.innerHTML = "<span style='color:red'>"+msg+"</span>";
				object.dataset.flag = "false";
			}else if(successAndFail == "success"){
				object.innerHTML = "<span style='color:green'>"+msg+"</span>";
				object.dataset.flag = "true";
			}else{
				object.innerHTML = "<span></span>";
				object.dataset.flag = "true";
			}
		}
		
		function regex(object){
			var regType = "";
			var regType2 = "";
			
			if(object == userId){
				regType = /^.*(?=^.{5,20}$)[a-z0-9+]*$/;
			}else if(object == password){
				regType = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;	
				regType2 = /^[^<>]*$/;
			}else if(object == userNm){
			 	regType = /^([가-힣]+|[a-zA-Z]+)$/
			}else if(object == email){
			 	regType = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z^<>]{2,3}$/i;
			}else if(object == phoneNumber){
				regType= /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/
			}else{
				// TODO : 에러페이지
			}
			
			if(regType.test(object.value)){
				if(object == password){
					if(regType2.test(object.value)){
						return true;
					}else{
						return false;
					}
				}
				return true;
			} else{
				return false;
			}
		}
		
		document.getElementById('userId').addEventListener("blur",function(){
			var userId = document.getElementById('userId');
			var idMsg = document.getElementById('idMsg');
			if(userId.value == ""){
				showMsg(idMsg,"아이디를 입력하시기 바랍니다.","fail");
			}else{
				if(regex(userId)){
					idCheck(userId.value);
				}else{
					showMsg(idMsg,"아이디는 5~20자의 영문 소문자,숫자만 사용 가능합니다.","fail");
				}
				
			}
		}); 
		
		document.getElementById('password').addEventListener("blur",function(){
			var password = document.getElementById('password');
			var pwMsg = document.getElementById('pwMsg');
			if(password.value == ""){
				showMsg(pwMsg,"비밀번호를 입력하시기 바랍니다.","fail");
			}else{
				if(regex(password)){
					showMsg(pwMsg,"사용 가능한 비밀번호입니다.","success");
				}else{
					showMsg(pwMsg,"8~16자 영문 대 소문자, 숫자, 특수문자를 3개 이상 사용하세요.","fail");
				}
			}
		}); 
		
		document.getElementById('userNm').addEventListener("blur",function(){
			var userNm = document.getElementById('userNm');
			var nmMsg = document.getElementById('nmMsg');
			if(userNm.value == ""){
				showMsg(nmMsg,"이름을 입력하시기 바랍니다.","fail");
			}else{
				if(regex(userNm)){
					showMsg(nmMsg,"","success");
				}else{
					showMsg(nmMsg,"이름을 정확하게 입력해주시기 바랍니다","fail");
				}
			}
			
			
		}); 
		
		document.getElementById('birthday').addEventListener("blur",function(){
			var birthday = document.getElementById('birthday');
			var birthdayMsg = document.getElementById('birthdayMsg');
			if(birthday.value == ""){
				showMsg(birthdayMsg,"생년월일을 입력하시기 바랍니다.","fail");
			}else{
				showMsg(birthdayMsg,"","");
			}
		}); 
		
		document.getElementById('email').addEventListener("blur",function(){
			var email = document.getElementById('email');
			var emailMsg = document.getElementById('emailMsg');
			if(email.value == ""){
				showMsg(emailMsg,"","");
			}else{
				if(regex(email)){
					showMsg(emailMsg,"이메일 양식이 맞습니다.","success");
				}else{
					showMsg(emailMsg,"이메일 양식이 맞지 않습니다.","fail");
				}
			}
		}); 
		
		document.getElementById('phoneNumber').addEventListener("blur",function(){
			var phoneNumber = document.getElementById('phoneNumber');
			var phoneNumberMsg = document.getElementById('phoneNumberMsg');
			if(phoneNumber.value == ""){
				showMsg(phoneNumberMsg,"","");
			}else{
				if(regex(phoneNumber)){
					showMsg(phoneNumberMsg,"핸드폰 번호 양식이 맞습니다.","success");
				}else{
					showMsg(phoneNumberMsg,"핸드폰 번호 양식이 맞지 않습니다.","fail");
				}
			}
		}); 
		
		
		function idCheck(userId){
			$.ajax({
				type:"GET",
				url:"/login/idCheckAjax?userId="+userId,
				success:function(data){
					var result = data;
					if(result == "Y"){
						showMsg(idMsg,"사용 가능한 아이디입니다.","success");
					}else if(result == "N"){
						showMsg(idMsg,"이미 사용중이거나 탈퇴한 아이디입니다.","fail");
					}else{
						// TODO : 에러페이지
					}
				}		
			});
		}
		
		function pwChkMsgChange(){
	        var password = document.getElementById('password');
	        var pwChk = document.getElementById('pwChk');
	        var pwChkMsg = document.getElementById('pwChkMsg');
	
	        if(password.value != "" && pwChk.value != ""){
	        	if(password.value == pwChk.value){
		      		pwChk.style.backgroundColor="lightgreen";
					showMsg(pwChkMsg,"비밀번호가 일치합니다.","success");
			    }else{
			    	pwChk.style.backgroundColor ="red";
					showMsg(pwChkMsg,"비밀번호가 일치하지 않습니다.","fail");
				}
	        }else{
	      		pwChk.style.backgroundColor="white";
	      		pwChkMsg.innerHTML = "<span></span>";
	      		pwChkMsg.dataset.flag = "false";
	        }
	      	
			event.returnValue = false;
		}
		
		function joinCheck(){
			var userId = document.getElementById('userId');
			var password = document.getElementById('password');
			var pwChk = document.getElementById('pwChk');
			var userNm = document.getElementById('userNm');
			var birthday = document.getElementById('birthday');

			var idMsg = document.getElementById('idMsg');
			var pwMsg = document.getElementById('pwMsg');
			var pwChkMsg = document.getElementById('pwChkMsg');
			var nmMsg = document.getElementById('nmMsg');
			var birthdayMsg = document.getElementById('birthdayMsg');

			if(idMsg.dataset.flag == "false"){
				alert("아이디를 확인해주세요.");
				userId.focus();
				return false;
		
			}else if(pwMsg.dataset.flag == "false"){
				alert("비밀번호를 확인해주세요.");
				password.focus();
				return false;
				
			}else if(pwChkMsg.dataset.flag == "false"){
				alert("비밀번호 재확인을 확인해주세요.");
				pwChk.focus();
				return false;

			}else if(nmMsg.dataset.flag == "false"){
				alert("이름을 확인해주세요.");
				userNm.focus();
				return false;

			}else if(birthdayMsg.dataset.flag == "false"){
				alert("생년월일을 확인해주세요.");
				birthday.focus();
				return false;

			}else{
				return true;
			}
		}
		
	</script>
</body>
</html>