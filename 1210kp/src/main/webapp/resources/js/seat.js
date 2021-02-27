let selectedSeatsArray = new Array();
let clicked = '';
let div = '';
let seat = document.querySelectorAll('.seat');
const seatWrapper = document.querySelector('.seat-wrapper');
const selectedSeats = document.querySelector('.selected-seats');
const remainSeats = document.querySelector('.remain-seats');
const allSeats = document.querySelector('.all-seats');
const selectSeatListNormal = document.querySelectorAll('.select-seat-ul-normal li');
const selectSeatListTeen = document.querySelectorAll('.select-seat-ul-teen li');
const selectSeatListOld = document.querySelectorAll('.select-seat-ul-old li');
const selectNumberNormal = document.querySelectorAll('.select-number-normal');
const selectNumberTeen = document.querySelectorAll('.select-number-teen');
const selectNumberOld = document.querySelectorAll('.select-number-old');
let selectSeatUlActive = '';
let allNumber = 0;
let allMoney = 0;
let normalNumber = 0;
let normalMoney = 0;
let teenNumber = 0;
let teenMoney = 0;
let oldNumber = 0;
let oldMoney = 0;
let alarm = false;

// 최대 예매수
const maxCnt = 4;

// 예약 관련
const title = document.querySelector('.title');
const selectedTheater = document.querySelector('.selectedTheater');
const reserveDate = document.querySelector('.reserveDate');
const runningTime = document.querySelector('.runningTime');
const selectedSeat = document.querySelector('.selectedSeat');
const payMoney = document.querySelector('.payMoney');
const ticketPrice = document.querySelector('.ticket-price');

toastr.options = {
    positionClass: 'toast-top-right',
    progressBar: true,
    timeOut: 1000,
	preventDuplicates: true,
};

// 일반, 청소년, 우대 수량버튼 클릭시 이벤트 발생
function selectSeatList(list){
	list.forEach(function(li){
		initList(list,li);
	});
}

function initList(list,li){
	li.addEventListener('click',function(){
		list.forEach(function(li){
			li.classList.remove('select-seat-ul-active');
		});
		li.classList.add('select-seat-ul-active');
		//selectSeatUlActive = document.querySelectorAll('.select-seat-ul-active');
		
		selectListUi(li);
	})
}

function selectListUi(li){
	if(li.parentNode.classList.contains('select-seat-ul-normal')){
		normalNumber = Number(li.innerHTML);
		normalMoney = 11000 * normalNumber;
		allMoney = normalMoney + teenMoney + oldMoney;
		allNumber = normalNumber + teenNumber + oldNumber;
		if(allNumber > maxCnt){
			li.classList.remove('select-seat-ul-active');
			allMoney -= normalMoney;
			allNumber -= normalNumber;
			selectNumberNormal[0].classList.add('select-seat-ul-active');
			alarm = true;
			normalNumber = normalMoney = 0;
		}
		ticketPrice.innerHTML = allMoney + '원';
	}
	else if(li.parentNode.classList.contains('select-seat-ul-teen')){
		teenNumber = Number(li.innerHTML);
		teenMoney = 8000 * teenNumber;
		allMoney = normalMoney + teenMoney + oldMoney;
		allNumber = normalNumber + teenNumber + oldNumber;
		if(allNumber > maxCnt){
			li.classList.remove('select-seat-ul-active');
			allMoney -= teenMoney;
			allNumber -= teenNumber;
			selectNumberTeen[0].classList.add('select-seat-ul-active');
			alarm = true;
			teenNumber = teenMoney = 0;
		}
		ticketPrice.innerHTML = allMoney + '원';
	}
	else if(li.parentNode.classList.contains('select-seat-ul-old')){
		oldNumber = Number(li.innerHTML);
		oldMoney = 8000 * oldNumber;
		allMoney = normalMoney + teenMoney + oldMoney;
		allNumber = normalNumber + teenNumber + oldNumber;
		if(allNumber > maxCnt){
			li.classList.remove('select-seat-ul-active');
			allMoney -= oldMoney;
			allNumber -= oldNumber;
			selectNumberOld[0].classList.add('select-seat-ul-active');
			alarm = true;
			oldNumber = oldMoney = 0;
		}
		ticketPrice.innerHTML = allMoney + '원';
	}
	
	if(alarm){
		alarm=false;
        toastr.error(
            '<div style="color:white">지정된 인원수를 넘었습니다(최대 4명)</div>',
            '<div style="color:white">인원수 확인</div>', {
                timeOut: 3000,
            }
        );
	}
	
	// 좌석 선택 초기화
	seat = document.querySelectorAll('.seat');
	seat.forEach(function(li){
		li.classList.remove('clicked');
	});
	selectedSeats.innerHTML = "선택된 좌석이 없습니다.";
	
	payMoney.value = allMoney;
}

