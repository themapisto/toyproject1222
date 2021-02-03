<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="dennis" />
<meta name="description" content="영화 사이트 토이프로젝트입니다" />
<meta name="keywords" content="메가박스, CGV, 롯데시네마, 영화">
<title>영화 예매 페이지</title>

<!-- CSS -->
<link rel="stylesheet" href="resources/css/reset.css" type="text/css">
<link rel="stylesheet" href="resources/css/ticketing.css"
	type="text/css">

<!-- 아이콘 -->
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"></script>

</head>
<body class="body-iframe">
    <div class="inner-wrap">
        <div class="title"><h2>빠른 예매</h2></div>
        <div class="main-wrap">
            <div class="time-schedule">
                <div>
                    <ul class="time-schedule-slides" id="time-schedule-slides">
                        <li><button class="btn on"><div class="year-month" style="display: none"></div><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                        <li><button class="btn"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
                    </ul>
                </div>
                <p class="controls">
                    <span class="prev"><i class="fas fa-angle-left"></i></span>
                    <span class="next"><i class="fas fa-angle-right"></i></span>
                </p>
            </div>
            <div class="info-wrap">
                <div class="movie-choice">
                    <div class="title-area">
                        <p class="title">영화</p>
                    </div>
                    <div class="list-area">
                        <div class="movie-list">
                            <div class="menu-tab">
                                <button class="tab-btn active" id="movie-all" data-id="movie-all">전체</button>
                                <button class="tab-btn" id="movie-curation" data-id="movie-curation">큐레이션</button>
                            </div>
                            <div class="list">
                                <div class="tab-content" id="movie-all-list" style="display: block;">
                                    <ul>
                                    </ul>
                                </div>
                                <div class="tab-content" id="movie-curation-list" style="display: none;">
                                    <ul>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="view-area">
                        <!-- 영화 선택 안했을 때 -->
                        <div class="choice-no" id="choiceMovieNone" style="display: block;">
                            <strong>모든영화</strong>
                            <span>목록에서 영화를 선택하세요</span>
                        </div>
                        <!-- 영화 선택 했을 때 -->
                        <div class="choice-list" id="choiceMovieList" style="display: none;">
                            <div class="bg"></div>
                            <div class="bg"></div>
                            <div class="bg"></div>
                        </div>
                    </div>
                </div>
                <div class="time-choice">
                    <div class="title-area">
                        <p class="title">시간</p>
                        <div class="time-info">
                            <span style="color: rgb(255,200,118);"><i class="fas fa-sun"></i>조조</span>
                            <span style="color: rgb(165,135,102);"><i class="fas fa-mug-hot"></i>브런치</span>
                            <span style="color: rgb(81,194,231);"><i class="fas fa-moon"></i>심야</span>
                        </div>
                    </div>
                    <div style="clear:both;"></div>
                    <div class="hour-schedule">
                        <div class="wrap">
                            <div>
                                <ul class="hour-schedule-slides" id="hour-schedule-slides">
                                    <li><button class="btn"><span class="hour">00</span></button></li>
                                    <li><button class="btn"><span class="hour">01</span></button></li>
                                    <li><button class="btn"><span class="hour">02</span></button></li>
                                    <li><button class="btn"><span class="hour">03</span></button></li>
                                    <li><button class="btn"><span class="hour">04</span></button></li>
                                    <li><button class="btn"><span class="hour">05</span></button></li>
                                    <li><button class="btn"><span class="hour">06</span></button></li>
                                    <li><button class="btn"><span class="hour">07</span></button></li>
                                    <li><button class="btn"><span class="hour">08</span></button></li>
                                    <li><button class="btn"><span class="hour">09</span></button></li>
                                    <li><button class="btn"><span class="hour">10</span></button></li>
                                    <li><button class="btn"><span class="hour">11</span></button></li>
                                    <li><button class="btn"><span class="hour">12</span></button></li>
                                    <li><button class="btn"><span class="hour">13</span></button></li>
                                    <li><button class="btn"><span class="hour">14</span></button></li>
                                    <li><button class="btn"><span class="hour">15</span></button></li>
                                    <li><button class="btn"><span class="hour">16</span></button></li>
                                    <li><button class="btn"><span class="hour">17</span></button></li>
                                    <li><button class="btn"><span class="hour">18</span></button></li>
                                    <li><button class="btn"><span class="hour">19</span></button></li>
                                    <li><button class="btn"><span class="hour">20</span></button></li>
                                    <li><button class="btn"><span class="hour">21</span></button></li>
                                    <li><button class="btn"><span class="hour">22</span></button></li>
                                    <li><button class="btn"><span class="hour">23</span></button></li>
                                    <li><button class="btn"><span class="hour">24</span></button></li>
                                </ul>
                            </div>    
                        </div>
                        <p class="controls">
                            <span class="prev"><i class="fas fa-angle-left"></i></span>
                            <span class="next"><i class="fas fa-angle-right"></i></span>
                        </p>
                    </div>
                    <div class="movie-schedule-area">
                        <!-- 영화관 선택 안했을 때 -->
                        <div class="no-result" style="display: block;">
                            <p>영화 시간을 선택하시면</p>
                            <p>좌석을 볼 수 있습니다</p>
                        </div>
                        <!-- 영화관 선택 했을 때 -->
                        <div class="result" style="display: none;">
                            <ul>
                                <!-- <li>
                                    <button class="btn">
                                        <div class="legend"></div>
                                        <span class="time">
                                            <strong>10:00</strong>
                                            <p>12:00</p>
                                        </span>
                                        <span class="title">
                                            <strong>영화 제목</strong>
                                            <p>2D(자막)</p>
                                        </span>
                                        <div class="info">
                                            <span class="seat">
                                                <strong class="now">25</strong>
                                                <span>/</span>
                                                <strong class="all">130</strong>
                                            </span>
                                        </div>
                                    </button>
                                </li>
                                <li>
                                    <button class="btn">
                                        <div class="legend"></div>
                                        <span class="time">
                                            <strong>10:00</strong>
                                            <p>12:00</p>
                                        </span>
                                        <span class="title">
                                            <strong>영화 제목</strong>
                                            <p>2D(자막)</p>
                                        </span>
                                        <div class="info">
                                            <span class="seat">
                                                <strong class="now">25</strong>
                                                <span>/</span>
                                                <strong class="all">130</strong>
                                            </span>
                                        </div>
                                    </button>
                                </li>
                                <li>
                                    <button class="btn">
                                        <div class="legend"></div>
                                        <span class="time">
                                            <strong>10:00</strong>
                                            <p>12:00</p>
                                        </span>
                                        <span class="title">
                                            <strong>영화 제목</strong>
                                            <p>2D(자막)</p>
                                        </span>
                                        <div class="info">
                                            <span class="seat">
                                                <strong class="now">25</strong>
                                                <span>/</span>
                                                <strong class="all">130</strong>
                                            </span>
                                        </div>
                                    </button>
                                </li>
                                <li>
                                    <button class="btn">
                                        <div class="legend"></div>
                                        <span class="time">
                                            <strong>10:00</strong>
                                            <p>12:00</p>
                                        </span>
                                        <span class="title">
                                            <strong>영화 제목</strong>
                                            <p>2D(자막)</p>
                                        </span>
                                        <div class="info">
                                            <span class="seat">
                                                <strong class="now">25</strong>
                                                <span>/</span>
                                                <strong class="all">130</strong>
                                            </span>
                                        </div>
                                    </button>
                                </li> -->
                            </ul>
                        </div>
                    </div>
                </div> 
                <div class="seat-section">
                    <div class="title-area">
                        <p class="title">관람인원선택</p>
                        <div class="reset">
                            <button id="seatMemberCntInit">초기화</button>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <div class="seat-area">
                        <div class="seat-count">
                            <div class="cell">
                                <p class="txt">성인</p>
                                <div class="count adult">
                                    <button class="down">-</button>
                                    <div class="number">
                                        <button class="now">0</button>
                                        <ul>
                                            <li></li>
                                        </ul>
                                    </div>
                                    <button class="up">+</button>
                                </div>
                            </div>
                            <div class="cell">
                                <p class="txt">청소년</p>
                                <div class="count teenager">
                                    <button class="down">-</button>
                                    <div class="number">
                                        <button class="now">0</button>
                                        <ul>
                                            <li></li>
                                        </ul>
                                    </div>
                                    <button class="up">+</button>
                                </div>
                            </div>
                            <div class="cell">
                                <p class="txt">우대</p>
                                <div class="count older">
                                    <button class="down">-</button>
                                    <div class="number">
                                        <button class="now">0</button>
                                        <ul>
                                            <li></li>
                                        </ul>
                                    </div>
                                    <button class="up">+</button>
                                </div>
                            </div>
                        </div>
                         <!-- 영화 시간 선택 안했을 때 -->
                         <div class="no-result" style="display: block;">
                            <p>영화를 선택하시면</p>
                            <p>상영시간표를 비교하여 볼 수 있습니다</p>
                        </div>
                        <!-- 영화 시간 선택 했을 때 -->
                        <div class="result" style="display: none;">
                            <div class="seat-layout">
                                <div class="inner-seat-layout">
                                    <div class="screen">SCREEN</div>
                                    <div class="row">
                                        <button rownm="A" class="btn-seat-row" disabled>A</button>
                                        <button rownm="A" class="seat-condition common" style="left: 38px;"></button>
                                        <button rownm="A" class="seat-condition finish" style="left: 60px;"></button>
                                        <button rownm="A" class="seat-condition common" style="left: 98px;"></button>
                                        <button rownm="A" class="seat-condition finish" style="left: 120px;"></button>
                                        <button rownm="A" class="seat-condition common" style="left: 142px;"></button>
                                        <button rownm="A" class="seat-condition finish" style="left: 180px;"></button>
                                        <button rownm="A" class="seat-condition common" style="left: 202px;"></button>
                                    </div>
                                    <div class="row">
                                        <button rownm="A" class="btn-seat-row" disabled>B</button>
                                        <button rownm="A" class="seat-condition common" style="left: 38px;"></button>
                                        <button rownm="A" class="seat-condition finish" style="left: 60px;"></button>
                                        <button rownm="A" class="seat-condition common" style="left: 98px;"></button>
                                        <button rownm="A" class="seat-condition finish" style="left: 120px;"></button>
                                        <button rownm="A" class="seat-condition common" style="left: 142px;"></button>
                                        <button rownm="A" class="seat-condition finish" style="left: 180px;"></button>
                                        <button rownm="A" class="seat-condition common" style="left: 202px;"></button>
                                    </div>
                                    <div class="row">
                                        <button rownm="A" class="btn-seat-row" disabled>C</button>
                                        <button rownm="A" class="seat-condition common" style="left: 38px;"></button>
                                        <button rownm="A" class="seat-condition finish" style="left: 60px;"></button>
                                        <button rownm="A" class="seat-condition common" style="left: 98px;"></button>
                                        <button rownm="A" class="seat-condition finish" style="left: 120px;"></button>
                                        <button rownm="A" class="seat-condition common" style="left: 142px;"></button>
                                        <button rownm="A" class="seat-condition finish" style="left: 180px;"></button>
                                        <button rownm="A" class="seat-condition common" style="left: 202px;"></button>
                                    </div>
                                </div>
                            </div>
                            <div class="seat-result">
                                <div class="choice-seat-area">
                                    <div class="legend">
                                        <ul class="list">
                                            <li>
                                                <div class="seat-condition choice" title="선택한 좌석"></div>
                                                <p>선택</p>
                                            </li>
                                            <li>
                                                <div class="seat-condition finish" title="예매 완료"></div>
                                                <p>예매완료</p>
                                            </li>
                                            <li>
                                                <div class="seat-condition impossible" title="선택 불가"></div>
                                                <p>선택불가</p>
                                            </li>
                                            <li>
                                                <div class="seat-condition pos" title="띄어앉기석"></div>
                                                <p>띄어앉기석</p>
                                            </li>
                                            <li>
                                                <div class="seat-condition common" title="일반"></div>
                                                <p>일반</p>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="seat-num">
                                        <p class="tit">선택좌석</p>
                                        <div class="my-seat">
                                            <div class="seat all" title="구매가능 좌석">-</div>
                                            <div class="seat all" title="구매가능 좌석">-</div>
                                            <div class="seat all" title="구매가능 좌석">-</div>
                                            <div class="seat all" title="구매가능 좌석">-</div>
                                            <div class="seat all" title="구매가능 좌석">-</div>
                                            <div class="seat all" title="구매가능 좌석">-</div>
                                            <div class="seat all" title="구매가능 좌석">-</div>
                                            <div class="seat all" title="구매가능 좌석">-</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="pay-wrap">
                                    <div class="pay-area">
                                        <p class="count"></p>
                                        <div class="pay">
                                            <p class="tit">최종결제금액</p>
                                            <div class="money">
                                                <p>0</p>
                                                <span>원</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="btn-group">
                                        <a href="#" class="button" id="pagePrevious" title="이전">이전</a>
                                        <a href="#" class="button disabled" id="pageNext" title="다음">다음</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="resources/lib/jquery-3.5.1.min.js"></script>
    <script src="resources/js/ticketing.js"></script>
</body>
</html>