drop table bbs;

create table bbs(
id 			varchar(10) 	not null, --글 수정, 삭제 시 pw 체크와 함께 본인임을 검증하기 위해 필요
bbsno 		number(7) 		not null,
wname 		varchar(20) 	not null,
title 		varchar(150) 	not null,
content 	varchar(4000)	not null,
--passwd 	varchar(50) 	not null,     --패스워드는 member꺼랑 비교해라... id만 비교하면 될듯?..비교 안해도 됨
viewcnt 	number(5)	 	default 0,
wdate 		date 			not null,
grpno 		number(7)		default 0,
indent 		number(2)		default 0,
ansnum 		number(5)		default 0,
filename 	varchar(50) 	default 'default.jpg',
filesize 	number 			default 0,
refnum 		number 			default 0,
primary key(bbsno)
);

--답글있는 게시글 삭제 못하게 하는 컬럼
alter table bbs
add(refnum number default 0);  


SELECT mname
FROM member 
WHERE id = 'user1'

insert into bbs(id, bbsno, wname, title, content, wdate, grpno)
values('user3', (select nvl(max(bbsno), 0) + 1 as bbsno from bbs),
'개발자3', '제목입니다', '내용무엇?', sysdate, 
(select nvl(max(grpno),0)+1 from bbs)
);
insert into bbs(id, bbsno, wname, title, content, wdate, grpno)
values('user2', (select nvl(max(bbsno), 0) + 1 as bbsno from bbs),
'개발자2', '제목입니다', '내용무엇?', sysdate, 
(select nvl(max(grpno),0)+1 from bbs)
);
insert into bbs(id, bbsno, wname, title, content, wdate, grpno)
values('user1', (select nvl(max(bbsno), 0) + 1 as bbsno from bbs),
'개발자1', '제목입니다', '내용무엇?', sysdate, 
(select nvl(max(grpno),0)+1 from bbs)
);

alter table bbs
add(filename varchar(30),
	filesize number default 0);


--레코드갯수
select count(*) from bbs

select count(*) from bbs
where wname like '%김%';


--일련번호
select max(bbsno) as max from bbs; --null 출력됨
select max(bbsno + 1) as max from bbs; --역시 null 임.
select nvl(max(bbsno), 0) + 1 as bbsno from bbs;

--read
select * from bbs
where bbsno=1;

--update
update bbs
set wname='왕눈이', title='비오는날', content='개구리 연못'
where bbsno = 1;

--delete
delete from BBS
where bbsno=1;

--list
select * from bbs
order by bbsno desc; 


--조회수 증가
update bbs
set viewcnt = viewcnt + 1
where bbsno=2;

--pw검증
select count(bbsno) as cnt  --where를 충족하는 레코드 갯수 1은 참, 0은 조건문 충족하지 않는 것임
from bbs
where bbsno=2 and passwd='456';



DELETE FROM bbs;

 BBSNO  TITLE    GRPNO INDENT ANSNUM 
 -----   -----    ----- ------ ------ 
     1  부모글1     1      0      0 
     
     --GRPNO  : 번호)같은 그룹이면 같은 grpno를 갖는다. 3번글의 grpno이 1이라고 했을 때 답글들도 1값을 가짐(단, bbsno는 primary키이므로 중복불가, GRPNO와 관련없음)
     --INDENT : 깊이)일반글인지 답변글인지를 구분하기 위해 들여쓰기를 해주기 위한 값 = 답변의 깊이(일반글은 0, 답변은 1, 답변의 답변일 경우에는 +1)
     --ANSNUM : 순서)부모는 다 0, 순서를 정하기 위해서 1,2,3으로 정해준다. (부모보다 1커야함)(최신글이 위에) 나머지를 +1 해준다
      
 BBSNO  TITLE    	GRPNO INDENT ANSNUM 
 -----  -----    	----- ------ ------ 
     
     2  부모글2      		2      0      0 
     1  부모글1      		1      0      0 
     4   부모글1의답2      1      1      1
     5    부모글1의답1     1      2      2
     3   부모글1의답1 		1      1      3 
 
      
 BBSNO  TITLE          	  GRPNO INDENT ANSNUM 
 -----  -----            ----- ------ ------ 
     4  부모글4           4      0      0   
     9	 부모글4의 답변2  	4	    1	   1
     6	 부모글4의 답변1  	4		1	   2
     3  부모글3          	3       0      0      
     2  부모글2         	2       0      0 
     8	 부모글2의 답변3  	2       1	   1
     10   부모글2의 답변3의답2       2	   2
     11    부모글2갑3의답3  2       3      3
     7   부모글2의 답변2  	2		1	   4
     5   부모글2의 답변1  	2		1      5
     1  부모글1          	1       0      0 
     
--부모글 생성     
insert into bbs(bbsno, wname, title, content, passwd, wdate, grpno)
values((select nvl(max(bbsno), 0) + 1 as bbsno from bbs),
'투투', '니나니뇨', '내용무엇?', '789', sysdate,
(select nvl(max(grpno),0)+1 from bbs)
);

insert into bbs(bbsno, wname, title, content, passwd, wdate, grpno)
values((select nvl(max(bbsno), 0) + 1 as bbsno from bbs),
'아로미', '니나니뇨2', '내용무엇?', '123', sysdate,
(select nvl(max(grpno),0)+1 from bbs)
);

insert into bbs(bbsno, wname, title, content, passwd, wdate, grpno)
values((select nvl(max(bbsno), 0) + 1 as bbsno from bbs),
'왕눈이', '니나니뇨3', '내용무엇?', '4444', sysdate,
(select nvl(max(grpno),0)+1 from bbs)
);
    

SELECT bbsno, title, grpno, indent, ansnum 
FROM bbs  
ORDER BY grpno DESC, ansnum ASC; 

--페이징 적용
SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, r
from(
	SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, rownum r
	from(
		SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum 
		FROM bbs  
		--검색(if문)
		ORDER BY grpno DESC, ansnum ASC 
	)
)
where r >= 1 and r <= 5