# toyproject1222
12월22일 깃허브 연동

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

// 2월 2주차
* api이용하여 영화 목록 가져오면 로딩 오래 걸려서 웹 크롤링으로 
