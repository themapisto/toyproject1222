# toyproject1222
12월22일 깃허브 연동

<<<<<<< HEAD
# db table

* CREATE TABLE `user` (
   `userId` VARCHAR(60) NOT NULL COMMENT '회원ID' COLLATE 'utf8_general_ci',
   `userNm` VARCHAR(40) NOT NULL COMMENT '회원이름' COLLATE 'utf8_general_ci',
   `password` VARCHAR(64) NOT NULL COMMENT '비밀번호' COLLATE 'utf8_general_ci',
   `birthday` DATETIME NOT NULL COMMENT '생년월일',
   `phoneNumber` VARCHAR(20) NOT NULL COMMENT '전화번호' COLLATE 'utf8_general_ci',
   `email` VARCHAR(45) NOT NULL COMMENT '이메일' COLLATE 'utf8_general_ci',
   `regDt` DATETIME NOT NULL COMMENT '등록일자',
   `grade` VARCHAR(20) NOT NULL COMMENT '회원등급(1:일반회원 2:관리자)' COLLATE 'utf8_general_ci',
   `userState` VARCHAR(1) NOT NULL COMMENT '회원상태(1: 가입 8:잠김 9:탈퇴)' COLLATE 'utf8_general_ci',
   `salt` VARCHAR(64) NOT NULL COMMENT '암호화변수' COLLATE 'ucs2_general_ci',
   `loginFailCount` INT(1) UNSIGNED ZEROFILL NOT NULL COMMENT '로그인실패횟수',
   `loginFailTime` DATETIME NULL DEFAULT NULL COMMENT '계정잠금시작시간',
   PRIMARY KEY (`userId`) USING BTREE
)
COMMENT='회원'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

* CREATE TABLE coupon (
	id BIGINT NOT NULL auto_increment,
	coupon_name VARCHAR(10) NOT null,
	discount BIGINT NOT NULL,
	PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

* INSERT INTO coupon(coupon_name,discount) VALUES ("QWERTYUI", 50);

# information

* localhost:8080 으로 들어가면 상단에 로그인, 회원가입 버튼 존재합니다. 위쪽의 db table에서 `user` 테이블 생성하시고 회원가입 진행하시면 됩니다.
mariaDB - port : 13306 , (root/1111) 입니다.

* localhost:8080/reserve로 들어가면 예매 진행할 수 있습니다.
좌석 선택 페이지로 들어가시면 `관람 할인` 버튼 누르실 때 위쪽의 db table에서 `coupon` 테이블 생성하시고 진행하시면 됩니다. dml도 추가해두었습니다.
* server.xml 맨 아래부분에서 <Context> 에서 path="/" 로 해주셔야 합니다.
=======
# db 설계

* product - (id, name, description, rating, create_date, modify_date)
* product_price - (id, product_id, price_type_name, price, discount_rate, create_date, modify_date)
* product_image - (id, product_id, file_info_id)

* file_info - (id, file_name, save_file_name, content_type, delete_flag, create_date, modify_date)


* movie_info - (id, product_id, place_name, theater, tel, homepage, day, start_time, end_time, create_date, modify_date)

* reservation_info - (id, product_id, movie_info_id, reservation_name, reservation_tel, reservation_date, cancel_flag, create_date, modify_date)
* reservation_info_price - (id, reservtion_info_id, product_price_id, count)



# 작업 진행 상황

// 2월 2주차
* 빠른 예매 화면 (cgv) css 작업.
  - header와 body부분 일부 작업 완료.
  - 날짜 추가(javascript)
  - 상단에 app facebook, instragram 로고와 링크
* api이용하여 영화 목록 가져오기 (ajax통신)
  - json이 아닌 xml로 가져와서 parsing함.
  - 영화 목록 가져올 때 영화 코드로 ajax 통신 한번 더해서 관람 등급 가져와서 로그 띄우기. (javascript - promise)
  -> 서버단에서 api 통신 끝내고 map에 담아 return 하는 코드로 변경
* 영화, 극장, 날짜 ,시간 버튼 클릭시 활성화
* 모든 항목을 선택하지 않고 클릭시 경고창 발생
* 예약하기 누른 후 최종 확인 팝업 창으로 

// 2월 3주차
* api이용하여 영화 목록 가져오면 로딩 오래 걸려서 웹 크롤링으로 
* 좌석 선택 front-end screen부분 빼고 완성.

// 2월 4주차
* seat.js 완성
  - 쿠폰 할인 적용 
* screen 좌석 부분 완성
  - 인원 새로 선택시 기존 선택 좌석 초기화
  - 최대 인원수 4로 조정
* 기존 reserve.jsp에서 날짜 선택시 7일 간격으로 선택할 수 있게 바꿈.
* merge 완료
>>>>>>> branch 'changrok' of https://github.com/themapisto/toyproject1222.git
