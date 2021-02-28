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

<!-- 라이브러리 -->
<script src="resources/lib/jquery-3.5.1.min.js"></script>

</head>
<body class="body-iframe">
    <div class="inner-wrap">
        <div class="title"><h2>빠른 예매</h2></div>
        <div class="main-wrap">
            <div class="time-schedule">
                <div>
                    <ul class="time-schedule-slides" id="time-schedule-slides">
                        <li><button class="btn on"><span class="year-month" style="display: none"></span><span class="day"></span></button></li>
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
    <script>
        // 날짜

        $(document).ready(function(){
            let i, build_date;
            const yearMonth =  document.getElementsByClassName("year-month");
            const day =  document.getElementsByClassName("day");

            for(i = 0; i < slideCount; i++){
                build_date =  buildDate(i);
                yearMonth[i].innerHTML = build_date.year + "." + build_date.month;
                day[i].innerHTML = build_date.date + "." + build_date.day; 
            }
            
        });

        function buildDate(index){
                let today = new Date();

                const week = ['일', '월', '화', '수', '목', '금', '토'];
                
                let buildDate = new Date(today);
                
                buildDate.setDate(buildDate.getDate()+index);

                let date = {"year" : buildDate.getFullYear(),
                            "month" : buildDate.getMonth() + 1,
                            "date" : buildDate.getDate(),
                            "day" : week[buildDate.getDay()]
                };

                return date;
               
            };

        let slides = document.querySelector(".time-schedule-slides"),
            slide = document.querySelectorAll(".time-schedule-slides li"),
            currentIdx = 0,
            slideCount = slide.length,
            prevBtn = document.querySelector(".time-schedule .prev"),
            slideWidth = 70,
            slideMargin = 6,
            nextBtn = document.querySelector(".time-schedule .next");

            slides.style.width = (slideWidth * slideCount) + "px";

            function moveSlide(num){
                slides.style.left = -num * 70 + "px";
                currentIdx = num;
            };

            nextBtn.addEventListener("click", function(){
                if(currentIdx < slideCount - 1){
                    moveSlide(currentIdx + 1);
                }
            });

            prevBtn.addEventListener("click", function(){
                if(currentIdx > 0){
                    moveSlide(currentIdx - 1);
                }
            });

            nextBtn.addEventListener("click", function(){
                
                // 같은 코드
                // var li = document.createElement("li");
                // li.innerHTML  = slides.lastElementChild.innerHTML;
                // slides.appendChild(li);

                slideCount += 1;
                slides.style.width = (slideWidth * slideCount) + "px";

                const cloneObject = slides.lastElementChild.cloneNode(true);
                
                const yearMonth = cloneObject.getElementsByClassName("year-month");
                const day = cloneObject.getElementsByClassName("day");
                
                const index = day[0].innerHTML.split(".")[0];
                const build_date = buildDate(slideCount-1);

                yearMonth[0].innerHTML = build_date.year + "." + build_date.month;
                day[0].innerHTML = build_date.date + "." + build_date.day;

                slides.appendChild(cloneObject);
            });
            
            document.getElementById("time-schedule-slides").addEventListener("click", function(event){
                const btn = event.target.parentElement;
                const slide = document.querySelectorAll(".time-schedule-slides li")

                slide.forEach(function(btn){
                    if(btn.firstChild.classList.contains("on")){
                        btn.firstChild.classList.remove("on");
                    }
                });

                btn.classList.add("on");
            });

            slide.forEach(function(btn){
                btn.addEventListener("mouseover", function(e){
                    e.currentTarget.querySelector(".year-month").style.display = "block";
                }); 
                
                btn.addEventListener("mouseout", function(e){
                    e.currentTarget.querySelector(".year-month").style.display = "none";
                });
            });

        // 시간
        let hour_slides = document.querySelector(".hour-schedule-slides"),
            hour_slide = document.querySelectorAll(".hour-schedule-slides li"),
            hour_currentIdx = 0,
            hour_slideCount = hour_slide.length,
            hour_prevBtn = document.querySelector(".hour-schedule .prev"),
            hour_slideWidth = 35,
            hour_nextBtn = document.querySelector(".hour-schedule .next");

            hour_slides.style.width = (hour_slideWidth * hour_slideCount) + "px";

            function moveHourSlide(num){
                hour_slides.style.left = -num * 35 + "px";
                hour_currentIdx = num;
            };
            
            hour_nextBtn.addEventListener("click", function(){
                if(hour_currentIdx < hour_slideCount - 1){
                    if(hour_currentIdx < hour_slideCount -10){
                        moveHourSlide(hour_currentIdx + 1);
                    }
                }
            });

            hour_prevBtn.addEventListener("click", function(){
                if(hour_currentIdx > 0){
                    moveHourSlide(hour_currentIdx - 1);
                }
            });

            // 영화 초기 데이터
            let movie = [
                {
                    id: 1,
                    title: "원더우먼",
                    category: "movie-all",
                    grade: "12",
                    img: "img/wonderwomen.jpg"
                },
                {
                    id: 2,
                    title: "완벽한 가족",
                    category: "movie-curation",
                    grade: "15",
                    img: "img/perfectfamily.jpg"
                },
                {
                    id: 3,
                    title: "빅풋주니어2:패밀리가 떴다",
                    category: "movie-all",
                    grade: "15",
                    img: "img/bigfoot.jpg"
                }
            ]
            
            const all = document.querySelector("#movie-all-list");
            const curation = document.querySelector("#movie-curation-list");
            const all_ul = document.querySelector("#movie-all-list ul");
            const curation_ul = document.querySelector("#movie-curation-list ul");
            const tabBtns = document.querySelectorAll(".tab-btn");
            let list = [];

            // 초기 영화 받아오기
            window.addEventListener("DOMContentLoaded", function(){
                displayMovieItems(movie, "movie-all");
                list = document.querySelectorAll("#movie-all-list ul li");
                clickList(list);
            });

            // 날짜 눌렀을때 영화 받아오기
            slide.forEach(function(btn){
                btn.addEventListener("click", function(e){
                    // 날짜
                    // console.log(e.target);
                    // ajax로 받아오는 코드 필요
                    movie = [
                    {
                    id: 1,
                    title: "원더우먼11",
                    category: "movie-all",
                    grade: "12",
                    img: "img/wonderwomen.jpg"
                },
                {
                    id: 2,
                    title: "완벽한 가족11",
                    category: "movie-curation",
                    grade: "15",
                    img: "img/perfectfamily.jpg"
                },
                {
                    id: 3,
                    title: "빅풋주니어2:패밀리가 떴다11",
                    category: "movie-all",
                    grade: "15",
                    img: "img/bigfoot.jpg"
                }
                    ];
                    displayMovieItems(movie, "movie-all");
                });
                
            });

            // 탭 버튼
            tabBtns.forEach(function(btn){
                btn.addEventListener("click", function(e){
                    var category = e.currentTarget.dataset.id;
                    var menuCategory = movie.filter(function(movie){
                        if(movie.category === category){
                            return movie;
                        }
                    });
                    if(category === "movie-all"){
                        activeTab(btn);
                        list = displayMovieItems(movie, category);
                        clickList(list);
                    } else{
                        activeTab(btn);
                        list = displayMovieItems(menuCategory, category);
                        clickList(list);
                    }
                });
            });

            function displayMovieItems(movie, category){
                let displayMovie = movie.map(function(item){
                    return '<li>
                                <button class="btn" img-path="${item.img}">
                                    <span class="movie-grade"><div class="circle">${item.grade}</div></span>
                                    <span class="movie-name" data-id="${item.id}">${item.title}</span>
                                </button>
                            </li>`;
                });
                
                displayMovie = displayMovie.join("");
                if(category === "movie-all"){
                    all_ul.innerHTML = displayMovie;
                    return document.querySelectorAll("#movie-all-list ul li");
                } else{
                    curation_ul.innerHTML = displayMovie;
                    return document.querySelectorAll("#movie-curation-list ul li");
                }
                
            }

            const btnAll = document.getElementById("movie-all");
            const btnCuration = document.getElementById("movie-curation");

            function activeTab(btn){
                
                if(btn.id === "movie-all"){
                    btn.classList.add("active");
                    btnCuration.classList.remove("active");
                    all.style.display = "block";
                    curation.style.display = "none";
                } else{
                    btn.classList.add("active");
                    btnAll.classList.remove("active");
                    curation.style.display = "block";
                    all.style.display = "none";
                }
            }

            let count = choiceMovieList.getElementsByClassName("wrap").length;

            function clickList(list){
                
                const choiceMovieList = document.getElementById("choiceMovieList");
                const choiceMovieNone = document.getElementById("choiceMovieNone");
                const no_result = document.querySelector(".no-result");
                const result = document.querySelector(".result");


                list.forEach(function(movie){
                    movie.addEventListener("click", function(e){
                        const btn = e.currentTarget.getElementsByClassName("btn")[0];
                        if(count >= 3){
                            if(btn.classList.contains("on")){
                            btn.classList.remove("on")
                            removeMovieList(e);
                            } else{
                                alert("영화는 최대 3개까지 추가 가능합니다");
                            }
                        } else{
                            if(btn.classList.contains("on")){
                                btn.classList.remove("on")
                                removeMovieList(e);
                            } else {
                                btn.classList.add("on")
                                addMovieList(movie);
                                choiceMovieNone.style.display = "none";
                                choiceMovieList.style.display = "block";
                                no_result.style.display = "none";
                                result.style.display = "block";
                            }
                        }

                        if(count <= 0){
                            choiceMovieNone.style.display = "block";
                            choiceMovieList.style.display = "none";
                            no_result.style.display = "block";
                            result.style.display = "none";
                        }
                    });
                });
            }

            // // 버튼 클릭시 영화/시간인지 확인하여 맞은 view-area가 보여야한다
            let movieArr = [];

            function addMovieList(movie){
                const choiceMovieList = document.getElementById("choiceMovieList");
                const choiceMovieNone = document.getElementById("choiceMovieNone");
                const movie_id = movie.getElementsByClassName("movie-name")[0].dataset.id;

                var bg = choiceMovieList.getElementsByClassName("bg")
                
                if(count < 3){
                    if(movieArr.indexOf(movie_id) === -1){
                        createWrap(movie, bg, count);
                        movieArr.push(movie_id);
                        count++;
                        displayMovieTimes(movie_time, movieArr);
                    }
                } 
            };

            function createWrap(movie, bg, count){
                var img_path = movie.getElementsByClassName("btn")[0].getAttribute("img-path");
                var movie_id = movie.getElementsByClassName("movie-name")[0].dataset.id;
                var wrap = document.createElement("div");
                wrap.className = "wrap";
                var image = document.createElement("div");
                image.className = "img";
                var img = document.createElement("img");
                img.src = img_path;
                img.dataset.id = movie_id;
                var button = document.createElement("button");
                button.className = "del";
                bg[count].append(wrap);
                wrap.append(image);
                image.append(img);
                wrap.append(button);
                return wrap;
            };

            function removeMovieList(e){
                var movie_id = e.currentTarget.getElementsByClassName("movie-name")[0].dataset.id;
                removeWrap(e.currentTarget);
                const movieIdx = movieArr.indexOf(movie_id);
                movieArr.splice(movieIdx, 1);
                count--;
                const timeIdx = timeArr.indexOf(movie_id);
                timeArr.forEach(function(item){
                    if(item.movie_id === parseInt(movie_id)){
                        timeArr.splice(timeIdx, 1);
                    }
                });
                displayMovieTimes(movie_time, movieArr);
            }

            function removeWrap(movie){
                var bg = document.querySelectorAll("#choiceMovieList .bg");
                var movie_id = movie.getElementsByClassName("movie-name")[0].dataset.id;
                bg.forEach(function(item){
                    if(item.getElementsByClassName("wrap").length != 0){
                        if(movie_id === item.querySelector("img").dataset.id){
                            var bg = item.firstChild;
                            bg.parentNode.removeChild(bg);
                        }
                    }
                });
            }

            // 삭제했을때 앞으로 당기는 코드
            // function moduleBg(){

            // }

            // 영화 시간(요일별)
            let movie_time = [
                {
                    movie_id: 1,
                    detail_id: 1,
                    movie_title: "원더우먼",
                    start_time: "08:00",
                    end_time: "10:00",
                    screen: "2D",
                    total_seat : 130,
                    reserved_seat: 30
                },
                {
                    movie_id: 2,
                    detail_id: 1,
                    movie_title: "완벽한 가족",
                    start_time: "09:00",
                    end_time: "11:00",
                    screen: "2D",
                    total_seat : 130,
                    reserved_seat: 30
                },
                {
                    movie_id: 1,
                    detail_id: 2,
                    movie_title: "원더우먼",
                    start_time: "13:00",
                    end_time: "15:00",
                    screen: "3D",
                    total_seat : 130,
                    reserved_seat: 30
                },
                {
                    movie_id: 3,
                    detail_id: 1,
                    movie_title: "빅풋주니어2:패밀리가 떴다",
                    start_time: "13:30",
                    end_time: "15:00",
                    screen: "2D",
                    total_seat : 130,
                    reserved_seat: 30
                }
            ];
            
            const time_ul = document.querySelector(".movie-schedule-area ul");
            let timeArr = [];

            function displayMovieTimes(movie_time, movieArr){
                
                let filter_time = movie_time.filter(function(movie_time){
                    let filter_time;
                    movieArr.forEach(function(item){
                        if(movie_time.movie_id === parseInt(item)){
                            filter_time = movie_time
                        }
                    });
                    return filter_time;
                });

                let displayMovieTime = filter_time.map(function(item){
                    return `<li>
                                <button class="btn">
                                    <div class="legend"></div>
                                    <span class="time">
                                        <strong>${item.start_time}</strong>
                                        <p> ~${item.end_time}</p>
                                    </span>
                                    <span class="title">
                                        <strong>${item.movie_title}</strong>
                                        <p>${item.screen}</p>
                                    </span>
                                    <div class="info">
                                        <span class="seat">
                                            <strong class="now">${item.reserved_seat}</strong>
                                            <span>/</span>
                                            <strong class="all">${item.total_seat}</strong>
                                        </span>
                                    </div>
                                </button>
                            </li>`;
                });

                displayMovieTime = displayMovieTime.join("");
                time_ul.innerHTML = displayMovieTime;

            }

            // function getTimeByMovie(movie, count){
            //     // 영화에 맞는 시간 가져오기
            //     // 시간에 뿌려주기
            // };

            let down = document.querySelectorAll(".count .down");
            let up = document.querySelectorAll(".count .up");
            let number = document.querySelectorAll(".count .now");
            let adultNum = document.querySelector(".adult .now");
            let teenNum = document.querySelector(".teenager .now");
            let olderNum = document.querySelector(".older .now");

            const adultPrice = 12000;
            const teenagerPrice = 8000;
            const olderPrice = 5000;


            const initBtn = document.getElementById("seatMemberCntInit");

            initBtn.addEventListener("click", function(){
                // 초기화
            });


            for(var i = 0; i < down.length; i++){
                    
                down[i].addEventListener("click", function(){
                if(this.parentNode.classList.contains("adult") && parseInt(adultNum.textContent) > 0){
                    adultNum.textContent = adultNum.textContent - 1;
                } else if(this.parentNode.classList.contains("teenager") && parseInt(teenNum.textContent) > 0){
                    teenNum.textContent = teenNum.textContent - 1;
                } else if(this.parentNode.classList.contains("older") && parseInt(olderNum.textContent) > 0){
                    olderNum.textContent = olderNum.textContent - 1;
                }
                
                });
            }

            for(var i = 0; i < up.length; i++){
                    
                    up[i].addEventListener("click", function(){
                    if(this.parentNode.classList.contains("adult")){
                        adultNum.textContent = parseInt(adultNum.textContent) + 1;
                    } else if(this.parentNode.classList.contains("teenager")){
                        teenNum.textContent = parseInt(teenNum.textContent) + 1;
                    } else if(this.parentNode.classList.contains("older")){
                        olderNum.textContent = parseInt(olderNum.textContent) + 1;
                    }
                    
                    });
                }
           

    </script>
</body>
</html>