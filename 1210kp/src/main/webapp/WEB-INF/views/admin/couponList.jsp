<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>

	<%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
	<%@include file="/WEB-INF/views/common/adminHeader.jsp" %>
	<%@include file="/WEB-INF/views/common/adminSidebar.jsp" %>
	
	<div class="couponMainContents">
		<div>
			<button type="button" class="couponUseViewBtn" id="able">진행중인 쿠폰</button>
			<button type="button" class="couponUseViewBtn" id="unable">종료된 쿠폰</button>
		</div>
		
		<table id="ableList" class="couponTable on">
		    <thead>
					<tr>
						<th><input type="checkbox" class="selectAll" title="전체선택"></th>
		              	<th>쿠폰번호</th>
		              	<th>쿠폰명</th>
		              	<th>할인율</th>
		              	<th>등록가능일자</th>
		              	<th>등록마감일자</th>
		              	<th>등록가능여부</th>
		              	<th>사용가능기간</th>                   	
		           </tr>
			</thead>
		    <tbody>
				<c:forEach var="list" items="${couponList}" varStatus = "status">
					<fmt:formatDate var="registStartDt" value="${list.registStartDt}" pattern="yyyy-MM-dd"/>
			    	<fmt:formatDate var="registEndDt" value="${list.registEndDt}" pattern="yyyy-MM-dd"/>
					<c:if test="${list.registChk eq 'Y'}">
						<tr>
							<td><input type="checkbox" class="select" title="선택" value="${list.couponId}"></td>
							<td>${list.couponId}</td>
							<td>${list.couponNm}</td>
							<td>${list.dscntRate}%</td>
							<td>${registStartDt}</td>
							<td>${registEndDt}</td>
							<td>${list.registChk}</td>
							<td>${list.usePeriod}일</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		
		<table id="unableList" class="couponTable off">
		    <thead>
					<tr>
						<th><input type="checkbox" class="selectAll" title="전체선택"></th>
		              	<th>쿠폰번호</th>
		              	<th>쿠폰명</th>
		              	<th>할인율</th>
		              	<th>등록가능일자</th>
		              	<th>등록마감일자</th>
		              	<th>등록가능여부</th>
		              	<th>사용가능기간</th>                   	
		           </tr>
			</thead>
		    <tbody>
				<c:forEach var="list" items="${couponList}" varStatus = "status">
					<fmt:formatDate var="registStartDt" value="${list.registStartDt}" pattern="yyyy-MM-dd"/>
			    	<fmt:formatDate var="registEndDt" value="${list.registEndDt}" pattern="yyyy-MM-dd"/>
			    	<c:if test="${list.registChk eq 'N'}">
						<tr>
							<td><input type="checkbox" class="select" title="선택" value="${list.couponId}"></td>
							<td>${list.couponId}</td>
							<td>${list.couponNm}</td>
							<td>${list.dscntRate}%</td>
							<td>${registStartDt}</td>
							<td>${registEndDt}</td>
							<td>${list.registChk}</td>
							<td>${list.usePeriod}일</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<a type="button" id="deleteCoupon" class="right">쿠폰삭제</a>
		<a type="button" id="updateCoupon" class="right">쿠폰수정</a>
		<a href="/admin/makeCoupon" class="right">쿠폰생성</a>
		<a type="button" id="updateRegistChk" class="right">등록가능여부변경</button>
	</div>

	<script type="text/javascript">
		$(document).ready(function(){
			var able = document.getElementById('able');
			var unable = document.getElementById('unable');
			var ableList = document.getElementById('ableList');
			var unableList = document.getElementById('unableList');
			
			var chkList = "";
			var couponId = "";
			
			able.style.backgroundColor = '#034f84';
			
			$("#updateRegistChk").on('click',function(){		
				chkList = $('tbody').find("input[type=checkbox]:checked");

				if(chkList.length == 0){
					alert("등록가능여부를 변경할 쿠폰을 선택해주세요.");
				}else{
					if(confirm("해당 정보를 수정하시겠습니까?")){
						$.each(chkList, function(key,item) {
							couponId += item.value + ',';
						});
					
						$.post(
							"/admin/couponUpdtRgstChkAjax",
							{couponId : couponId},
							function(data){
								var result = data.result;
								if(result == 'Y'){
									alert("등록가능여부가 변경되었습니다.");
									location.reload();
								}else{
									alert("변경실패.");
									return false;
								}
							}
						);
					}else{
						return false;
					}
				}
			});
			
			
			
			$("#updateCoupon").on('click',function(){		
				chkList = $('tbody').find("input[type=checkbox]:checked");
				
				if(chkList.length == 0){
					alert("수정하실 쿠폰을 선택해주세요.");
					return false;
				}else if(chkList.length > 1){
					alert("수정하실 쿠폰을 하나만 선택 해주시기 바랍니다.");
					return false;
				}else{
					couponId = chkList.val();
					location.href="/admin/updateCoupon?couponId="+couponId;
				}
			});
			
			$("#deleteCoupon").on('click',function(){		
				chkList = $('tbody').find("input[type=checkbox]:checked");
				
				if(chkList.length == 0){
					alert("삭제하실 쿠폰을 선택해주세요.");
				}else{
					if(confirm("해당 쿠폰을 삭제하시겠습니까?")){
						$.each(chkList, function(key,item) {
							couponId += item.value + ',';
						});
					
						$.post(
							"/admin/couponDeleteAjax",
							{couponId : couponId},
							function(data){
								var result = data.result;
								if(result == 'Y'){
									alert("쿠폰이 삭제되었습니다.");
									location.reload();
								}else{
									alert("삭제실패.");
									return false;
								}
							}
						);
					}else{
						return false;
					}
				}
			});
			
			// 테이블 체크박스 전체 선택/해제
			$(".selectAll").on('click',function(){
				if($(".selectAll").is(":checked")){
					$('tbody').find("input[type=checkbox]").prop('checked',true);
				}else{
					$('tbody').find("input[type=checkbox]").prop('checked',false);
				}
			});
		});
	
		unable.addEventListener('click',function(){
			unable.style.backgroundColor = '#034f84';
			able.style.backgroundColor = '#7aa5d2';
			ableList.className = 'couponTable off';
			unableList.className = 'couponTable on';
		});

		able.addEventListener('click',function(){
			unable.style.backgroundColor = '#7aa5d2';
			able.style.backgroundColor = '#034f84';
			unableList.className = 'couponTable off';
			ableList.className = 'couponTable on';
		});	
		
		
	</script>
</body>
</html>