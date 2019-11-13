--조건을 만족하는 레코드 검색 
--select (column), ... from (table name) where (condition)

--사원 테이블에서 부서 번호가 10인 사원들의 모든 컬럼을 검색 
select * from emp where deptno = 10;

--사원 테이블에서 급요가 2500 이상인 사람 
select * from emp where sal>=2500;

--oracle에서는 1000<=sal<2000 이런 문법은 없다. 두개로 쪼개 쓰기 
--1000<=sal, and sal<2000 
--사원테이블에서 급여가 1000 이상, 2000 미만인 직원들의 모든 컬럼을 검색 
select * from emp where 1000 <= sal and sal < 2000;

--아래 두 줄 같은 뜻 
select * from emp where 3000 <= sal and sal <= 5000;
select * from emp where sal between 3000 and 5000;
-- between A and B: used for <= & <= combination 
-- but this is different, the combination of <= & < is not workable with 'between...and...' function 
select * from emp where 3000 <= sal and sal < 5000;
-- 사원 테이블에서 급여가 1000 이하 이거나 또는 5000 이상인 직원들의 모든 컬럼 검색 
 select * from emp where sal <= 1000 or sal >= 5000;
 
 -- 사원 테이블에서 부서번호가 10 혹은 20인 사람 
 select * from emp where deptno in (10, 20);
 select * from emp where deptno = 10 or deptno = 20;
 -- 이렇게 하면 안된다: select * from emp where deptno = 10 or 20 > 못 읽어용 
 -- 프로그래밍 언어는 예외없이 딱 맞춰야한다 
 -- in (A,B,C) (or more) is also possible 
 -- between A and B 에서 A와 B는 연속적인 값. 하지만 in (A,B)는 비연속적인값 

-- 부서번호가 10번이 아닌 사람 ( different ways to express 'not' in SQL) 
select * from emp where deptno != 10;
select * from emp where deptno <> 10;
select * from emp where deptno ^= 10;
select *from emp where not deptno = 10;
 
--직원 테이블에서 직책이 clerk 인 직원들의 모든 정보를 검색해 보겠다 
select * from emp where job = 'CLERK';
-- 문자열을 비교를 할 때 따옴('')로 묶어주어야한 
 -- keyword, table name, column name  그라믄 앙대,,, 
 select * from emp where job = 'clerk'; 
--해당 코드는 결과가 1도 안나옴 > 뜻은 결과가 없다는 뜻. 이유: clerk 은 테이블에서 대문자로 저장되어있음 
--오라클에서 예약어(select, from, where, ...),  테이블 이름, 컬럼 이름은 대소문자를 구별하지 않습니다 
-- 정확히 말하자면, 오라클은 이런 것들을 대문자로 관리하기 때문에 그냥 자기가 알아서 대문자로 하는거임
-- 변수에 저장된 값들은 대소문자를 구별합니다 

-- 문자열의 크기비교 (alphabetical order)
-- 문자열도 크기 비교가 가능함. 
select * from emp where ename > 'D';
select * from emp where ename < 'D';
-- select * from emp where ename > 'F'; 에서 왜 FORD라는 이름이 포함되었을까? FORD는 F보다 크다 
select * from emp where ename > 'G';

--ejer 03.01
-- 직원 테이블에서 부서 번호가 20번 이거나 직책이 세일즈맨 인 직원들의 모든 정보를 검색해 보세요 
-- select * from emp where DEPTNO = 20 or JOB = SALESMAN;
select * from emp where deptno = 20 or job = 'SALESMAN';

-- 직원 테이블에서 직책이 'CLERK'이거나 또는 'ANALYST' 또는 'MANAGER' 인 경우 
select * from emp where job = 'CLERK' or job = 'ANALYST' or job='MANAGER';
select * from emp where job in ('CLERK','ANALYST','MANAGER');

--원 테이블에서 직책이  clerk, analyst, manager가 아닌 직원들의 모든 정보 검색 
select * from emp where job = 'CLERK'or job = 'ANALYST' or job= 'MANAGER';
select * from emp where job != 'CLERK' and job != 'ANALYST' and job != 'MANAGER';

--별명에서만 작음따옴표 ('')가 아닌 큰 따옴표 ("") 사용 
select empno as "사번" from emp;
-- 아래와 같은 경우: 중간에 빈 공간도 있는 그런 경우에는 반드시 큰 따옴표 사용 
select empno as "사원 번호" from emp;

-- 정리 
-- 오라클에서 문자열은 항상 작은 따옴표('')를 사용 
-- 컬럼의 별명 (alias) 에서만 큰따옴표 ("")를 사용함 
select empno 사번 from emp;
select empno "사번" from emp;
select empno as 사번 from emp;
select empno as "사번" from emp;

