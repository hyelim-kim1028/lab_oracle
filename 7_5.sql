/*sql_ex_08txt.txt
1. emp 테이블과 똑같은 구조(컬럼이름, 데이터 타입)을 갖는 테이블을 hw_emp라는 이름으로 생성

2. hw_emp 테이블에 새로운 컬럼을 추가
   컬럼 이름: etc
   데이터 타입: 최대 20 bytes 가변 길이 문자열

3. etc 컬럼이 100 bytes까지 문자열을 저장할 수 있도록 변경

4. etc 컬럼의 이름을 remark로 변경

5. emp 테이블의 데이터를 모두 hw_emp에 저장. remark 컬럼의 값은 모두 null

6. hw_emp 테이블의 empno 컬럼에 고유키 제약 조건을 추가*/

--1. emp 테이블과 똑같은 구조(컬럼이름, 데이터 타입)을 갖는 테이블을 hw_emp라는 이름으로 생성
create table hw_emp1
as (select * from emp where 1 != 1);
-- 컬럼 이름 + 데이터 타입은 복사가 되지만, 제약 조건은 복사가 되지 않는다 

--2. hw_emp 테이블에 새로운 컬럼을 추가
--컬럼 이름: etc
-- 데이터 타입: 최대 20 bytes 가변 길이 문자열
alter table hw_emp1 add etc varchar2(20);

select * from hw_emp1;

--3. etc 컬럼이 100 bytes까지 문자열을 저장할 수 있도록 변경
alter table hw_emp1 modify etc varchar2(100);

desc hw_emp1;

--4. etc 컬럼의 이름을 remark로 변경
alter table hw_emp1 rename column etc to remark;


--5. emp 테이블의 데이터를 모두 hw_emp1에 저장. remark 컬럼의 값은 모두 null

-- the below is teacer's solution ( I was not able to understand the problem itself) 
insert into hw_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
select * from emp;
-- column의 수를 emp와 맞추기 위해서 specify the columns as remarks 

select * from hw_emp;

-- remark 에 데이터가 없기 때문에 모두 null 


--6. hw_emp 테이블의 empno 컬럼에 고유키 제약 조건을 추가
alter table hw_emp1 add constraint pk_empno primary key (empno);


--7. 
drop table hw_emp1;
drop table hw_emp;

