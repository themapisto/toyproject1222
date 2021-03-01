# toyproject1222
12월22일 깃허브 연동

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
