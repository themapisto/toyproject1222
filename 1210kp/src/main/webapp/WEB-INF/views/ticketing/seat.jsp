<%-- <%@page import="bit.com.a.model.MemberDto"%> --%>
<%@page import="com.kdis.demo.vo.ReserveDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%--  <%
MemberDto login = (MemberDto)session.getAttribute("login");
%>  --%>
<%  ReserveDto reserve = (ReserveDto) request.getAttribute("reserve");%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
 
    <link rel="stylesheet" href="/resources/css/reset.css">
    <!-- <link rel="stylesheet" href="/resources/css/header.css"> -->
    <link rel="stylesheet" href="/resources/css/layer_popup.css">
    <link rel="stylesheet" href="/resources/css/seat.css">
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
    <link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css' />
    <script src='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js'></script>
    <script src="https://www.paypal.com/sdk/js?client-id=AQPrrIuemnOd2qvQmtxdrRwxteZcdhs3o-0y5hZxVAdr5NqGarbDmeY0jExpXYGIVXDVK7oRpRqJ6yhz"></script>
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
	<div class="select-container">
		<div class="select-wrapper">
			<div class="select-title">인원/좌석</div>
			<div class="select-seat-container">
				<div class="select-seat-number-container">
					<div class="select-seat-number-wrapper">
						<div class="select-seat">
							<div class="select-seat-age">일반</div>
							<div class="select-seat-number">
								<ul class="select-seat-ul select-seat-ul-normal">
									<li class="select-number-normal">0</li>
									<li class="select-number-normal">1</li>
									<li class="select-number-normal">2</li>
									<li class="select-number-normal">3</li>
									<li class="select-number-normal">4</li>
								</ul>
							</div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">청소년</div>
							<div class="select-seat-number">
								<ul class="select-seat-ul select-seat-ul-teen">
									<li class="select-number-teen">0</li>
									<li class="select-number-teen">1</li>
									<li class="select-number-teen">2</li>
									<li class="select-number-teen">3</li>
									<li class="select-number-teen">4</li>
								</ul>
							</div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">우대</div>
							<div class="select-seat-number">
								<ul class="select-seat-ul select-seat-ul-old">
									<li class="select-number-old">0</li>
									<li class="select-number-old">1</li>
									<li class="select-number-old">2</li>
									<li class="select-number-old">3</li>
									<li class="select-number-old">4</li>
								</ul>
							</div>
						</div>
						<div class="coupon">
							<button type="button" class="coupon_btn">보유 쿠폰 확인</button>
						</div>
					</div>
				</div>
				<div class="select-seat-information">
					<div class="selected-movie">${reserve.title}</div>
					<div class="select-seat-information-wrapper">
						<div class="select-theater-place selected-theater-place-info">CGV강남</div>
						<div class="select-theater-place selected-theater-place-info">4관
							6층</div>
						<div class="select-theater-place">
							<span>남은좌석</span><span class="remain-seats">240</span>/<span class="all-seats">240</span>
						</div>
					</div>
					<div class="select-theater-date">
						<div class="theater-date">${reserve.movieDate}</div>
						<div class="theater-time">${reserve.runningTime}</div>
					</div>
					<div class="selected-seats-wrapper">
						<span class="selected-seats-title">좌석번호</span>
						<span class="selected-seats">선택된 좌석이 없습니다.</span>
					</div>
					<div class="ticket-price-wrapper">
						<span class="ticket-price-title">가격</span>
						<span class="ticket-price">0원</span>
					</div>
					<div class="payment-wrapper">
						<span class="payment-title">결제하기</span>
						<form class="seatForm" action="moveReserve" method="post">
							<input type="hidden" class="title" name="title" value="${reserve.title}">
				            <input type="hidden" class="movieAge" name="movieAge" value="${reserve.movieAge}">
				            <input type="hidden" class="selectedTheater" name="selectedTheater" value="${reserve.selectedTheater}">
				            <input type="hidden" class="reserveDate" name="movieDate" value="${reserve.movieDate}">
				            <input type="hidden" class="runningTime" name="runningTime" value="${reserve.runningTime}">
				            <!-- 티켓 정보 -->
				            <input type="hidden" class="selectedSeat" name="selectedSeat">
				            <input type="hidden" class="payMoney" name="payMoney">
							<button type="button" class="reserve-btn">
								<div id="reserve-btn-wrapper"></div>
							</button>
						</form>
					</div>
				</div>
			</div>
			<div class="seat-container">
				<div class="seat-wrapper">
					<div class="screen-view-wrapper">
						<div class="screen-view">SCREEN</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 팝업창 -->
       <div class="popup" style="display:none;">
       	<div class="popup_layer">
       		<div class="text_area">
       			<button type="button" class="close-btn">x</button>
       			<strong class="title">쿠폰 번호 입력</strong>
       			<input type="text" id="coupon-number" class="coupon-number" name="coupon-number" maxlength="8" placeholder="쿠폰번호를 입력해주세요">
       			<button type="button" class="coupon-find">확인</button>
       		</div>
       	</div>
       	<div class="popup_dimmed"></div>
       </div>
</body>
<script src="resources/js/seat.js"></script>
</html>