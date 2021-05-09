<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>

<title>회원관리 리스트</title>
<link href="/resources/css/default.css?p" rel="stylesheet" type="text/css">
<link href="/resources/css/userList.css?o" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.5.1.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/admin/header.jsp" %>
<%@include file="/WEB-INF/views/admin/sidebar.jsp" %>
<div id="contents">
	<div id="contents_title"><span>|회원목록</span></div>
	<form id="filter" name="filter" method="get" action="/admin/userList">
		<div id="flex">
		<c:if test="${pageDto.state == 8 }">
			<font size="2">잠금일자</font>
			<input type="text" id="startDate" name="startDate" placeholder="검색할 시작날짜">-
			<input type="text" id="endDate" name="endDate" placeholder="검색할 마지막날짜">
		</c:if>
		<select id="state" name="state">
			<option value="">전체</option>
			<option value="1" ${pageDto.state eq "1"? "selected":"" }>가입</option>
			<option value="8" ${pageDto.state eq "8"? "selected":"" }>잠김</option>
			<option value="9" ${pageDto.state eq "9"? "selected":"" }>탈퇴</option> 
		</select>
		<select id="option" name="option">
			<option value="userNm" ${pageDto.option eq "userNm"? "selected":"" }>이름</option>
			<option value="userId" ${pageDto.option eq "userId"? "selected":"" }>아이디</option>
		</select>
		<input type="text" id="keyword" name="keyword" value="${pageDto.keyword}">
    	<button type="submit" id="searchBtn">검색</button>
    	</div>
	</form>
<table id="userTable">
    <colgroup>
        <col style="width:10%;">
        <col style="width:10%;">
        <col style="width:15%;">
        <col style="width:15%;">
        <col style="width:20%;">
        <col style="width:30%;">
    </colgroup>

    <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">회원등급</th>
            <th scope="col">이름</th>
            <th scope="col">아이디</th>
            <th scope="col">가입일자<c:if test="${pageDto.state == 8 }"><br>/잠김일자</c:if></th>
            <th scope="col">회원상태<br><font size="2">가입/잠김/탈퇴</font></th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach items="${userList}" var="user" varStatus="status">
        <tr>
            <td>${pageDto.startIdx + status.count}</td>
            <td>일반회원</td>
            <td>${user.userNm}</td>
            <td class="userId">${user.userId}</td>
            <td>
            	<fmt:formatDate value="${user.regDt}" pattern="yyyy-MM-dd"/><br>
            	<fmt:formatDate value="${user.loginFailTime}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
            	<select class="userState" name="userState">
					<option value="1" ${user.userState eq "1"? "selected":"" }>가입</option>
					<option value="8" ${user.userState eq "8"? "selected":"" }>잠김</option>
					<option value="9" ${user.userState eq "9"? "selected":"" }>탈퇴</option> 
				</select>
            	<button
            		type="button" id="modifyBtn" class="modifyBtn"
            		onClick="modifyState(this, '${user.userId}');">
            		회원상태 변경✓
            	</button>
            </td>
            
        </tr>
        </c:forEach>   
    </tbody>
</table>
<div id="pages" style="display: block; text-align: center;">
		<c:if test="${pageDto.prev == true }">
			<a href="/admin/userList?state=${pageDto.state}&keyword=${pageDto.keyword}&option=${pageDto.option}&page=${pageDto.startPage - 1 }">&lt;</a>
		</c:if>
		<c:forEach begin="${pageDto.startPage}" end="${pageDto.endPage}" var="p">
			<c:choose>
				<c:when test="${p == pageDto.page}">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != pageDto.page}">
					<a href="/admin/userList?state=${pageDto.state}&keyword=${pageDto.keyword}&option=${pageDto.option}&page=${p }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${pageDto.next == true}">
			<a href="/admin/userList?state=${pageDto.state}&keyword=${pageDto.keyword}&option=${pageDto.option}&page=${pageDto.endPage+1 }">&gt;</a>
		</c:if>
</div>

</div>

<script type="text/javascript">
    
    $("#endDate").datepicker({ dateFormat: 'yy-mm-dd', onSelect: function(endDate) {	
    		var startDate = $("#startDate").val();
    		var endDate = endDate;
    		if(startDate==""){
    			alert("검색 시작 날짜를 먼저 선택해주세요");
    			document.getElementById("endDate").value ='';
    		}
    		if(endDate<startDate){
    			alert("날짜 범위를 확인해주세요");
    			document.getElementById("startDate").value ='';
    			document.getElementById("endDate").value ='';
    		}
    	  }
    	}); 
    $("#startDate").datepicker({ dateFormat: 'yy-mm-dd'
    	});
    	
    let stateMap = new Map([
        ["1", "가입"],
        ["8", "잠김"],
        ["9", "탈퇴"]
    ]);
    
   	function modifyState(btnObject, userId) {
   		const tr = $(btnObject).parent().parent();
		const select = $(tr).find('select.userState')[0];
		const userState = $(select).val();
    	var confirmResult = confirm(userId+"님을 "+stateMap.get(userState)+"상태로 변경하시겠습니까?");
    	if(confirmResult == true){
    		$.ajax({
                url: "/admin/modifyState",
                type: "POST",
                data: {
                	userId:userId,
                	userState:userState
                },
                success: function(data){
                    alert(data.Msg);
                },
                error: function(){
                    alert("잠시 후 다시 시도해주세요");
                }
          	});
    	}
    }
    
</script>
</body>
</html>