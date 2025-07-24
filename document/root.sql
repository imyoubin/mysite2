/************************************
* root
*************************************/


-- web 계정만들기
create user 'web'@'%' identified by 'web';

-- web 권한주기
grant all privileges on web_db.* to 'web'@'%';

-- web_db 만들기
create database web_db
	default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption='n'
;

