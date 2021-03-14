<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>마이페이지 수정</title>
	<%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<%@include file="/WEB-INF/views/common/sidebar.jsp" %>
	
	<div class="myInfoModifyContents">
		<h1>쿠폰등록하기</h1>
		<form id="myInfoForm" name="myInfoForm" method="POST">
			<table>
				<colgroup>
					<col style="width: 40%">
					<col style="width: 60%">
				</colgroup>
				<tbody>
					
					<tr>
						<th><span class="req"></span>&nbsp;쿠폰번호입력</th>
						<td><input type="text" id="couponId" name="couponId" maxlength=8
								placeholder="쿠폰번호를 입력해주세요."></td>
					</tr>
					
				</tbody>
			</table>
			<button type="button" onclick="register();">등록하기</button>
			<button type="button" onclick="cancle();">취소</button>
		</form>
	</div>
	

    
	<script type="text/javascript">
		
		function register(){
			var couponId = document.getElementById('couponId');
			couponId.value = couponId.value.toUpperCase();
			
			if(regex(couponId)){
				var xhr = new XMLHttpRequest();
				xhr.open("post","/member/getCoupon",true);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == xhr.DONE){
						if(xhr.status == 200){
							var data = xhr.responseText;	
							data = JSON.parse(data);
							if(data.result == "success"){
								alert("쿠폰이 등록되었습니다. 쿠폰내역조회 페이지로 이동합니다." );
								location.href="/member/myCoupon";
							}else if(data.result == "fail"){
								alert("유효하지 않은 쿠폰입니다.");
								return false;
							}else{
								alert("에러처리");
								return false;
							}
						}else{
							alert("요청 오류 : "+xhr.status);
						}
					}
				}
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				xhr.send("couponId="+couponId.value);
				
				return true;
			}else{
				alert("유효하지 않은 쿠폰입니다.")
				return false;
			}
			
		}
		
		function cancle(){
			location.href="/member/myInfo";
		}
		
		function regex(object){
			var regType = "";
			
			if(object == couponId){
			 	regType = /^[0-9A-Z]{8}$/;
			}else{
				return false;
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