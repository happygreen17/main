create table imgbbs(
id 		varchar(10) 	not null, --글 수정, 삭제 시 pw 체크와 함께 본인임을 검증하기 위해 필요
num		number(7)		not null, --한명이 여러개 올리면 id가 같아서 num이 필요하다
mname 	varchar(20) 	not null, --닉네임(이름)
title 	varchar(150) 	not null,
content varchar(2000) 	not null,
--pw 		varchar(50) 	not null,
wdate 	date 			not null, --작성일
fname 	varchar(50) 	default 'default.jpg',
viewcnt number(5)		default 0,
filesize number 		default 0,
primary key(num)
);

create table image(
ino 	number(10) 	not null, 
mname 	varchar(20) 	not null, 
title 	varchar(150) 	not null,
content varchar(2000) 	not null,
passwd 		varchar(50) 	not null,
wdate 	date 			not null, 
fname 	varchar(50) 	default 'default.jpg',
viewcnt number(5)		default 0,
filesize number 		default 0,
primary key(ino)
);

select * from image;

drop table image;

create sequence image_seq;

drop table imgbbs;

select * from imgbbs;

delete from IMGBBS;

select id, num, mname, title, content, to_char(wdate, 'yyyy-MM-dd') wdate, fname, viewcnt, filesize, r
from(
	select id, num, mname, title, content, to_char(wdate, 'yyyy-MM-dd') wdate, fname, viewcnt, filesize, rownum r
	from(
		select id, num, mname, title, content, to_char(wdate, 'yyyy-MM-dd') wdate, fname, viewcnt, filesize
		from imgbbs
		order by num desc
		)
)
where r >= ? and r <= ?