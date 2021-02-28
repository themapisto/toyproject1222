<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>마이페이지 수정</title>
	<%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<h2>MOVIE BOX 마이페이지 수정화면</h2>
	<hr>
	<div class="myInfoModifyContents">
		<form id="myInfoForm" name="myInfoForm" method="POST" action="myInfoModifySubmit">
			<table>
				<colgroup>
					<col style="width: 40%">
					<col style="width: 60%">
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th>
					<td>${userVO.userId}</td>
					</tr>
					<tr>
						<th>회원등급</th>
					<td>${userVO.grade}</td>
					</tr>
					<tr>
						<th><span class="req"></span>&nbsp;이름</th>
						<td><input type="text" id="userNm" name="userNm"
							value="${userVO.userNm}"></td>
					</tr>
					<tr>
						<th><span class="req"></span>&nbsp;생년월일</th>
						<td><input type="date" id="birthday" name="birthday"
							value="${userVO.birthday}"></td>
					</tr>
					<tr>
						<th><span class="req"></span>&nbsp;이메일</th>
						<td><input type="email" id="email" name="email"
							value="${userVO.email}"></td>
					</tr>
					<tr>
						<th><span class="req"></span>&nbsp;핸드폰번호</th>
						<td><input type="tel" id="phoneNumber" name="phoneNumber"
							value="${userVO.phoneNumber}"></td>
					</tr>
				</tbody>
			</table>
			<button type="button" onclick="update();">저장</button>
			<button type="button" onclick="cancle();">취소</button>
		</form>
	</div>
	
	<div class="modalWrap off">
        <div class="modal off">
            <div class="modalHead">회원정보수정</div>
            <div class="modalBody">
                <p>변경 사항을 저장하시겠습니까?</p>
                <button type="button" onclick="modalOk(update);">저장</button>
                <button type="button" onclick="modalClose(update);">취소</button>
            </div>
        </div>
        <div class="modal off">
            <div class="modalHead">회원정보수정</div>
            <div class="modalBody">
                <p>해당 페이지에서 나가시겠습니까?</p>
                <button type="button" onclick="modalOk(cancle);">예</button>
                <button type="button" onclick="modalClose(cancle)">아니오</button>
            </div>
        </div>
    </div>
    
	<script type="text/javascript">
	
		function update(){
	    	if(modifyChk()){
	    		document.getElementsByClassName("modalWrap")[0].className = "modalWrap on";
		        document.getElementsByClassName("modal")[0].className = "modal on";
	    	}else{
	    		return false;
	    	};
	        
	    }
	    function cancle(){
	        document.getElementsByClassName("modalWrap")[0].className = "modalWrap on";
	        document.getElementsByClassName("modal")[1].className = "modal on";
	    }
	    function modalClose(purpose){
	        if(purpose == update){
	            document.getElementsByClassName("modalWrap")[0].className = "modalWrap off";
	            document.getElementsByClassName("modal")[0].className = "modal off";
	        }else{
	            document.getElementsByClassName("modalWrap")[0].className = "modalWrap off";
	            document.getElementsByClassName("modal")[1].className = "modal off";
	        }
	    }
	    function modalOk(purpose){
	        // 저장하면 form submit 하고 다음 페이지로 넘어감
	        if(purpose == update){
	        	var form = document.myInfoForm;
				form.submit();
	        }else{
	            location.href = "/member/myInfo";
	        }
	    }
		
		
		
		function modifyChk(){
			var userNm = document.getElementById('userNm');
	        var birthday = document.getElementById('birthday');
			var email = document.getElementById('email');
			var phoneNumber = document.getElementById('phoneNumber');
			
			if(regex(userNm) == true && userNm.value != ""  
				&& regex(email) == true && email.value != "" 
				&&	regex(phoneNumber) == true && phoneNumber.value != ""  
				&&	birthdayChk() == true && birthday.value != ""){
				return true;
			}else if(regex(userNm) == false){
				alert("이름을 확인해주시기 바랍니다.");
				return false;
			}else if(birthdayChk() == false){
				alert("생년월일을 확인해주시기 바랍니다.");
				return false;
			}else if(regex(email) == false){
				alert("이메일 양식이 맞지 않습니다.");
				return false;
			}else if(regex(phoneNumber) == false){
				alert("핸드폰번호 양식이 맞지 않습니다.");
				return false;
			}else if(userNm.value == ""){
				alert("이름을 입력해주시기 바랍니다.");
				return false;
			}else if(birthday.value == ""){
				alert("생년월일을 입력해주시기 바랍니다.");
				return false;
			}else if(email.value == ""){
				alert("이메일을 입력해주시기 바랍니다.");
				return false;
			}else if(phoneNumber.value == ""){
				alert("핸드폰번호를 입력해주시기 바랍니다.");
				return false;
			}else{
				return false;
			}
			
		}
	
		function birthdayChk(){
			var today = new Date();
	        var todayYear = today.getFullYear();
	        var todayMonth = today.getMonth()+1;
	        var todayDate = today.getDate(); 
	        
	        var birthday = document.getElementById('birthday');
			var birthdayMsg = document.getElementById('birthdayMsg');
			var birthSplit = birthday.value.split('-'); 
			
			var userYear = Number(birthSplit[0]);
	        var userMonth = Number(birthSplit[1]);
	        var userDate = Number(birthSplit[2]);
	        
			if(birthday.value == ""){
				return false;
			}else{
				if(todayYear < userYear){
					return false;
					if(todayMonth < userMonth){
						return false;
					}else if(todayMonth == userMonth){
						if(todayDate < userDate){
							return false;
						}else{
							return true;
						}
					}else{
						return true;
					}
				}else if(100 < todayYear - userYear + 1){
					return false;
				}else{
					return true;
				}
			}
		}
	
		function regex(object){
			var regType = "";
			
			if(object == userNm){
			 	regType = /^([가-힣]{2,}|[a-zA-Z]{2,})$/;
			}else if(object == email){
			 	regType = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z^<>]{2,3}$/i;
			}else if(object == phoneNumber){
				regType= /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/
			}else{
				// TODO : 에러페이지
			}
			
			if(regType.test(object.value)){
				return true;
			} else{
				return false;
			}
		}
	
		
	</script>
</body>
</html>