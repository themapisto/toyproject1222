<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- sidebar -->
	<aside id="lnb">
	    <div id="lnbTitle">관리자 메뉴</div>
	    <ul id="lnbNav">
	        <li class="menu" id="menu1">
	            <div><a>통합회원관리</a></div>
	            <ul>
	                <li><a href="/admin/userList?grade=1">회원관리</a></li>
	                <li><a>관리자관리</a></li>
	            </ul>
	        </li>
	        <li class="menu" id="menu2">
	            <div><a>사이트관리</a></div>
	            <ul>
	                <li><a>공지사항관리</a></li>
	                <li><a>홈페이지메뉴관리</a></li> 
	            </ul>
	        </li>
	        <li class="menu" id="menu3">
	            <div><a>예매관리</a></div>
	            <ul>
	                <li><a>결제내역</a></li>
	                <li><a>할인관련</a></li> 
	            </ul>
	        </li>
	    </ul>
	</aside>
<!-- /sidebar -->

	<script type="text/javascript">
	    $(".menu").on("click",function(){
	        $(this).find("ul").css("display","block");
	        $(this).siblings(".menu").find("ul").css("display","none");
	    });
	</script>