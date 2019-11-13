-- 제약조건 2 
/* 이것도 주석이다 시작부터 끝까지 
*/ 
-- 이건 해당 줄만 주석이다 

/*지금 까지 해왔던 방식:
-- Method 1
create table tbl_name(
    col_name data_type constraint cost_name cost_content,
    add add...
    col_name data_type default 기본값
    );*/


    
/* 변수의 선언 (컬럼의 이름과 데이터 타입을 설정하는 것)과 constraint 를 따로 설정하는 것 
   Method 2 
create table tbl_name (
    col_name data_type, 
    col_name data_type 
    ..., 
    constraint 제약조건이름 제약조건내용1 (무슨 컬럼에 어떤 내용인지 명시) 
    constraint 제약조건이름 제약조건내용2
    ..., (*column 순서대로 안써도 된다) 
- 컬럼 선언 후에 제약 조건을 명시> */

-- 두번쨰 방법은 not null은 사용 불가 (오직 첫번째만 가능) 

/* In Method 2, there is no need to keep the order when writing constraints content, 
   therfore, we need to indicate which column corresponds to which prerequisite. 
   On the other hand in method 1, each line of constraints 
   refer to its line. There is no need for the user to indicate the column name*/

-- Making a table using the method 2

create table ex08(
    col1 number,
    col2 number, 
    constraint pk_ex08 primary key (col1),
    constraint uq_ex08 unique (col2)
);

drop table ex09;

create table ex09(
    col1 varchar2(10),
    constraint nn_ex09 not null(col1));
--Error: "%s: invalid identifier" : not null은 무조건 column 이름 옆에다 

-- 여기까지 했다 

-- foreign key command:constraint fk_ex_dept references ex_dept(deptno) 
 
create table ex_emp2(
    empno number constraint pk_ex_emp2 primary key, 
    ename varchar2(20), 
    deptno number(2),
    constraint fk_ex_dept2 foreign key (deptno) references ex_dept(deptno)
    );


create table ex_emp2(
    empno number constraint pk_ex_emp2 primary key, 
    ename varchar2(20),
    deptno number(2), 
    constraint fk_ex_dept2 foreign key (deptno) references ex_dept(deptno)
    );

create table ex_emp2(
    empno number constraint pk_ex_emp2 primary key, 
    ename varchar2(20), 
    deptno number(2), 
    constraint fk_ex_dept2 foreign key (deptno) references ex_dept(deptno)
);

-- deptno: column name 
/*  constraint fk_ex_dept2 foreign key (deptno) references ex_dept(deptno) 이거는 2nd method 일 때 쓰는 방법*/

 
--하나의 테이블에서 두개 이상의 컬럼을 묶어서 하나의 PK지정 
create table ex09( 
    col1 number primary key, 
    col2 varchar2(20) primary key 
);

create table ex09(
    col1 number primary key, 
    col2 varchar2(20) primary key 
);
--Error: "table can have only one primary key"/ 테이블은 오직 한개의 PK를 가질 수 있기 때문에 오류발생 

create table ex09(
    col1 number,
    col2 varchar2(20),
    constraint pk_ex09 primary key (col1,col2)   
);
-- 이럴 땐 두개를 묶에서 unique 해지면 된다 

insert into ex09 values (1,'a');
insert into ex09 values (1,'b');
-- 두번째 행도 insert된다, 왜냐하면 1a와 1b는 다르니까 
insert into ex09 values (2,'a');
-- pair로 묶인 것들이 PK 역할을 한다 

select * from ex09;

-- insert가 안되는 경우는 두 값이 모두 똑같은 때 
insert into ex09 values (1,'a');

insert into ex09 values (100,null);
insert into ex09 values (100, null);
-- ERROR: ORA-01400: NULL을 ("SCOTT"."EX09"."COL2") 안에 삽입할 수 없습니다. PK는 null을 가질 수 없다 

select * from ex09;

-- INSERT SELECT CLAUSE 
--  다른 곳에서 셀렉한 녀석들을 우리 테이블에 넣는것,,,? 
-- 여러게 행을 추가하는 방법 
-- 다른 테이블에서 select 한 내용을 테이블에 insert하는 방법 

-- 여기까지 봤다: 밑에서 바른 예 보고 다시 올라오기 
 
insert into ex_emp2 (empno,ename,deptno) 
select * from emp; 
-- 이렇게하면 안된다 (컬럼 갯수가 안 맞으니까) 

insert into ex_dept values (30,'인사부'); 

insert into ex_emp2(empno,ename,deptno) 
select empno, ename, deptno from emp; 
-- ERROR: 무결성 제약조건(SCOTT.FK_EX_DEPT2)이 위배되었습니다- 부모 키가 없습니다 
-- insert into ex_dept values (30,'인사부');  add prior to the command 

select * from ex_emp2;


-- Oracle method 
select e.empno, e.ename, e.deptno, d.dname
from ex_emp2 e, ex_dept d 
where e.deptno = d.deptno;    

select e.empno, e.ename, e.deptno, d.dname
from ex_emp2 e join ex_dept d 
on e.deptno = d.deptno;
    
-- 테이블 복사: 테이블을 생성할 때 다른 테이블의 구조와 데이터를 그대로 가져오는 방법 
-- 비어있는 테이블 먼저 생성 
-- create ~ as select 구문 
create table ex_emp3 
as select * from emp;

select * from ex_emp3;
-- 테이블 있는거 그대로 복사 

create table ex_emp4 
as select * from emp where deptno=10;
select * from ex_emp4;

create table ex_emp5 
as select * from emp where 1 != 1;
select * from ex_emp5;
--1 != 1 : 1와 1은 다르다/ 다 틀려머거쓰,,, 

/*다른 외부 데이트 (i.e. 엑셀파일) 을 디벨로퍼로 가지고 오고 싶다면, 
메뉴>테이블(필터링됨) > 오른쪽 클릭 > 데이터 임포트 (파일 위치 > 형식) > 미리보기 / 임포트 방식 > 삽입 / 임포트 행 제한 등 설정,,
doc>docx/ xls>xlsx/ ppt>pptx (xml file format)  
*/ 

/* UPDATE table 
*/
    
    
    
    