<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- sidebar -->
	<aside id="lnb">
	    <div id="lnbTitle">마이페이지</div>
	    <ul id="lnbNav">
	        <li class="menu" id="menu1">
	            <div>회원정보</div>
	            <ul>
	            	<li><a href="/member/myInfo" title="회원정보">회원정보</a></li>
	                <li><a href="/member/myInfoModify" title="회원정보수정">회원정보수정</a></li>
	                <li><a href="/member/pwdChange" title="비밀번호변경">비밀번호변경</a></li>
	                <li><a href="/member/userWithdrawal" title="회원탈퇴">회원탈퇴</a></li>
	            </ul>
	        </li>
	        <li class="menu" id="menu2">
	            <div>쿠폰정보</div>
	            <ul>
	                <li><a href="/member/myCoupon" title="쿠폰내역조회">쿠폰내역조회</a></li>
	                <li><a href="/member/couponRegister" title="쿠폰등록하기">쿠폰등록하기</a></li> 
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