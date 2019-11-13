--ex 6. 
--(1) 각 사원의 근속년수를 알아보고자 합니다. 아래와 같이 출력되도록 SQL을 작성하세요.
--EMONO   ENAME   HIREDATE                YEAR
--7369	SMITH	1980-12-17 00:00:00	38
--7499	ALLEN	1981-02-20 00:00:00	38
--......


select empno, ename, hiredate,   

       to_char(hiredate,'YY') as year
from emp;

--(2) 부서별 가장 빠른 입사 날짜를 출력하는 SQL을 작성
--DEPTNO  MIN_HIREDATE
--10	1981-06-09 00:00:00
--20	1980-12-17 00:00:00
--30	1981-02-20 00:00:00
--

select min(hiredate)
from emp
where deptno = 10
union 
select  min(hiredate)
from emp
where deptno = 20
union 
select  min(hiredate)
from emp
where deptno = 30;

-- Problem: no se imprime el deptno 

--(3) 10번 부서에서 입사 날짜가 가장 빠른 직원의 부서 번호, 사번, 이름, 근속년수를 출력하는 SQL을 작성
--(결과 예시)
--10, 7782, CLARK, 38


select deptno, empno, ename, round((to_date(sysdate - hiredate),'year'),0) as Year 
from emp 
where deptno = 10 and hiredate = min(hiredate); 


--
--(4) 각 부서에서 입사 날짜가 가장 빠른 직원의 부서 번호, 사번, 이름, 근속년수를 출력하는 PL/SQL을 작성
--(결과 예시)
--10, 7782, CLARK, 38
--20, 7369, SMITH, 38
--30, 7499, ALLEN, 38

select deptno, empno, ename, round(to_date(sysdate - hiredate),'Year') as Year
from emp 
where deptno = 10
union
select deptno, empno, ename, round(to_date(sysdate - hiredate),'Year') as Year
from emp 
where deptno = 20 
union
select deptno, empno, ename, round(to_date(sysdate - hiredate),'Year') as Year
from emp 
where deptno = 30; 
