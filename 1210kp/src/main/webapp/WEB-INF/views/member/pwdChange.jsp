<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
    <%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<h2>MOVIE BOX 마이페이지 수정화면</h2>
	<hr>
	<div class="myInfoModifyContents">
	    <form id="pwChangeForm" name="pwChangeForm" onsubmit="return false;">
	      	<table>
		        <colgroup>
		          	<col style="width:40%">
		          	<col style="width:60%">
		        </colgroup>
	        	<tbody>
	          		<tr>
	            		<th>
	            			<span class="req"></span>&nbsp;현재 비밀번호 입력
	            		</th>
	            		<td>
	            			<input type="password" id="pwOld" name="pwOld">
	            		</td>
	          		</tr>
	          		<tr>
	            		<th>
	            			<span class="req"></span>&nbsp;변경 비밀번호 입력
	            		</th>
	            		<td>
	            			<input type="password" id="pwNew" name="pwNew">
	            			<p class="red">8~16자 영문 소문자, 숫자, 
	              				<br>특수문자를 3개 이상 사용하여
	              				<br>입력해 주시기 바랍니다.
	              			</p>
	              		</td>
          			</tr>
	          		<tr>
	            		<th>
	            			<span class="req"></span>&nbsp;변경 비밀번호 확인
	            		</th>
	            		<td>
	            			<input type="password" id="pwNewChk" name="pwNewChk">
	            		</td>
	          		</tr>
	        	</tbody>
	      	</table>
	   </form>
	   <button type="button" onclick="update();">변경</button>
	   <button type="button" onclick="cancle();">취소</button>
	</div>
	
	<div class="modalWrap off">
        <div class="modal off">
            <div class="modalHead">비밀번호변경</div>
            <div class="modalBody">
                <p>비밀번호를 변경하시겠습니까?</p>
                <button type="button" onclick="modalOk(update);">변경</button>
                <button type="button" onclick="modalClose(update);">취소</button>
            </div>
        </div>
        <div class="modal off">
            <div class="modalHead">비밀번호변경</div>
            <div class="modalBody">
                <p>해당 페이지에서 나가시겠습니까?</p>
                <button type="button" onclick="modalOk(cancle);">예</button>
                <button type="button" onclick="modalClose(cancle)">아니오</button>
            </div>
        </div>
    </div>
    
  	<script type="text/javascript">  
	
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
	        var pwOld = document.getElementById("pwOld").value;
	  		var pwNew = document.getElementById("pwNew").value;
	  		
	        if(purpose == update){
	        	var xhr = new XMLHttpRequest();
				xhr.open("post","/member/pwdChangeSubmit",true);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == xhr.DONE){
						if(xhr.status == 200){
							var data = xhr.responseText;	
							data = JSON.parse(data);
							var result = data.result;
							if(result == "success"){
								alert("비밀번호가 변경되었습니다. 다시 로그인해주시기 바랍니다.");
								location.href="/login/login";
							}else if(result == "updateFail"){
								alert("비밀번호 변경이 실패하였습니다. 변경하실 비밀번호를 확인하시기바랍니다.");
								return false;
							}else if(result == "selectFail"){
								alert("기존 비밀번호가 맞지 않습니다.");
								return false;
							}else{
								alert("비밀번호 변경 중 에러가 발생하였습니다.");
								return false;
							}
						}else{
							alert("요청 오류 : "+xhr.status);
						}
					}
				}
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				xhr.send("pwOld="+encodeURIComponent(pwOld)+"&pwNew="+encodeURIComponent(pwNew));
	        }else{
	            location.href = "/member/myInfo";
	        }
	    }
	    
	    function validate(){
	    	var pwOld = document.getElementById("pwOld").value;
	    	var pwNew = document.getElementById("pwNew").value;
	    	var pwNewChk = document.getElementById("pwNewChk").value;
	    	
	    	var regType = "";
	    	var regType2 = "";
	    	regType = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&-_~`]).*$/;	
			regType2 = /^[^<>+=]*$/;
			
			if(pwOld != "" && pwNew != "" && pwNewChk != "" && regType.test(pwNew) && regType2.test(pwNew) && pwNew == pwNewChk){
				return true;
			}else if(pwOld == ""){
	    		alert("기존 비밀번호를 입력해주세요.");
	    		return false;
	    	}else if(pwNew == ""){
	    		alert("새 비밀번호를 입력해주세요.");
	    		return false;
	    	}else if(pwNewChk == ""){
	    		alert("새 비밀번호 확인을 입력해주세요.");
	    		return false;
	    	}else if(!regType.test(pwNew) || !regType2.test(pwNew)){
	    		alert("새 비밀번호를 양식에 맞춰 입력해주세요.");
	    		return false;
	    	}else if(pwNew != pwNewChk){
	    		alert("새 비밀번호와 비밀번호 확인란에 기입한 비밀번호가 일치하지 않습니다.");
	    		return false;
	    	}else{
	    		alert("비밀번호 변경 중 오류가 발생하였습니다.");
	    		return false;
	    	}
	    }
	</script>
</body>
</html>