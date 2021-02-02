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



# 고려 사항

* 오직 영화 정보만을 가지고 예매를 진행 하는가?
* 반응형 웹
