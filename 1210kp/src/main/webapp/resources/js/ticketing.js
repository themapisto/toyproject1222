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