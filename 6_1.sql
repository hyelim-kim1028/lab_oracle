-- 제약조건 (constraint) 

-- 접속한 사용자 계정의 테이블들에 적용된 제약조건 확인 
select constraint_name, constraint_type, table_name
from user_constraints;

select table_name from user_tables;

-- 제약조건의 종류들 
-- not null : 반드시 값이 있어야하는 column 
-- unique: 저장되는 값들이 중복되어서는 안된다 (no repeated value) 
-- Primary Key (PK)/고유키/P:  테이블에서 유일한 한개의 행(레코드)를 검색할 수 있는 컬럼 
-- Foreign Key (FK)/ 외래키,외부키 / R:관계를 맺고 있는 다른 테이블의 PK 
-- not null, unique > constraint type (C = check?) 
-- check: 조건(condition)을 체크하는 제약조건 
--i.e. If we mae a column titled 'age' which cannot have a minus number (negative number) 
-- so we put a condition like age >= 0
-- default: column의 기본값 (insert하지 않아도 자동으로 저장되는 값) 을 설정 (i.e. 시간에 null, age에 0 등) 
-- In constraint type, U stands for unique (it does not appear in desc command) 

create table ex03(
      col1 number unique, 
      col2 varchar2(20) not null 
);

desc ex03;

select * from ex03;
-- 제약조건 확인 SYS_C0011054	U	EX03/ SYS: system이 자동으로 만들었다 (automatically made by the system) 

insert into ex03 (col1,col2)
values (1,'aaa');

insert into ex03 (col1,col2) 
values (1,'bbb');
-- ERROR: ORA-00001: 무결성 제약 조건(SCOTT.SYS_C0011054)에 위배됩니다 
-- because in col1, the condition in unique, it has to be a unique number, but we repeated the col1 > 1 
-- 위 (values (1,'aaa'))에도 안된다 (1은 들어갔기때문에 또 들어갈 수 없다) 

insert into ex03 (col2)
values ('bbb');
-- no hay problema/ un exito con el insert 
-- aunque repite, no hay problema (function sin problema) 

insert into ex03 (col2)
values ('bbb');

select * from ex03;

insert into ex03(col1) 
values (10);
-- ERROR: ORA-01400: NULL을 ("SCOTT"."EX03"."COL2") 안에 삽입할 수 없습니다
-- col2 에는 not null 이므로, null을 넣을 수 없다 

commit;

-- 테이블 생성 시 제약 조건에 이름을 주는 방법 
create table ex04(
    col1 number constraint ex04_unq unique, 
    col2 varchar2 (20) constraint ex04_nn not null
);

-- 요기 
create table ex04(
    col1 number constraint ex04_unq unique, 
    col2 varchar2 (20) constraint ex04_nn not null
);
-- 제약조건의 이름을 줄 때: constraint (제약조건이름:ex04_unq) (제약조건 종류)
--,는 컴럼과 컬럼을 구별할 때에만 쓰고, 마지막 컬럼은 그게 끝 이기 때문에 쓰지 않는다 

-- 고유키 지정해서 테이블 만들어보기 
create table ex05(
 col1 number constraint ex05_pk primary key,
 col2 varchar2(10) 
); 
 
 drop table ex05a;
 
 create table ex05(
    col1 number constraint ex05_pk primary key, 
    col2 varchar2(10) 
 );
 

create table ex05a(
 col1 number constraint ex05_pk primary key,
 col2 varchar2(10) 
); 

create table ex05a(
        col1 number constraint ex05a_pk primary key, 
        col2 varchar2(10)
);

desc ex05a;
-- col1 은 PK가 아니라 not null이라고만 되어있다 
-- desc에서는 unique 는 안보여주고 null까지만 보인다 (nullable?) 

insert into ex05a 
values (1,'abc');
-- insert 성공 후 두번째 실행시켰더니 안된다 (무결성 제약 조건(SCOTT.EX05_PK)에 위배됩니다)
-- PK라는 constraint 때문에 

select * from ex05a;
 
insert into ex05a (col2)
 values('def');
 -- NULL을 ("SCOTT"."EX05A"."COL1") 안에 삽입할 수 없습니다 (PK는 not null + unique) 
 -- col1을 비워둘 수 없다 
 
 -- 조건: 제약 조건은 삽입되는 문자열의 길이가 8이상 > 이런걸 할 때 체크를 사용 (필수문자, 문자길이, 숫자포함 등의 조건을 내걸때) 
