<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>마이페이지</title>
	<%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body style="overflow-y:hidden;overflow-x:hidden;">
	<div class="searchContents">
		<h1>비밀번호 찾기</h1>
    <span>입력하신 정보가 회원정보와 일치하면 이메일주소로 임시비밀번호를 발송합니다.</span>
    <form id="pwdSearchForm" name="pwdSearchForm" onsubmit="return false;">
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
          <tr>
            <th><span class="req"></span>&nbsp;이메일주소</th>
            <td><input type="email" id="email" name="email"></td>
          </tr>
        </tbody>
      </table>
    </form>
    <button type="button" onclick="pwdSearch();">찾기</button>
    <button type="button" onclick="windowClose();">닫기</button>
    <div id="pwdSearchMsg"></div>
  </div>
  <script type="text/javascript">  
    

    function pwdSearch(){
    	var userNm = document.getElementById("userNm").value;
    	var phoneNumber = document.getElementById("phoneNumber").value;
    	var email = document.getElementById("email").value;
    	
    	if(userNm != "" && phoneNumber != "" && email != ""){
			var xhr = new XMLHttpRequest();
			xhr.open("post","/login/pwdSearch",true);
			xhr.onreadystatechange = function(){
				if(xhr.readyState == xhr.DONE){
					if(xhr.status == 200){
						var data = xhr.responseText;	
						data = JSON.parse(data);
						var msg = "";
						if(data.result == "success"){
						    alert("회원님의 이메일로 임시비밀번호를 발송하였습니다.");
						    windowClose();
						}else if(data.result == "fail"){
							msg = "아이디가 존재하지 않거나 정지된 상태입니다.";
						    document.getElementsByTagName("div")[1].innerHTML = msg;
						    document.getElementsByTagName("div")[1].style.color = 'red';
						    document.getElementsByTagName("div")[1].style.display = 'block';
						    return false;
						}else{
							msg = "비밀번호 찾기 중 에러가 발생하였습니다."
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
					+"&phoneNumber="+phoneNumber+"&email="+email);
    	}else{
		    var msg = "이름,핸드폰번호,이메일을 모두 입력해주세요.";
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