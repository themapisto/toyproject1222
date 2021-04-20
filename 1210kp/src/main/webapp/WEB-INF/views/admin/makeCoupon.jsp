<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쿠폰 생성</title>
	<%@include file="/WEB-INF/views/common/common.jsp" %>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
</head>
<body>
	<%@include file="/WEB-INF/views/common/adminHeader.jsp" %>
	<%@include file="/WEB-INF/views/common/adminSidebar.jsp" %>
	
	<div class="couponSubContents">
     	<table>
	        <colgroup>
	          	<col style="width:40%">
	          	<col style="width:60%">
	        </colgroup>
	       	<tbody>
         		<tr>
           			<th>쿠폰 번호</th>
           			<td><input type="text" id="couponId" name="couponId" maxlength='8'></td>
         		</tr>
         		<tr>
           			<th>쿠폰 이름</th>
           			<td><input type="text" id="couponNm" name="couponNm"></td>
        		</tr>
         		<tr>
         			<th>할인율</th>
           			<td>
           				<input type="text" id="dscntRate" name="dscntRate" 
           				onkeypress="onlyNumber();" maxlength='2'>%
           			</td>
         		</tr>
        		<tr>
           			<th>등록시작일자</th>
           			<td><input type="text" id="registStartDt" name="registStartDt" readonly></td>
        		</tr>
        		<tr>
           			<th>등록만료일자</th>
           			<td><input type="text" id="registEndDt" name="registEndDt" readonly></td>
        		</tr>
        		<tr>
           			<th>쿠폰사용가능기간</th>
           			<td>
           				<input type="text" id="usePeriod" name="usePeriod"
           				onkeypress="onlyNumber();" maxlength='3'>일
             		</td>
        		</tr>
	       	</tbody>
		</table>
		<div>
		  	<button type="button" onclick="update();">등록</button>
	   		<button type="button" onclick="cancle();">취소</button>
		</div>
	</div>

	<div class="adminModalWrap off">
        <div class="adminModal off">
            <div class="adminModalHead">쿠폰생성</div>
            <div class="adminModalBody">
                <p>쿠폰을 생성하시겠습니까?</p>
                <button type="button" onclick="modalOk(update);">생성</button>
                <button type="button" onclick="modalClose(update);">취소</button>
            </div>
        </div>
        <div class="adminModal off">
            <div class="adminModalHead">쿠폰생성</div>
            <div class="adminModalBody">
                <p>해당 페이지에서 나가시겠습니까?</p>
                <button type="button" onclick="modalOk(cancle);">예</button>
                <button type="button" onclick="modalClose(cancle)">아니오</button>
            </div>
        </div>
    </div>
    
  	<script type="text/javascript">  
		
	  	$(document).ready(function(){
			$("#registStartDt").datepicker({
				changeYear:true,
				changeMonth:true,
				dateFormat: "yy-mm-dd"
			});
			$("#registEndDt").datepicker({
				changeYear:true,
				changeMonth:true,
				dateFormat: "yy-mm-dd"
			});
		});
	  	
	  	function update(){
	    	document.getElementsByClassName("adminModalWrap")[0].className = "adminModalWrap on";
		    document.getElementsByClassName("adminModal")[0].className = "adminModal on";
	    }
	    function cancle(){
	        document.getElementsByClassName("adminModalWrap")[0].className = "adminModalWrap on";
	        document.getElementsByClassName("adminModal")[1].className = "adminModal on";
	    }
	    function modalClose(purpose){
	        if(purpose == update){
	            document.getElementsByClassName("adminModalWrap")[0].className = "adminModalWrap off";
	            document.getElementsByClassName("adminModal")[0].className = "adminModal off";
	        }else{
	            document.getElementsByClassName("adminModalWrap")[0].className = "adminModalWrap off";
	            document.getElementsByClassName("adminModal")[1].className = "adminModal off";
	        }
	    }
	    function modalOk(purpose){
	        if(purpose == update){
	        	var couponId = $("#couponId").val();
	        	var couponNm = $("#couponNm").val();
	        	var dscntRate = $("#dscntRate").val();
	        	var registStartDt = $("#registStartDt").val();
	        	var registEndDt = $("#registEndDt").val();
	        	var usePeriod = $("#usePeriod").val();
	        	
        		$.post(
					"/admin/couponMakeAjax",
					{	couponId : couponId,
						couponNm : couponNm,
						dscntRate : dscntRate,
						registStartDt : registStartDt,
						registEndDt : registEndDt,
						usePeriod : usePeriod
					},
					function(data){
						var result = data.result;
						if(result == 'Y'){
							alert("쿠폰생성");
							location.href = "/admin/couponList";
						}else{
							alert("변경실패");
							return false;
						}
					}
				);
	        }else{
	            location.href = "/admin/couponList";
	        }
	    }
		
	</script>
</body>
</html>