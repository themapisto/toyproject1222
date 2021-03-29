<%-- <%@page import="bit.com.a.model.MemberDto"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%--  <%
MemberDto login = (MemberDto)session.getAttribute("login");
%>  --%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
 
    <link rel="stylesheet" href="/resources/css/reset.css">
    <!-- <link rel="stylesheet" href="/resources/css/header.css"> -->
    <link rel="stylesheet" href="/resources/css/reserve.css">
    <link rel="stylesheet" href="/resources/css/layer_popup.css">
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
    <link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css' />
    <script src='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js'></script>
</head>

<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
    <%-- <div class="header-nav-wrapper">
        <header class="header">
            <div class="header-inner">
	            <ul class="util">
	            	<li>
	            		<a class="logo apps" href="#"></a>
	            	</li>
	            	<li>
	            		<a class="logo facebook" href="#"></a>
	            	</li>
	            	<li>
	            		<a class="logo instagram" href="#"></a>
	            	</li>
	            	<li>
	            		<a href="#">알뜰한 영화 관람법</a>
	            	</li>
	            </ul>
            </div>
            <div class="header-inner">
                
                 <% if(login != null){
                	%>
                	<div><button><%=login.getName()%>님 환영합니다</button></div>
                	<div><a href="#"><button>마이페이지</button></a></div>
                	<div><a href="#"><button>로그아웃</button></a></div>
                	<%
                } else {
                	%>
                	<div><a href="#"><button>로그인</button></a></div>
                	<div><a href="#"><button>회원가입</button></a></div>
                	<%
                }
                %> 
            </div>
        </header>
        <nav class="nav-wrapper">
            <div class="logo-wrapper"><a href="#"><img class="cgvLogo" src="https://img.cgv.co.kr/R2014/images/title/h1_cgv.png"></a></div>
            <div class="nav-content">
                <div class="movieLogo-wrapper"><img class="cgvMovie" src="https://img.cgv.co.kr/R2014/images/title/h2_ticket.png"></div>
                <div class="nav-inner">
                    <div><button>영화</button></div>
                    <div><button>예매</button></div>
                    <div><button>극장</button></div>
                    <div><button>이벤트&컬쳐</button></div>
                    <div class="search-wrapper"><input><button class="searchButton">검색</button></div>
                </div>
            </div>
            <div></div>
            <div></div>
        </nav>
    </div> --%>
    <div class="reserve-container">
        <div class="movie-part">
            <div class="reserve-title">영화</div>
            <div class="sort-wrapper">
                <div class="sort-rate sort-selected">예매율순</div>
            </div>
             <div class="movie-list-wrapper">
            </div>
        </div>
        <div class="theater-part">
            <div class="reserve-title">
                극장
            </div>
            <div class="theater-container">
                <div class="theater-wrapper">
                    <div class="theater-location-wrapper">
                        <button class="theater-location">서울(30)</button>
                        <button class="theater-location">경기(43)</button>
                        <button class="theater-location">인천(10)</button>
                        <button class="theater-location">강원(5)</button>
                    </div>
                    <div class="theater-place-wrapper">
                        <button class="theater-place">천호</button>
                        <button class="theater-place">강변</button>
                        <button class="theater-place">건대입구</button>
                        <button class="theater-place">구로</button>
                        <button class="theater-place">대학로</button>
                        <button class="theater-place">동대문</button>
                        <button class="theater-place">목동</button>
                        <button class="theater-place">명동</button>
                        <button class="theater-place">미아</button>
                        <button class="theater-place">불광</button>
                        <button class="theater-place">상봉</button>
                        <button class="theater-place">송파</button>
                        <button class="theater-place">수유</button>
                        <button class="theater-place">압구정</button>
                        <button class="theater-place">여의도</button>
                        <button class="theater-place">영등포</button>
                        <button class="theater-place">왕십리</button>
                        <button class="theater-place">중계</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="day-part">
            <div class="reserve-title">날짜</div>
            <div class="reserve-date"></div>
        </div>
        <div class="time-part">
            <div class="reserve-title">시간</div>
            <div class="reserve-time">
                <div class="reserve-where">4관(IMAX) 6층(총 240석) </div>
                <div class="reserve-time-wrapper">
                    <button class="reserve-time-button">
			            <span class="reserve-time-want">12:10</span>
			            <span class="reserve-time-remain">240석</span>
		          	</button>
                    <button class="reserve-time-button">
			            <span class="reserve-time-want">14:25</span>
			            <span class="reserve-time-remain">240석</span>
		          	</button>
                    <button class="reserve-time-button">
			            <span class="reserve-time-want">16:30</span>
			            <span class="reserve-time-remain">240석</span>
		          	</button>
                    <button class="reserve-time-button">
			            <span class="reserve-time-want">18:05</span>
			            <span class="reserve-time-remain">240석</span>
		          	</button>
                </div>
            </div>
            <div>
	            <form class="moveSeatForm" action="moveSeat" method="post">
		            <input type="hidden" class="title" name="title">
		            <input type="hidden" class="movieAge" name="movieAge">
		            <input type="hidden" class="selectedTheater" name="selectedTheater">
		            <input type="hidden" class="reserveDate" name="movieDate">
		            <input type="hidden" class="runningTime" name="runningTime">
		            <button class="moveSeatButton" type="button">좌석선택</button>
	            </form>
            </div>
       </div>
       <!-- 팝업창 -->
       <div class="popup" style="display:none;">
       	<div class="popup_layer">
       		<div class="text_area">
       			<strong class="title">예약 최종 확인</strong>
       			<p class="text"></p>
       		</div>
       		<div class="btn_area">
       			<button type="button" name="button" class="btn">예</button>
       			<button type="button" name="button" class="btn no">아니오</button>
       		</div>
       	</div>
       	<div class="popup_dimmed"></div>
       </div>
    </div>
    <script src="resources/js/reserve.js"></script>
</body>
</html>