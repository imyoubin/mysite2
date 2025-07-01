/*******************************************
 web 계정에서 사용 - board
*******************************************/

-- web_db 사용
use web_db;


-- 테이블 목록 조회
show tables;

-- 테이블 삭제
drop table board;

-- board(게시판)테이블 생성
create table board(
	no 			int 			primary key		auto_increment,
    user_no		int,
    title 		varchar(500) 	not null,
    content 	text,
    hit 		int,
    reg_date 	datetime 		not null,
    constraint board_fk foreign key(user_no)
    references users(no)
)
;


-- 게시물 등록
insert into board
values(null, 1, '첫번째 게시물제목', '첫번째 게시물내용', 0, now())
;

insert into board
values(null, 2, '두번째 게시물제목', '두번째 게시물내용', 0, now())
;


-- 전체리스트
select 	b.no,
		b.title,
        b.content,
        b.hit,
        date_format(b.reg_date, "%Y-%m-%d") regDate,
        u.no userNo,
        u.name userName
from users u, board b
where u.no = b.user_no
;


-- 전체조회
select *
from board
;
