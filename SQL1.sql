--sql notes-- 
select table_name from user_tables;

--테이블의 자료 타입 확인-- 
desc dept; 

-- 오라클 자료 타입 (data type): i.e. NUMBER, VARCHAR2, DATE, etc 
-- number: 숫자타입 (예: 전체 자릿수, 소숫점 자릿수) 
-- varchar2 (문자열 길이): 문자열 (string)/ 가변 길이 문자열 (variable-length characters/string) 타입 
-- 문자열의 길이를 주는 이유: 최대 몇 글자 까지~ 정해주기 
-- date: 시간(yy/mm/dd hh/mm/ss) 정보를 저장하는 타입 

desc emp;

-- 테이블 전체 데이터 (레코드) 출력 
select * from emp;

select table_name from user_tables;
-- user tables: tables that the user have permission to 
-- these are from hr 
-- received warning from commands below: 
-- 오류: ORA-04043: countries 객체가 존재하지 않습니다. 
--desc countries;
--desc departments;
--desc employees;
--select * from countries; 
--select * from departments; 
--select * from employees; 

-- 조건을 만족하는 레코드 검색 
-- select (column), .. from (table name) where condition 

-- 사원 테이블에서 부서 번호가 10인 사원들의 모든 컬럼을 검색 
select * from emp where deptno = 10;

-- 사원 테이블에서 급여가 2500 이상인 사람 
select * from emp where sal >= 2500

-- oracle에서는 1000 <= sal < 2000 이런 문법은 없다. 
-- 두개로 쪼개 쓰기 => 1000 <= sal, sal < 2000 
select * from emp where 1000 <= sal and sal < 2000; 

-- 아래 두 줄 같은 뜻 
select * from emp where 3000 <= sal and sal <= 5000; 
select * from emp where sal between 3000 and 5000;
-- between A and B == A <= X <= B 
-- but not workable with A <= X < B 
select * from emp where 1000 <= sal and sal < 2000; 

-- 사원 테이블에서 급여가 1000 이하 이거나 또는 5000 이상인 직원들의 모든 컬럼 검색 
select * from emp where sal <= 1000 or sal >= 5000; 

-- 사원 테이블에서 부서번호가 10 혹은 20인 사람 
select * from emp where deptno in (10,20);  -- in (ㄱ,ㄴ,ㄷ) 도 가능
select * from emp where deptno = 10 or deptno = 20;
-- ERROR IF: deptno = 10 or 20 > 못 읽음 

-- 프로그래밍 언어는 예외없이 딱 맞춰야한다 

-- between A and B vs in (A,B) 
-- the former is a continuous value (연속적), where the latter is discrete(비연속적) 

-- different ways to express 'not' in SQL
-- 부서번호가 10번이 아닌 사람 
select * from emp where deptno != 10;
select * from emp where deptno <> 10;
select * from emp where deptno ^= 10;
select * from emp where not deptno = 10;

-- SQLDeveloper 글자 크기 변경: 도구 > 환경설정 > 글꼴 

-- 직원 테이블, 직책 clerk, 모든 정보 검색 
select * from emp where job = 'CLERK';

-- 문자열 비교시 따옴표로 묶어줌 ('') 
-- 예) keyword, table name, column name 에서는 반드시 따옴표 사용 
select * from emp where job = 'clerk'; 
-- 결과 1도 안나옴: clerk는 대문자로 저장되어 있기 때문에 결과가 없음 
-- 오라클에서 예약어(select, from, where, ...),  테이블 이름, 컬럼 이름은 알아서 대문자로 관리하기 때문에 대소문자를 구별하지 않음. 
-- 하지만, 변수에 저장된 값들은 대소문자를 구별한다 

-- 문자열의 크기비교 (alphabetical order) 가능 
select * from emp where ename >'D';
select * from emp where ename < 'D';
select * from emp where ename > 'F';
-- 에서 FORD도 포함 (FORD는 F보다 큼) 
select * from emp where ename > 'G';



