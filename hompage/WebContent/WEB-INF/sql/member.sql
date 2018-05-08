
drop table member purge;

Create table member(	
id			varchar(10)  not null,
passwd		varchar(20)  not null,
mname 		varchar(20)  not null,
tel 		varchar(14)      null,
email 		varchar(50)  not null unique,
zipcode	 	varchar(7) 	     null,
address1 	varchar(150)     null,
address2	varchar(50)      null,
job 		varchar(20)  not null,
mdate 		date 		 not null, 				--가입일
fname 		varchar(50)  default 'member.jpg',  --회원사진
grade 		char(1) 	 default 'H',			--일반회원: H, 정지: Y, 손님: Z
primary key(id)
);

select * from member;


select id, passwd
from member
where id = '3333' 

--create
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mdate, fname, grade)
values('user1', '1234', '개발자1', '123-1234', 'email1@mail.com', '123-123', '인천시', '남동구', 'A01', sysdate, 'man.jpg', 'H');

insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mdate, fname, grade)
values('user2', '1234', '개발자2', '123-1234', 'email2@mail.com', '123-123', '광명시', '남동구', 'A01', sysdate, 'man.jpg', 'H');

insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mdate, fname, grade)
values('user3', '1234', '개발자3', '123-1234', 'email3@mail.com', '123-123', '용인시', '남동구', 'A01', sysdate, 'myface.jpg', 'H');


insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mdate, fname, grade)
values('admin', '1234', '개발자3', '123-1234', 'admin@mail.com', '123-123', '용인시', '남동구', 'A01', sysdate, 'member.jpg', 'A');

--중복 아니디 검사 관련
--0 : 중복아님
--1 : 중복
select count(id)
from member
where id = 'user1';

select count(id) as cnt
from member
where id = 'user1';

--이메일 중복 확인
select count(email)as cnt
from member
where email='email1@mail.com';

--read (user1 회원정보 보기)
select id, passwd, mname, tel, email, zipcode, address1, address2, job, mdate, fname, grade
from member
where id = 'user1';

--회원 이미지의 수정
update member
set fname=''
where id = 'user1';

--패스워드 변경
UPDATE member
SET passwd='1234'
WHERE id='';

--회원정보 수정
update member
set passwd='TEST', tel='123-123', email='email10', zipcode='TEST',
address1='수원', address2='팔달구', job='TEST'
WHERE id = 'user3';

--'user3'화원 삭제
delete from member where id = 'user3';

--로그인 관련 SQL
select count(id) as cnt
from member
where id = 'user1' and passwd = '1234';

--list
SELECT id, passwd, mname, tel, email, zipcode, address1, address2, job, mdate, fname, r
from(
	SELECT id, passwd, mname, tel, email, zipcode, address1, address2, job, mdate, fname, rownum r
	from(
		SELECT id, passwd, mname, tel, email, zipcode, address1, address2, job, mdate, fname
		FROM member  
		where mname like '%개발%'
		ORDER BY mdate DESC 
	)
)
where r >= 1 and r <= 5;