create table ex06(
 col varchar2(20) constraint ck_ex06 check(length(col) >=8)
 );

drop table ex06;

create table ex06(
        col varchar2(20) constraint ck_ex06 check(length(col) >= 8)
);

desc ex06;
-- only shows nullable or not, but it does not say anything about check 

create table ex06a(
 col varchar2(20) constraint ck_ex06 check(length(col) >=8)
 );

create table ex06a(
    col varchar2(20) constraint ck_ex06a check (length(col) >= 8)
);
 
 insert into ex06 values ('abcdefg');
 --ERROR: 체크 제약조건(SCOTT.CK_EX06)이 위배되었습니다 (less than 8 letters) 
 insert into ex06 values ('abdkejslfj');

-- PK는 두개의 column으로 지정할 수 없다. (안되서 컬럼 2개를 엮지 않는 이상 테이블 하나 당 하나의 PK) 

-- Default값을 갖는 컬럼 
drop table ex07;

create table ex07(
    ex_id number default 0,
    ex_date date default sysdate 
);

create table ex07(
       ex_id number default 0, 
       ex_date date default sysdate
);

create table ex07(
    ex_id number default 0, 
    ex_date date default sysdate
);
    
desc ex07;
-- 제약조건으로 관리하지는 않지만, but it is still indicated 

insert into ex07
values (1,to_date ('2019-09-13','yyyy-mm-dd'));

select * from ex07;
-- (날짜가 현재시간이 아닌경우) 날짜를 할때에는 to_date을 사용하여 문자열해주고 입력 

insert into ex07(ex_id) 
values (100);

insert into ex07(ex_id) 
values(100);

select * from ex07;
-- 시간이 default 로 현재시간 들어갔당 

insert into ex07 (ex_date) 
values (sysdate +1);

select * from ex07;

commit;

--foreign key 만들기 

drop table ex_dept;

create table ex_dept(
    deptno number(2) constraint pk_ex_dept primary key , 
    dname varchar2(20) 
);

create table ex_dept(
    deptno number(2) constraint pk_ex_dept primary key, 
    dname varchar2(20)
);

drop table ex_emp;

create table ex_emp( 
    empno number(4) constraint pk_ex_emp primary key,
    ename varchar2(20),
    deptno number(2) constraint fk_ex_dept references ex_dept(deptno)
); 

-- foreign key 주기: constraint (alias) references original_table_name(original_column_name)
-- ex_dept 테이블에 데이터가 없는 경우 (부서 번호가 1개도 없는 경우) 
insert into ex_emp 
values (1001,'오쌤',10);

insert into ex_emp 
values(1001,'오쌤',10);

--ERROR: 무결성 제약조건(SCOTT.FK_EX_DEPT)이 위배되었습니다- 부모 키가 없습니다 
-- foreign key의 deptno 가 없어서 
-- emp는 꼭 dept 를 참조해야하는데 (부모키) - 없음 (띠용,,) 
-- ex_emp에는 ex_dept 테이블에 생성되어 있지 않은 부서 번호는 insert할 수 없다! 
--FK가 설정된 ex_emp테이블의 deptno컬럼에는 null은 가능 
insert into ex_emp(empno, ename) 
values (1001,'오쌤');
-- Fk는 null이냐 아니야를 체크하는게 아니라, 오리지널 테이블에 있느냐 없느냐를 확인 

insert into ex_emp (empno, ename) 
values(1001,'오쌤');


insert into ex_dept values (10,'개발팀');
insert into ex_dept values (20,'분석팀');


insert into ex_emp 
values (2001,'홍길동',10);

insert into ex_emp 
values (2001, '홍길동',10);

insert into ex_emp 
values (3001,'scott',20);

insert into ex_emp 
values (3001, 'scott', 20);


select * from ex_emp;

-- foreign key 부분은 referred table에 데이터가 있어야 insert 가능이고, 
-- 아니면 실패임 아니면 널이거나 
-- table을 만들 때는 foreign key는 넣지 않고, 나중에 추가해준다 (alter 사용) 

select * from ex_emp;
select * from ex_dept;

commit;

-- check 는 조건을 매우 다양하게 쓸 수 있다 (where 조건절에 썼던 것 처럼) 

