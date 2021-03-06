<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="/resources/css/header.css" rel="stylesheet" type="text/css">

<!-- header -->
	<header class="header">
		<div class="gnb">
			<div class="right">
				<c:choose>
					<c:when test="${sessionLoginChk eq 'user'}">
						<div class="afterLogin">
							<span title="회원이름">${sessionUserNm}</span>
							|
							<a href="/member/myInfo" title="마이페이지">마이페이지</a>
							|
							<a href="/login/logout" title="로그아웃">로그아웃</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="beforeLogin">
							<a href="/login/login" title="로그인">로그인</a>
							|
							<a href="/login/join" title="회원가입">회원가입</a>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="img">
			<a href="/">
				<img src="/resources/images/logo.png" alt="로고">
			</a>
		</div>
		<br>
		<div class="nav">
			<div class="navList">
				<button>
					<img src="/resources/images/menu.png" alt="사이트맵">
				</button>
				<ul>
					<li>
						<a href="#" title="예매">예매</a>
						<div style="display:none;">
							<ul style="opacity:0;">
								<li>
									<a href="#" title="예매하기">예매하기</a>
								</li>
								<li>
									<a href="#" title="상영시간표">상영시간표</a>
								</li>
							</ul>
						</div>	
					</li>
					<li>
						<a href="#" title="영화">영화</a>
						<div style="display:none;">
							<ul style="opacity:0;">
								<li>
									<a href="#" title="홈">홈</a>
								</li>
								<li>
									<a href="#" title="현재상영작">현재상영작</a>
								</li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</header>
<!-- /header -->