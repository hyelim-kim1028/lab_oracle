-- ejer 03.01 
-- 직원 테이블에서 부서번호가 20번 이거나 직책이 세인즈맨인 모든 정보를 검색 
select * from emp where deptno = 20 or job = 'SALESMAN';

-- 직원 테이블에서 직책이 'CLERK', 'ANALYST' 또는 'MANAGER'인 경우 
select * from emp where job = 'CLERK' or job = 'ANALYST' or job = 'MANAGER';
select * from emp where job in ('CLERK', 'ANALYST', 'MANAGER');

-- 원 테이블에서 직책이 clerk, analyst, manager가 아닌 직원들의 모든 정보 검색 
select * from emp where job != 'CLERK' or job != 'ANALYST' or job != 'MANAGER';

-- 별명에서만 작은 따옴표('')가 아닌 큰 따옴표("") 사용 
select empno as "사번" from emp;
-- the name of the column changes from empno -> 사번 

-- 중간에 빈 공간이 있는 경우 반드시 큰 따옴표("") 사용 
select empno as "사원 번호" from emp;

-- 정리 
-- 오라클에서 문자열은 항상 작은 따옴표 사용 ('') 
-- 컬럼의 별명(alias)에서만 큰 따옴표("") 사용 

-- 아래 코드 모두 사용 가능 
select empno 사번 from emp;
select empno "사번" from emp;
select empno as 사번 from emp;
select empno as "사번" from emp;

-- '%' : 아무 글자, 자릿수 unli, including 0 
-- '_' : 아무글자, 자릿수 = 1 
-- FOR EXAMPLE, 
-- 1) 직원 테이블에서 이름이 'A'로 시작하는 직원들의 모든 정보 검색 
select * from emp where ename like 'A%';
-- A_: 한자리 밖에 안됨 (X 존재) 
select * from emp where ename like 'A_';
-- practice: 
select * from emp where job like '_LERK';
select * from emp where job like '%ERK';
select * from emp where job like '%E%';
-- ex) how the search engines work 야구팬 > LA 다져스> %다져스% 로 설정 

-- NULL!! IS NULL, IS NOT NULL 
select * from emp where comm = null;
-- nothing has been returned 
-- null만 쭉 보여주지 않음, 특별히 지정된 키워드 사용 해야함 
-- null은 값이 없는 것, = null해도 없는 값이라 보여주지 않음 
-- 결과적으로, comm = null> 값이 없으니까 비교할 수 없음 

-- 직원 테이블에서 수당(comm)이 null인 직원들의 모든 정보 검색 
select * from emp where comm is null;
-- 직원 테이블에서 수당(comm)이 null이 아닌 직원들의 모든 정보 검색 
select * from emp where comm is not null;
-- null에만 is 사용 

-- 직원 테이블에서 수당을 받는 직원들 중에서 급여가 1500 초과하는 직원의 사번, 이름, 급여를 검색 
select empno, ename, sal from emp where comm is not null and sal > 1500;
-- 헷갈릴 때 => 괄호로 조건식 명시 
select empno, ename, sal from emp where (comm is not null) and (sal > 1500);
-- 직원 테이블에서 수당을 받지 않는 직원들 중에서 급여가 1500 초과하는 직원의 사번, 이름, 금여를 검색 
select empno, ename, sal from emp where (comm is null) and (sal >1500);

-- 집합 
-- 합집합(union), 교집합(intersect), 차집합(minus) 
select * from emp where deptno = 10 or deptno = 20;





