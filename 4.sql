--SQL_ex_04 
-- 1. 사원 이름 5글자인 사원 정보 empno, ename을 출력.
-- 사번은 앞 두 자리만 보여주고 나머지는 *로 출력
-- 이름은 첫 글자만 보여주고 나머지는 *로 출력
-- (결과 예시)
--empno mask_no ename mask_name
-----------------------------
-- 7369    73** SMITH S****

-- what I did 
select empno,rpad(substr(empno,1,2),length('empno'),'*') as mask_no,ename,rpad(substr(ename,1,1),length('ename'),'*') as mask_name
from emp 
where length(ename) = 5;

-- What teacher did 
select empno,rpad(trunc(empno,-2)/100,4,'*') as mask_no,ename,rpad(substr(ename,1,1),5,'*') as mask_name
from emp 
where length(ename) = 5;

-- extra: use substr instead of trunc 
select empno,rpad(substr(ename,1,2),4,'*') as mask_no,
       ename,rpad(substr(ename,1,1),5,'*') as mask_name
from emp 
where length(ename) = 5;


-- 2. 사원들의 월 평균 근무일수는 21.5일이고, 하루 근무 시간을 8시간이라고 할 때,
-- 사원들의 일 급여(day_pay), 시급(time_pay)를 계산하여 출력.
-- 일 급여는 소숫점 세번째 자리에서 버림, 시급은 소숫점 두번째 자리에서 반올림
-- (결과 예시)
-- empno ename sal day_pay time_pay
--------------------------------
 -- 7369 SMITH 800   37.20      4.7

 select empno, ename, sal, 
        trunc(sal/21.5,2) as day_pay, 
        round(sal/21.5/8,1) as time_pay 
 from emp;
 
  select empno, ename, sal, 
        trunc(sal/21.5,2) as day_pay, 
        round(sal/(21.5*8),1) as time_pay 
 from emp;

-- 3. 입사날짜를 기준으로 3개월이 지난 후 첫번째 월요일에 정직원이 된다고 할 때,
-- 사원들이 정직원이 되는 날짜를 YYYY-MM-DD 형식으로 출력.
-- (Hint) next_day(날짜, 'x요일'): 돌아오는 요일의 날짜를 리턴
--(결과 예시)
-- empno ename hiredate   regular
---------------------------------
 -- 7369 SMITH 1980/12/17 1981-03-23
 
 
select empno,ename,
       to_char(hiredate,'YYYY-MM-DD') as hiredate, 
       to_char(add_months(next_day(hiredate,'월요일'),3),'YYYY-MM-DD') as regular 
from emp;

-- what is the data type
 
 select empno,ename,
       to_char(hiredate,'YYYY-MM-DD') as hiredate, 
       to_char(next_day(add_months(hiredate,3),'월'),'YYYY-MM-DD') as regular
from emp;