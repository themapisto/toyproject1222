<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>회원탈퇴</title>
	<%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<%@include file="/WEB-INF/views/common/sidebar.jsp" %>
	
	<div class="navi">
		<li class='blue'>회원탈퇴</li>
		<li><a href="/member/myInfo">회원정보</a></li>
	    <li><a href="/">home</a></li>
	</div>
	<br><hr>
	
	<div class="myInfoModifyContents">
		<h1>회원탈퇴</h1>
	   	<h2>회원 탈퇴를 하시기 전에 다음의 내용을 꼭 확인해주시기 바랍니다.</h2>
	   	<p class="red">회원탈퇴 시 회원정보는 즉시 삭제되며, 해당 아이디로는 재가입을 하실 수 없습니다.<br>
	   	회원탈퇴 후 다른 아이디로는 재가입이 가능합니다.</p>
	   	<form id="userWithdrawalForm" name="userWithdrawalForm" method="POST" action="userWithdrawalSubmit">
	    	<table>
	    		<colgroup>
	         		<col style="width:40%">
					<col style="width:60%">
	    		</colgroup>
	    		<tbody>
	        		<tr>
	            		<th>아이디</th>
	            		<td title="아이디">&nbsp;${sessionId}</td>
	        		</tr>
	        		<tr>
	            		<th><span class="req"></span>&nbsp;비밀번호</th>
	            		<td><input type="password" id="password" name="password" title="비밀번호"></td>
	        		</tr>
	    		</tbody>
	  		</table>
		</form>
		<button type="button" onclick="update();">회원탈퇴</button>
		<button type="button" onclick="cancle();">취소</button>
	</div>

	<div class="modalWrap off">
        <div class="modal off">
            <div class="modalHead">회원탈퇴</div>
            <div class="modalBody">
                <p>회원탈퇴 하시겠습니까?</p>
                <button type="button" onclick="modalOk(update);">확인</button>
                <button type="button" onclick="modalClose(update);">닫기</button>
            </div>
        </div>
        <div class="modal off">
            <div class="modalHead">회원탈퇴</div>
            <div class="modalBody">
                <p>해당 페이지에서 나가시겠습니까?</p>
                <button type="button" onclick="modalOk(cancle);">예</button>
                <button type="button" onclick="modalClose(cancle)">아니오</button>
            </div>
        </div>
    </div>
	<script type="text/javascript">  
		function validate(){
	    	var password = document.getElementById("password").value;
	    	
	    	var regType = "";
	    	var regType2 = "";
	    	regType = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;	
			regType2 = /^[^<>]*$/;
			
			if(password != ""  && regType.test(password) && regType2.test(password)){
				return true;
			}else if(password == ""){
	    		alert("비밀번호를 입력해주세요.");
	    		return false;
	    	}else if(!regType.test(password) || !regType2.test(password)){
	    		alert("비밀번호를 양식에 맞춰 입력해주세요.");
	    		return false;
	    	}else{
	    		alert("비밀번호 변경 중 오류가 발생하였습니다.");
	    		return false;
	    	}
	    }
	
	
	
	    function update(){
	    	if(validate()){
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
	        	var form = document.userWithdrawalForm;
				form.submit();
	        }else{
	            location.href = "/member/myInfo";
	        }
	    }
    </script>
</body>
</html>