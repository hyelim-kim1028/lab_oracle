-- HOW TO MAKE A TABLE 
-- there are already existing tables in Scott's account 
-- what are the column variances are about 

drop table ex1;

-- Table making 
create table ex1( 
    ex_id  number,
    ex_text  varchar2(10),
    ex_date  date
);

-- 후에 오른쪽 눌러서 새로고침해주기 

-- 테이블 구조 (컬럼 이름, 데이터 타입, null여부) 확인 
desc ex1;

-- 테이블에 데이터(레코드) 저장(삽입) / insert 구문 사용 / 행삽입 
insert into ex1()
values ();
-- insert into table name (the column name) 
-- values(the value for the row)

insert into ex1 (ex_id, ex_text, ex_date) 
values (1,'안녕하세요',sysdate);
-- insert caluse does not have much transformations 

-- 테이블에 저장된 데이터(레코드)를 검색 
select * from ex1; 


-- 변경된 데이터 영구저장 
commit;

insert into ex1 (ex_id, ex_text, ex_date)
values (2,'메롱메롱',null);

-- DDL (Data Definition Language) / 데이터 정의 언어 
-- Create, alter, drop, truncate 등 
-- DDL 명령은 실행 순간 자동으로 commit이 됨 
-- DML (Data Manipulation Language)/ 데이터 조작 언어
-- insert, update (abc > abcd),delete (테이블 자체는 아니고 행을 없애는 것)  
-- DML 은 자동으로 commit이 이루어지지 않는다 (commit;) 그러므로, DB에 접속한 사용자가 commmit명령을 수행해야만 DBMS에 영구적으로 반영됨 

-- insert basic structure 
insert into ex1 (ex_id, ex_text)
values (2,'메롱메롱');
select * from ex1;

insert into ex1 (ex_text, ex_id)
values ('텍스트', 10);
-- 내가 쓴 순서에 상관없이 잘 들어간다 
select * from ex1;

-- table의 모든 컬럼에 값을 저장 할 때 (모든 컬럼에 데이터를 집어 넣고 싶다면, 생략해도 된다.) 
-- insert into 구문에서 컬럼 이름을 생략할 수 있다
-- 단, values는 테이블의 컬럼 순서에 일치시켜서 모든 값을 전달해야 함! 
insert into ex1 
values (11,'data',sysdate);
select * from ex1;
-- 이 때는 순서가 매우 중요하다 (테이블이 만들어질 당시의 컬럼 순서를 따른다) 

-- SOME ERRORS WE CAN FACE 
insert into ex1 values (20);
-- ERROR!  "not enough values" : Since there is no column indicated after the table name, so Oracle expects the user to 
-- insert three variables (as indicated by the original). But here, we have inserted only one (even though right position), so 
-- there is an error 

insert into ex1 values (sysdate,'test',0);
-- ERROR! "inconsistent datatypes: expected %s got %s"/  NUMBER이(가) 필요하지만 DATE임 
-- So if we do not indicate the column name after the table name, we have to strictly follow the order 

-- ERROR메시지를 읽을 때 마다 받아드리는 연습을 해야한다. 무엇이 틀렸는지, 무엇을 프로그램이 말하는지,,, 그리고 고치는 연습! 
-- DEVELOPE THE PROGRAMMER'S MIND 

insert into ex1 (ex_text) 
values ('재미있나요?');
-- ERROR! ORA-12899: "SCOTT"."EX1"."EX_TEXT" 열에 대한 값이 너무 큼(실제: 11, 최대값: 10) 
-- not a grammatical error, however, we have exceeded our limit (10 byte) 
-- varchar2(10)에 저장할 수 있는 문자열 길이를 초과 


select * from ex1;

commit;
-- commit 1) write the command (commit;) 2) click the botton on the upper middle with DB + green check sign 3) F11 

-- 두번째 테이블 (컬럼 2개짜리) : EX2 
create table ex2( 
    ex_id number(2),
    ex_text varchar2(5 char)
);

desc ex2;

-- number 2 : 소숫점이 없는 숫자 1~99 까지 
-- varchar2: 5 char : byte 로 저장했더니 한글엔 제약이 더 많음 > 그래서 글자수로 설정 

-- number 2: 소숫점이 없는 숫자 1~99 까지 
-- varchar2: 5 char: byte 로 저장했더니 한글엔 제약이 더 많음 그래서 글자수로 설정 

insert into ex2 
values (1,'안녕하세요');
select * from ex2;

insert into ex2 
values (1,'안녕하세요');

commit; 

--ERRORs
insert into ex2(ex_id) values (100);
-- ERROR! 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
--- not grammatically wrong, hoever, the number is only allowed upto two digits. 100 is a three digit number 



insert into ex2(ex_text) values ('abcde');
insert into ex2(ex_text) values ('abcdef');
-- ERROR: 열에 대한 값이 너무 큼(실제: 6, 최대값: 5) 
-- 문자의 갯수 exceeds what is conditioned 
-- In Korean, CHinese & Japanese > using character number is better than byte setting (but English is better for byte) 

-- insert select /ple 를 사용해서 다른 테이블을 가져오거나, 인서트를 여러번 실행할 수 있다 
-- 행은 우리가 조절 할 수 없다,, 엑셀처럼 생각하면 앙대여,,, (시스템에서 정보의 관계를 맺어서 해야하기 때문에) 
-- 반드시 밑으로 들어가는건 아니다 



