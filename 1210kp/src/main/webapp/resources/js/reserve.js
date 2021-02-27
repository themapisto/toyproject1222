// 영화 목록
const movie_list = document.querySelector('.movie-list');
const inputTitle = document.querySelector('.title');
const inputMovieAge = document.querySelector('.movieAge');
const inputSelectedTheater = document.querySelector('.selectedTheater');
const inputReserveDate = document.querySelector('.reserveDate');
const inputRunningTime = document.querySelector('.runningTime');
const moveSeatForm = document.querySelector('.moveSeatForm');
const moveSeatButton = document.querySelector('.moveSeatButton');
const theaterPlace = document.querySelectorAll('.theater-place');
const reserveTimeWant = document.querySelectorAll('.reserve-time-want');

// 날짜 계산
const date = new Date();
const lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
const reserveDate = document.querySelector(".reserve-date");
const weekOfDay = ["일","월","화","수","목","금","토"];
const year = date.getFullYear();
let month = date.getMonth()+1;
// 날짜 선택할 수 있는 간격
const date_len = 7;

// 팝업
const popUp = document.querySelector('.popup');
const popUpText = document.querySelector('.popup_layer .text_area .text');
const popUpBtnY = document.querySelector('.btn_area .btn');
const popUpBtnN = document.querySelector('.btn_area .btn.no');

window.addEventListener('DOMContentLoaded', function(event) {
    getMovieList();
});

// 영화 목록 얻기
function getMovieList(){
	$.get('/crawling',function(result){
		if(result){
			data = JSON.parse(result);
			setList(data);
			movieActive();	
		}
		else{
			
		}
		
	})
}

// 화면에 추가
function setList(data){
	var movieListWrapper = document.querySelector(".movie-list-wrapper"); 
	data.forEach(function(li){
		var li = addList(li.movieTitle,li.movieAge);
		movieListWrapper.append(li);
	})
}


function addList(name,grade){
	var li = document.createElement('li');
	var button = document.createElement('button');
	var span_icon = document.createElement('span');
	var span_icon_text = document.createElement('span');
	var span_text = document.createElement('span');
	
	span_icon.classList.add("movie-list-age");
	if(grade === "18세 이상"){
		span_icon.classList.add("eightteen");
		span_icon_text.innerHTML = "18";	
	}
	else if(grade === "15세 이상"){
		span_icon.classList.add("fifteen");
		span_icon_text.innerHTML = "15";
	}
	else if(grade === "12세 이상"){
		span_icon.classList.add("twelve");
		span_icon_text.innerHTML = "12";
	}
	else{
		span_icon.classList.add("all");
		span_icon_text.innerHTML = "전체";
	}
	span_icon.innerHTML = "&nbsp;";
	span_icon_text.classList.add("blind");
	span_icon_text.classList.add("movie-age");
	span_text.className = "movie-name";
	span_text.innerText = name;
	
	button.className = "movie-list-btn";
	
	button.append(span_icon);
	button.append(span_icon_text);
	button.append(span_text);
	
	li.className = "movie-list";
	li.append(button);
	return li;
}

// 영화 클릭시 active 효과
function movieActive(){
	document.querySelectorAll(".movie-list").forEach(function(li){
		li.addEventListener("click",function(){
			const movieListActive = document.querySelectorAll(".movie-list-active");
			movieListActive.forEach(function(li){
				li.classList.remove("movie-list-active");
			});
			li.classList.add("movie-list-active");
			
			// form에 setting
			inputMovieAge.value = li.childNodes[0].childNodes[1].innerText;
			inputTitle.value = li.childNodes[0].childNodes[2].innerText;
		});
	});
}

// 극장 선택시 active 효과
function theaterActive(){
	theaterPlace.forEach(function(li){
		li.addEventListener("click",function(){
			const theaterPlaceActive = document.querySelectorAll('.theater-place-active');
			theaterPlaceActive.forEach(function(li){
				li.classList.remove("theater-place-active");
			});
			li.classList.add("theater-place-active");
			
			// form에 setting
			inputSelectedTheater.value = li.innerText;
		});
	})	
}



