<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>세션만료처리</title>
	<%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
	<script type="text/javascript">
		window.onload = function(){
			alert("세션이 만료되어 로그아웃 되었습니다. 로그인 화면으로 이동합니다.");
			
			<c:choose>
				<c:when test="${sessionUserType eq 'admin'}">
					<% session.invalidate(); %>
					location.href="/admin/login";
				</c:when>
				<c:otherwise>
					<% session.invalidate(); %>
					location.href="/login/login";
				</c:otherwise>
			</c:choose>
		}
	</script>
</body>
</html>