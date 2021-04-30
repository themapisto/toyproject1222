<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>

<title>회원관리 리스트</title>
<link href="/resources/css/default.css?sh" rel="stylesheet" type="text/css">
<link href="/resources/css/userList.css?as" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.5.1.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/admin/header.jsp" %>
<%@include file="/WEB-INF/views/admin/sidebar.jsp" %>
<div id="contents">
	<div id="contents_title"><span>|관리자목록</span></div>
	<form id="filter" name="filter" method="get" action="/admin/adminList">
		<div id="flex">
			<select class="sel" id="option" name="option">
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
        	<col style="width:25%;">
        	<col style="width:25%;">
        	<col style="width:25%;">
        	<col style="width:15%;">
    	</colgroup>

    	<thead>
        	<tr>
            	<th scope="col">번호</th>
            	<th scope="col">이름</th>
            	<th scope="col">아이디</th>
            	<th scope="col">가입일자</th>
            	<th scope="col">상태변경</th>
        	</tr>
    	</thead>
    	<tbody>
    		<c:forEach items="${userList}" var="user" varStatus="status">
        	<tr>
            	<td>${status.count}</td>
            	<td>${user.userNm}</td>
            	<td>${user.userId}</td>
            	<td>
            		<fmt:formatDate value="${user.regDt}" pattern="yyyy-MM-dd"/>
            	</td>
            	<td>
            		<button type="button" class="deleteAdmin" onClick="deleteAdmin(this, '${user.userId}');">
            			관리자 삭제
            		</button>
            	</td>
        	</tr>
        	</c:forEach>   
    	</tbody>
	</table>
	<div id="pages" style="display: block; text-align: center;">		
		<c:if test="${pageDto.prev == true }">
			<a href="/admin/adminList?state=${pageDto.state}&keyword=${pageDto.keyword}&option=${pageDto.option}&page=${pageDto.startPage - 1 }">&lt;</a>
		</c:if>
		<c:forEach begin="${pageDto.startPage}" end="${pageDto.endPage}" var="p">
			<c:choose>
				<c:when test="${p == pageDto.page}">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != pageDto.page}">
					<a href="/admin/adminList?state=${pageDto.state}&keyword=${pageDto.keyword}&option=${pageDto.option}&page=${p }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${pageDto.next == true}">
			<a href="/admin/adminList?state=${pageDto.state}&keyword=${pageDto.keyword}&option=${pageDto.option}&page=${pageDto.endPage+1 }">&gt;</a>
		</c:if>
		<a href="/admin/join" id="addAdmin"><span>+</span>관리자 추가</a>
	</div>
</div>
	
<script type="text/javascript">
function deleteAdmin(btnObject, userId) {
	var confirmResult = confirm(userId+"님을 관리자목록에서 삭제하시겠습니까?");
	if(confirmResult == true){
		$.ajax({
            url: "/admin/deleteAdmin",
            type: "POST",
            data: {
            	userId:userId,
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