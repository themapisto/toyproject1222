<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>결과처리</title>
	<%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
	<script type="text/javascript">
		
		var result = '${result}';
		var submit = '${submit}';
		
		if(submit == 'login'){
			if(result == 'Y'){
				// TODO : 기존의 페이지로 돌아가게
				alert("${sessionUserNm}님 로그인에 성공하였습니다. 홈페이지로 이동합니다.");
				location.href="/";
			}else if(result == 'N'){
				alert("로그인이 실패하였습니다. 다시 확인해주시기 바랍니다.");
				location.href="/login/login";
			}else{
				location.href="/common/errorDefault";
			}
		}else if(submit == 'join'){
			if(result == 'Y'){
				alert("회원가입에 성공하였습니다. 로그인 페이지로 이동합니다.");
				location.href="/login/login";
			}else if(result == 'N'){
				alert("회원가입이 실패하였습니다. 다시 확인해주시기 바랍니다.");
				location.href="/login/join";
			}else{
				location.href="/common/errorDefault";
			}
		}else if(submit == 'logout'){
			if(result == 'Y'){
				alert("로그아웃 되었습니다.");
				location.href="/login/login";
			}else{
				alert("로그아웃 실패");
				location.href="/common/errorDefault";
			}
		}else if(submit == 'adminLogout'){
			if(result == 'Y'){
				alert("로그아웃 되었습니다.");
				location.href="/admin/login";
			}else{
				alert("로그아웃 실패");
				location.href="/common/errorDefault";
			}
		}else if(submit == 'updateMyInfo'){
			if(result == 'Y'){
				alert("회원정보가 수정되었습니다.");
				location.href="/member/myInfo";
			}else{
				alert("회원정보 수정실패");
				location.href="/common/errorDefault";
			}
		}else if(submit == 'userWithdrawal'){
			if(result == 'success'){
				alert("회원탈퇴 처리되었습니다.");
			}else if(result == 'updateFail'){
				alert("회원탈퇴 처리가 실패하였습니다.");
				location.href="/member/userWithdrawal";
			}else if(result = 'selectFail'){
				alert("비밀번호를 잘못 입력하셨습니다.");
				location.href="/member/userWithdrawal";
			}else{
				location.href="/common/errorDefault";
			}
		}
		
	</script>
</body>
</html>