// 화면에 좌석 그리기
function makingSeats(){
	for(var i=0;i<10;i++){
		div = document.createElement('div');
		div.className = 'seatButtonWrapper';
		seatWrapper.append(div);
		
		for(var j=0;j<12;j++){
			const input = document.createElement('input');
			input.type = "button";
			input.name = "seats";
			input.className = "seat";
			// 좌석이름 부여
			mapping(input,i,j);
			div.append(input);
			// 클릭시 이벤트
			inputClickEvent(input);
		}
		seat = document.querySelectorAll('.seat');
		remainSeats.innerHTML = seat.length;
		allSeats.innerHTML = seat.length;
	} 
}

function seatInterval(){
	seat.forEach(function(li){
		if(li.value.substring(1,li.value.length) === '2'){
			li.classList.add('left-margin');
		}
		else if(li.value.substring(1,li.value.length) === '9'){
			li.classList.add('right-margin');
		}
		
		if(li.value.substring(0,1) === 'E'){
			li.classList.add('top-margin');
		}
	})
}

function inputClickEvent(input){
	input.addEventListener('click',function(e){
		selectedSeatsArray = selectedSeatsArray.filter((element,index) => selectedSeatsArray.indexOf(element) != index);
		
		// click된 상태이면 제거
		if(input.classList.contains('clicked')){
			input.classList.remove('clicked');
			clicked = document.querySelectorAll('.clicked');
			
			// 배열 안의 선택된 좌석 제거
			selectedSeatsArray.splice(selectedSeatsArray.indexOf(e.target.value),1);
			clicked.forEach(function(data){
				selectedSeatsArray.push(data.value);
			});
		}
		else{
			input.classList.add('clicked');
			clicked = document.querySelectorAll('.clicked');
			// 선택한 번호의 갯수를 넘기면 동작 못하게
			if(clicked.length > allNumber){
				input.classList.remove('clicked');
				toastr.options = {
		            positionClass: 'toast-top-full-width',
		            progressBar: true,
		            timeOut: 1000,
		        };
		        toastr.error(
		            '<div style="color:white">지정된 인원수를 넘었습니다</div>',
		            '<div style="color:white">인원수 확인</div>', {
		                timeOut: 3000,
		            }
		        );
				return;
			}
			
			clicked.forEach(function(data){
				selectedSeatsArray.push(data.value);
			});
			selectedSeats.innerHTML = selectedSeatsArray;
			remainSeats.innerHTML = seat.length - selectedSeatsArray.length;
		}
	})
}

function mapping(input,i,j){
	if(i==0){
		input.value= "A"+j;
	}
	else if(i==1){
		input.value= "B"+j;
	}
	else if(i==2){
		input.value= "C"+j;
	}
	else if(i==3){
		input.value= "D"+j;
	}
	else if(i==4){
		input.value= "E"+j;
	}
	else if(i==5){
		input.value= "F"+j;
	}
	else if(i==6){
		input.value= "G"+j;
	}
	else if(i==7){
		input.value= "H"+j;
	}
	else if(i==8){
		input.value= "I"+j;
	}
	else if(i==9){
		input.value= "J"+j;
	}
	else if(i==10){
		input.value= "K"+j;
	}
}

function init(){
	selectSeatList(selectSeatListNormal);
	selectSeatList(selectSeatListTeen);
	selectSeatList(selectSeatListOld);
	makingSeats();
	seatInterval();
}

init();