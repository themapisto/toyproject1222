<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>마이페이지</title>
	<%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body style="overflow-y:hidden;overflow-x:hidden;">
 	<div class="searchContents">
	    <h1>아이디 찾기</h1>
	    <form id="idSearchForm" name="idSearchForm" onsubmit="return false;">
	      <table>
	        <colgroup>
	          <col style="width:40%">
	          <col style="width:60%">
	        </colgroup>
	        <tbody>
	          <tr>
	            <th><span class="req"></span>&nbsp;이름</th>
	            <td><input type="text" id="userNm" name="userNm"></td>
	          </tr>
	          <tr>
	            <th><span class="req"></span>&nbsp;핸드폰번호</th>
	            <td><input type="tel" id="phoneNumber" name="phoneNumber"></td>
	          </tr>
	        </tbody>
	      </table>
	    </form>
	    <button type="button" onclick="idSearch();">찾기</button>
	    <button type="button" onclick="windowClose();">닫기</button>
	    <div id="idSearchMsg"></div>
 	</div>
  	<script type="text/javascript">  
	    function idSearch(){
	    	var userNm = document.getElementById("userNm").value;
	    	var phoneNumber = document.getElementById("phoneNumber").value;
	    	if(userNm != "" && phoneNumber != ""){
				var xhr = new XMLHttpRequest();
				xhr.open("post","/login/idSearch",true);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == xhr.DONE){
						if(xhr.status == 200){
							var data = xhr.responseText;	
							data = JSON.parse(data);
							var msg = "";
							if(data.result == "success"){
								msg = "로그인 ID : ["+data.userId+"]";
							    document.getElementsByTagName("div")[1].innerHTML = msg;
							    document.getElementsByTagName("div")[1].style.display = 'block';
							}else if(data.result == "fail"){
								msg = "아이디가 존재하지 않거나 정지된 상태입니다.";
							    document.getElementsByTagName("div")[1].innerHTML = msg;
							    document.getElementsByTagName("div")[1].style.color = 'red';
							    document.getElementsByTagName("div")[1].style.display = 'block';
							    return false;
							}else{
								msg = "아이디 찾기 중 에러가 발생하였습니다."
							    document.getElementsByTagName("div")[1].innerHTML = msg;
							    document.getElementsByTagName("div")[1].style.color = 'red';
							    document.getElementsByTagName("div")[1].style.display = 'block';
							    return false;
							}
						}else{
							location.href="/common/errorDefault";
						}
					}
				}
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				xhr.send("userNm="+userNm
						+"&phoneNumber="+phoneNumber);
	    	}else{
			    var msg = "이름과 핸드폰번호를 입력해주세요.";
				document.getElementsByTagName("div")[1].innerHTML = msg;
			    document.getElementsByTagName("div")[1].style.display = 'block';
	    		return false;
	    	}
			
	    }
	
	    function windowClose(){
	      if(opener){
	        window.close();
	        return false;
	      }else{
	        history.back();
	        return false;
	      }
	    }
 	</script>
</body>
</html>