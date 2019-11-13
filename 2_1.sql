--테이블에서 데이터 검색 
--1) column 별로 검색 (projection) 
--2) row 별로 검색 (selection) 
-- SQL문장에서 column별로 검색 
-- select 컬럼 이름1, 컬럼 이름 2, ... from 테이블이름 
-- 사원 테이블(emp) 에서 사번 (empno)과 사원이름 (ename)검색하기 
select empno, ename from emp;
-- ejer. 01 사원테이블에서 사번, 이름, 입사날짜, 급여를 검색 
select empno, ename, hiredate, sal from emp;
select ename,empno,mgr, deptno from emp;
--* 테이블에서 모든 칼럼을 검색하고 싶을 때 > ***** *별표 하나 써주기 (ALL) 
-- select * from table name; 
select * from emp;

-- when we need to print the table out as a document to be presented 
-- select (column name) as  (별명이름, ... from (테이블 이름);
select ename as 이름, empno 
as 사번 from emp;

-- 아래 처럼 하면 ename은 다르게 출력, empno는 그대로 출력 됨 
select ename as 이름, empno from emp;

select empno, ename, sal from emp;
-- 하지만 사장님이 원하는건 월단위의 급여가 아닌 연봉이라면?! 두둥 
-- select sal * 12 as annumalsal from emp;
select sal * 12 as annual_sal from emp;
-- select sal * 12 + comm from emp; 해당코드는 실행 안됨, comm null로 설정되어있는 observations들이 모두 null됨 
select sal * 12 from emp;
select empno, ename, sal, sal*12 from emp;
--  (위) 연습한 코드 (아래) 정리된 코드 
select empno, ename, sal, sal * 12 as ANNUAL_SAL from emp;

-- ejer02. sal 옆에 comm 이라는 column 이 있다. comm 을 받는 직원은 4명 (0원 포함) , 공통 특징은, 그들은  salesmen 에오에오 
-- 급여 + 보너스 (매달 같은 수당을 받는다고 가정 했을 때) 
select empno, ename, sal, sal * 12 + comm as ANNUAL_SAL from emp;
 --  코드 실행 안됨 (comm이 기재되어 있지 않고, null로 되어있는 직원들은 다 null로 뜸) 
 -- null = 값이 없습니다/ 0과 null은 다르다, 0은 값(0)이 있기 떄문에 계산 가능하지만, null은 계산 불가능.  
 
 -- 사원테이블에서 직책 (job)만 검색 
 select job from emp;
 --  the results gives 14 observations, however, if you only want to know the number of jobs 
 -- then, we have to delete the repeated ones 
-- 중복된 행의 값을 제거하고 검색 
select distinct job from emp;

select job, deptno from emp;
select distinct job, deptno from emp;
--(여기까지 gdocs에 저장)
 
 select * from emp where deptno = 10;
 select * from emp where sal >=3000;
 select * from emp where sal BETWEEN 1000 AND 2500;