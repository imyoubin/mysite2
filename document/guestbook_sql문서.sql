/*******************************************
 web 계정에서 사용 - guestbook
*******************************************/

-- web_db 사용
use web_db;

-- 테이블 목록 조회
show tables;

-- 테이블 삭제
drop table guestbook;

-- 유저(회원)테이블 생성
create table guestbook(
	no 			int 		  primary key 	auto_increment,
    name 		varchar(80),
    password 	varchar(20),
    content 	text,
    reg_date	datetime
);

-- 리스트
select 	no,
		name,
		password,
        content,
        reg_date as regDate
from guestbook
order by reg_date desc
;

-- 저장
insert into guestbook
values(null, '서장훈', '123', '다녀갑니다', now())
;

-- 삭제
delete from guestbook
where no = 1
and password ='123'
;