// 날짜 계산
function getDay(){
	let change_month = true;
	reserveDate.append(year+'/'+month);
	for(i=date.getDate(); i<=date.getDate()+date_len; i++){
		const button = document.createElement("button");
		const spanWeekOfDay = document.createElement("span");
		const spanDay = document.createElement("span");
		
		button.classList.add("movie-date-wrapper");
		spanWeekOfDay.classList.add("movie-week-of-day");
		spanDay.classList.add("movie-day");
		
		let day = i;
		// 그 달의 마지막 날보다 크다면
		if(i>lastDay.getDate()){
			day=i-lastDay.getDate();
			if(day==1)
				change_month = false;
		}
		if(!change_month){
			month = month+1;
			reserveDate.append(year+'/'+month);
			change_month=true;
		}
		
		// 해당 날짜의 요일 얻기
		const dayOfWeek = weekOfDay[new Date(year+"-"+month+"-"+day).getDay()];
		
		// 요일 넣기
		if(dayOfWeek === "토"){
			spanWeekOfDay.classList.add("saturday");
			spanDay.classList.add("saturday");
		}
		else if(dayOfWeek === "일"){
			spanWeekOfDay.classList.add("sunday");
			spanDay.classList.add("sunday");
		}
		spanWeekOfDay.innerHTML = dayOfWeek;
		button.append(spanWeekOfDay);
		
		spanDay.innerHTML = day;
		button.append(spanDay);
		
		reserveDate.append(button);
		
		dayClickEvent(button);
	}
}

// 날짜 선택시 active 효과
function dayClickEvent(button){
	button.addEventListener("click",function(){
		const movieDateWrapperActive = document.querySelectorAll(".movie-date-wrapper-active");
		movieDateWrapperActive.forEach(function(list){
			list.classList.remove("movie-date-wrapper-active");
		})
		button.classList.add("movie-date-wrapper-active");
		
		// form에 setting
		inputReserveDate.value = year + '.' + month + '.' + button.childNodes[1].innerHTML
									+ '(' + button.childNodes[0].innerHTML + ')';
	});
}

// 시간 선택시 active 효과
function timeActive(){
	reserveTimeWant.forEach(function(li){
		li.addEventListener("click",function(){
			const reserveTimeActive = document.querySelectorAll('.reserve-time-active');
			reserveTimeActive.forEach(function(li){
				li.classList.remove("reserve-time-active");
			});
			li.classList.add("reserve-time-active");
			
			// form에 setting
			inputRunningTime.value = li.innerText;
		});
	});
}

function submit(){
	moveSeatButton.addEventListener("click",function(){
		if (!!inputTitle.value &&
        !!inputSelectedTheater.value &&
        !!inputReserveDate.value &&
        !!inputRunningTime.value){
			popUp.style.display = "block";
			popUpText.innerHTML = "영화: " + inputTitle.value + "</br>" +
								"극장: " + inputSelectedTheater.value + "</br>" +
								"날짜: " + inputReserveDate.value + "</br>" +
								"시간: " + inputRunningTime.value + "</br>";
			popUpBtnY.addEventListener("click",function(){
				moveSeatForm.submit();
			})
			popUpBtnN.addEventListener("click",function(){
				console.log('!');
				popUp.style.display="none";
			});
		}else{
			toastr.options = {
	            positionClass: 'toast-top-full-width',
	            progressBar: true,
	            timeOut: 1000,
	        };
	        toastr.error(
	            '<div style="color:white">모든 항목을 체크해 주세요</div>',
	            '<div style="color:white">경고</div>', {
	                timeOut: 3000,
	            }
	        );
		}
	})
}

function init(){
	getDay();
	theaterActive();
	timeActive();
	submit();
}

init();