--'%' 모든 글자가 다 들어갈 수 있다 
--'_' 자릿수가 딱 한글자만 아무 글자가 들어 갈 수 있다 
-- FOR EXAMPEL 
-- 직원 테이블에서 이름이 'A'로 시작하는 직원들의 모든 정보 검색 
select * from emp where ename like 'A%';
--%가 오는 자리에는 아무 글자나 와도 되고, 몇 글자든 상관없다; 0글자 포함  

select * from emp where ename like 'A_';
--결과 없지요! A뒤에 아무 글자나 와도 되지만 딱 한자리 밖에 안됨 > 그런 이름이 테이블에 존재하지 않음 
select * from emp where job like '_LERK';
select * from emp where job like '%ERK';
select * from emp where job like '%E%';
--it works the same for how the search engines work. For instance, 야구팬 > LA 다져스> %다져스% 로 설정 

--NULL!!! 
-- 직원 테이블에서 수당이 (comm) null 인 직운들의 모든 정보를 검색
select * from emp where comm = null;
-- 결과가 없넹 ...ㅎ3ㅎ 머쓱타드^ 
-- null만 쭉 보여주지 않음, 특별히 지정된 키워드를 사용해야함 
-- null 도 키워도 = 값이 없다 
-- comm = null 값이 없는데 비교 할 수 없다/ 비교는 시작도 못 해욤 
select * from emp where comm is null;
-- 직원 테이블에서 수당이 널이 아닌 직원들의 모든 정보 검색 
select * from emp where comm is not null;
-- null 에만 is 사용 

-- 직원 테이블에서 수당을 받는 직원들 중에서 급여가 1500 초과하는 직원의 사번, 이름, 금여를 검색 
select empno, ename, sal from emp where comm is not null and sal>1500;
-- 괄호로 조건식을 명시할 수 있다 
select empno, ename, sal from emp where (comm is not null) and (sal>1500);
-- 뭐가 먼저 계산되어야 할 지 모르겠다고 판단되면, 그냥 괄호로 묶어버려라ㅏㅏ 

-- 직원 테이블에서 수당을 받지 않는 직원들 중에서 급여가 1500 초과하는 직원의 사번, 이름, 금여를 검색 
select empno,ename,sal from emp where (comm is null) and (sal>1500);

--집합,,, 
-- 합집합 (union), 교집합 (intersect), 차집합 (minus) 
select * from emp where deptno = 10 or deptno = 20;
-- 합집합/  A: deptno = 10, B: deptno = 10 > 둘이 모두니까 
-- (아래) 복잡 (위) 간단 / 어떻게 집합이 쓰이는지 보여줌 
select * from emp where deptno = 10 
union 
select * from emp where deptno = 20;
-- (위) 집합연산자 (union, minus, intersection)을 사용 할 때, 두개의 select 문장은 같은 컬럼들을 같은 순서로 검색해야한다 (주의!!) 
--1. success
select empno,ename,deptno from emp where deptno = 10 
union 
select empno,ename,deptno from emp where deptno = 20;
--2. FAIL
select * from emp where deptno = 10 
union 
select empno,ename,deptno from emp where deptno = 20;
--3. FAIL 
select deptno,empno,ename from emp where deptno = 10 
union 
select empno,ename,deptno from emp where deptno = 20;

-- Intersect examples 
-- 이름이 'E'를 포함하는 모든 직원 정보 
select * from emp where ename like '%E%';
-- job이 'E'를 포함하는 모든 직원 정보
select * from emp where job like '%E%';
-- 교집합 만들기 
select * from emp where ename like '%E%'
intersect
select * from emp where job like '%E%';

--minus example: fail = everyone in A has E in their job 
select * from emp where ename like '%E%'
minus
select * from emp where job like '%E%';
--minus example: success > I dont get this part 
select * from emp where job like '%E%'
minus
select * from emp where ename like '%E%';

--30번 부서에서 일하는 직책이 salesman인 직원들의 사번, 이름, 급여, 부서번호를 검색해보기 
--1.
select empno, ename, sal, deptno from emp where deptno = 30 
intersect
select empno, ename, sal, deptno from emp where job= 'SALESMAN';
--2.
select empno, ename, sal, deptno from emp where deptno = 30 and job= 'SALESMAN';

--20, 30번 부서에서 일하는 직원들 중 급여가 2000을 초과하는 직원들의 사번, 이름, 급여, 부서번호를 검색 
--1.
select empno, ename, sal, deptno from emp where deptno in (20,30) and sal>2000;
--2.
select empno, ename, sal, deptno from emp where (deptno = 20 or deptno = 30) and sal>2000;
-- FAIL: select empno, ename, sal, deptno from emp where deptno = 20 or deptno = 30 and sal>2000;

--수당이 없는 직원들 중에서, 매니저가 있고, 직책이 'MANAGER' 또는 'CLERK'인 직원들의 모든 정보를 검색 
--1.
select * from emp where (comm is null) and (MGR is not null) and (job = 'MANAGER' or job = 'CLERK');

--2. 
select * from emp
where comm is null
     and MGR is not null 
     and job in ('MANAGER','CLERK');
     
     