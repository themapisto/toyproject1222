drop table if exists reservation_info_price;
drop table if exists reservation_info;
drop table if exists product_price;
drop table if exists product_image;
drop table if exists movie_info;
drop table if exists product;
drop table if exists file_info;

-- -----------------------------------------------------
-- Table `fileinfo`
-- -----------------------------------------------------
CREATE TABLE `file_info` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '파일id',
  `file_name` VARCHAR(255) NOT NULL COMMENT '원본 파일명',
  `save_file_name` VARCHAR(4000) NOT NULL COMMENT '저장된 파일 경로',
  `content_type` VARCHAR(255) NOT NULL COMMENT '파일 type',
  `delete_flag` INT(1) NOT NULL COMMENT '삭제유무 삭제:1, 삭제안됨 : 0',
  `create_date` DATETIME NULL DEFAULT NULL COMMENT '등록일',
  `modify_date` DATETIME NULL DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
CREATE TABLE `product` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '영화id',
  `name` VARCHAR(100) NOT NULL COMMENT '영화이름',
  `description` VARCHAR(100) NULL DEFAULT NULL COMMENT '영화 간단 설명',
  `rating` VARCHAR(100) NULL DEFAULT NULL COMMENT '영화등급',
  `create_date` DATETIME NULL DEFAULT NULL COMMENT '생성시간',
  `modify_date` DATETIME NULL DEFAULT NULL COMMENT '수정시간',
  PRIMARY KEY (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;



-- -----------------------------------------------------
-- Table `product_price`
-- -----------------------------------------------------
CREATE TABLE `product_price` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '영화 가격 id',
  `product_id` INT(11) NOT NULL COMMENT '영화 id',
  `price_type_name` VARCHAR(25) NOT NULL COMMENT '성인(A), 청소년(Y), 유아(B), 셋트(S), 장애인(D), 지역주민(C), 조조(E) , 심야(N), VIP(V)',
  `price` INT(11) NOT NULL COMMENT '영화 가격',
  `discount_rate` DECIMAL(5,2) NOT NULL COMMENT '할인율',
  `create_date` DATETIME NULL DEFAULT NULL COMMENT '등록일',
  `modify_date` DATETIME NULL DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`product_id`)
  REFERENCES `product` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;



-- -----------------------------------------------------
-- Table `product_image`
-- -----------------------------------------------------
CREATE TABLE `product_image` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '영화 이미지 id',
  `product_id` INT(11) NOT NULL COMMENT '영화 id',
  `file_id` INT(11) NOT NULL COMMENT 'file id',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  FOREIGN KEY (`file_id`) REFERENCES `file_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
  
  
  
  -- -----------------------------------------------------
-- Table `display_info`
-- -----------------------------------------------------
CREATE TABLE `movie_info` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '영화정보id',
  `product_id` INT(11) NOT NULL COMMENT '영화 id',
  `place_name` VARCHAR(50) NOT NULL COMMENT '장소명 ex>강남,군자',
  `theater` VARCHAR(100) NOT NULL COMMENT '극장이름',
  `tel` VARCHAR(20) NULL DEFAULT NULL COMMENT '문의전화번호',
  `homepage` VARCHAR(255) NULL DEFAULT NULL COMMENT '홈페이지',
  `day` DATETIME NOT NULL COMMENT '영화상영날짜',
  `start_time` VARCHAR(50) NOT NULL COMMENT '영화시작시간',
  `end_time` VARCHAR(50) NOT NULL COMMENT '영화종료시간',
  `create_date` DATETIME NULL DEFAULT NULL COMMENT '생성시간',
  `modify_date` DATETIME NULL DEFAULT NULL COMMENT '수정시간',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`product_id`)
  REFERENCES `product` (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;



-- -----------------------------------------------------
-- Table `reservation_info`
-- -----------------------------------------------------
CREATE TABLE `reservation_info` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '예매정보 id',
  `product_id` INT(11) NOT NULL COMMENT '영화 id',
  `movie_info_id` INT(11) NOT NULL COMMENT '영화정보 id',
  `reservation_name` VARCHAR(50) NOT NULL COMMENT '예매자 이름',
  `reservation_tel` VARCHAR(50) NOT NULL COMMENT '예매자 번호',
  `reservation_date` DATETIME NOT NULL COMMENT '예매일',
  `cancel_flag` INT(1) NOT NULL DEFAULT '0' COMMENT '취소 : 1, 예약 : 0',
  `create_date` DATETIME DEFAULT NULL COMMENT '등록일',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  FOREIGN KEY (`movie_info_id`) REFERENCES `movie_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;



-- -----------------------------------------------------
-- Table `reservation_info_price`
-- -----------------------------------------------------
CREATE TABLE `reservation_info_price` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '예매 가격 id',
  `reservation_info_id` INT(11) NOT NULL COMMENT '예매 정보 id',
  `product_price_id` INT(11) NOT NULL COMMENT '영화 가격 id',
  `count` INT(11) NOT NULL COMMENT '예매수',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`reservation_info_id`)
  REFERENCES `reservation_info` (`id`),
  FOREIGN KEY (`product_price_id`)
  REFERENCES `product_price` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;