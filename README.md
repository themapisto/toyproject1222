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
