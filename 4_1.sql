--다중행 함수 (multi-row function or group function) 
-- 여러개의 행이 함수의 argument로 전달되서 하나의 결과값이 출력되는 함수 

select sum(sal),round(avg(sal),2),
       max(sal),min(sal),
       variance(sal),stddev(sal) 
from emp;

--모든 사원의 급여의 총 합계  
--select sum (column name) from (the table to withdraw the data);  
select sum(sal) from emp;
--모든 사원의 급여의 평균 
select avg(sal) from emp;
-- 숫자가 너무 크면, round or trunc 
select round(avg(sal),2) from emp;
--최댓값, 최솟값 
select max(sal),min(sal) from emp;
--분산
select variance(sal) from emp;
--표준편차
select stddev(sal) from emp;
--분산과 표준편차가 크기가 클수록 평균에서 멀다 (그래프가 넒게 퍼져있다), 크기가 작을수록 평균에 가깝다 (그래프가 좁게 솟아있다?) 

-- 데이터의 갯수를 세주는 함수 
--count(변수): 데이터의 갯수를 리턴/반환(답을 준다)해주는 함수 
select count(*)from emp;
--행의 갯수 (14) 를 리턴해준다 
--특정 컬럼의 이름을 줄 수도 있따 
select count (empno) from emp;
-- null 을 포함한 컬럼 
select count(mgr) from emp;
--1개의 null존재 (King/pres); null을 빼고리턴 (count함수는 null이 아닌 값들의 갯수를 리턴)
--그래서 null값이 몇개가 있는지를 알아볼 때도 많이 사용 
select count(comm) from emp;

select count (deptno) from emp;
-- answer:14; 중복된 값이 많다 ! ㅇㅁㅇ!!!! 
select count (deptno),count(distinct deptno) from emp;
-- distinct를 사용하여 중복된 값을 물리쳤다,,,! :  count(distinct 변수): 중복되지 않는 값들의 갯수를 리턴 

select empno, count(empno) from emp;
-- ERROR! ORA-00937: 단일 그룹의 그룹 함수가 아닙니다/00937. 00000 -  "not a single-group group function"
--두 결과의 행의 갯수가 달라서 > empno는 단일 (column 1개의 행 14개가 있는 결과) ,  count는 그룹 함수 (결과 1개) (두개를 동시에 출력 불가) 
--(주의) 여러 행의 결과로 출력되는 변수와 그룹 함수는 함께 select할 수 없다 (출력 형태가 다르기 때문에) 

--Max()와 Min()은 문자열, 데이트 타입에도 사용 할 수 있다. 
select max(hiredate),min(hiredate) from emp;
-- max: 1987/05/03, min:1980/12/17
-- 지금과 더 가까운 날짜가 max, 오래됐을 수록 min > 숫자가 크면 장땡 
--근속 연수가 적다 : max(hiredate)를 이용해야한다 

--[order by column]:  출력의 순서를 정해준다 
--otfrt by 변수 (칼럼)이름 정렬방식; 
-- 정렬방식: 내일차순: descending, 오름차순: asc
-- order by의 default 정렬 방식은 오름차순이라, 오름차순으로 할꺼라면 생략 가능
select * from emp order by empno desc;
select * from emp order by empno;
select * from emp order by empno asc;
--57&58 은 같은 결과를 같는다 

select * from emp order by deptno;
-- 같은 deptno안에서는 그 안에서 정리된 순서대로 나온다 

select * from emp order by deptno asc, empno desc;
-- 기준은 먼저나온 변수로 정렬을 시키고, 그 정렬시킨 상태에서 두번째를 가지고 정렬 
-- 부서넘버대로 정렬 > 10안에서 empno desc, 20안에서 empno desc ... 
-- 정렬된 언어를 옮겨 받을 때에는 시간이 오래 걸린다 (order by 된 상태), 실무에서는 정렬되지 않은 것을 받아와서 파이썬이나 자바같은 프로그래밍 언어로 다시 정렬시킨다 

--30번 부서 사원들의 급여의 합계, 최솟값, 최댓값, 평균, 분산, 표준편차 
select sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 30;

-- If we include deptno under select, then there will be an error (number invalid)/ "not a single-group group function" 
select deptno,
       sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 30;

-- 꼼수: select 30 as DEPTNO 
select 30 as DEPTNO,
       sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 30;


select 10 as DEPTNO,
       sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 10;

select 20 as DEPTNO,
       sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 20;


-- 똑같은 모양을 가진 아이들을 'union'으로 묶어서 하나로 만들 수 있다 

select 10 as DEPTNO,
       max(sal) as max,
       min(sal) as min,
       avg(sal) as avg
from emp
where deptno = 10
union
select 20 as DEPTNO,
       max(sal) as max,
       min(sal) as min,
       avg(sal) as avg
from emp
where deptno = 20
union
select 30 as DEPTNO,
       max(sal) as max,
       min(sal) as min,
       avg(sal) as avg
from emp
where deptno = 30;

--모든 그룹 함수는 기본적으로 null을 제외하고 기능을 수행 
select sum(comm),avg(comm) from emp;
-- There is no need to put an additional condition such as "where comm is not null"
-- null 이 누락 되는 것이 좋을 수도 아닐수도,,,^^; 
-- 위: null누락 sum: 4명의 comm, avg: sum for the 4 people/4 

select sum(comm)as sum,avg(comm) as avg1,avg(nvl(comm,0)) as avg2 from emp;
--AVG2 comm of the 4 people/14(everybody) 

--null값 처리가 굉장히 중요하다 (통계적인 부분) 

--GROUP BY를 사용한 쿼리 
--비슷한 아이들끼리 묶는 것 > group by 
select deptno, round(avg(sal),2), max(sal),min(sal)
from emp
group by deptno
order by deptno;

--직책별 급여 평균, 최솟값, 최댓값
select job, round(avg(sal),2) as avg,max(sal),min(sal)
from emp
group by job;

--매니져별 급여 평균 
select mgr, round(avg(sal),2) as avg
from emp
group by mgr;

-- select 에서 사용될 수 있는 칼럼은 > 그룹지어진 칼럼만 사용가능 
select ename, deptno, avg(sal)
from emp 
group by deptno;
-- ERROR! ORA-00979: GROUP BY 표현식이 아닙니다.
-- 00979. 00000 -  "not a GROUP BY expression"
-- group by 에서 사용되지 않은 변수/칼럼 은 select 할 수 없습니다 (i.e. ename) 

--부서별 급여 평균 출력, 단 평균 급여가 2000이상인 부서만 출력  . 
select deptno,avg(sal)
from emp
group by deptno
having avg(sal)>=2000;
-- where 은 group by 가 없어도 쓸 수 있어야하는 것 + 각 group 의 average
-- having 자리에 where 을 쓰면: ERROR! ORA-00933: SQL 명령어가 올바르게 종료되지 않았습니다
--00933. 00000 -  "SQL command not properly ended"
-- 그래서 having! 

-- 만약에 ~ 한다면: 조건 > If, having, 
-- having (묶어 놓은 결과에 뭔가를 할 때) (dept/mng별 급여 차이) 
-- where 그룹 짓는 거랑은 상관 없는 것 (i.e. 만약에 mng가 null인 사람을 빼고 싶을 때) 

-- 매니저가  null이 아닌 직원들 중에서, 매니저 별로 평균 급여 출력 
select mgr, round(avg(sal),2)
from emp
where mgr is not null
group by mgr;
-- having 을 써도 같은 결과를 갖는다, 하지만 where > quita el cell sin mgr primero, 
-- pero si se usa en having > hace la tablada de 7 y quita uno (tarda mas tiempo y inefficiente)

-- 두개 이상의 칼럼을 가지고서 그룹을 짓는 방법 
-- 부서별, 직책별 평균 급여 계산 
select deptno, job, avg(sal)
from emp
group by deptno, job
order by deptno,job;

select deptno, job, avg(sal)
from emp
group by deptno,job
order by deptno,job;
-- 총 갯수는 같지만, 표시 형식이 달라진다 

--1)부서번호, 부서별 평균 급여, 부서별 최고/최소 급여, 사원수 
--부서번호 오름차순으로 출력. 소숫점은 반올림해서 한자리 까지만 출력 
select deptno,round(avg(sal),1) as avg_sal,
       max(sal)as max,min(sal)as min,
       count(empno)as CNT
from emp
group by deptno
order by deptno;

--2)같은 직책을 갖는 사원스가 3명 이상인 지책에 대해서. 직책별 사원수를 출력 

--MY ORIGINAL ANSWER 
select job,count(empno) as EMP#
from emp
where count(empno)>=3
group by job;

-- ERROR 1: ORA-00934: 그룹 함수는 허가되지 않습니다
--          00934. 00000 -  "group function is not allowed here"
-- ERROR2: This is looking for the classification according to JOB not #ofpeople (KNOW_WHAT_IS_ON_THE_CENTER_OF_THE_PROBLEM)

-- After asking the seatmate 
select job,count(empno) as CNT
from emp
group by job
having count(job)>2; 


--Q. 왜 where 이 아니고 having 일까ㅠㅠㅜㅜㅠ 난 왜 모르겠지,, 
-- 아마, 묶어야 답이 나오니까, where 은 못 쓴다 (그런 값이 없으니까) 

-- teacher's solution
select job,count(*) as CNT
from emp
group by job
having count(*)>=3;

--CNT는 별명 > 화면에 출력하기 위한 도구일 뿐, 계산에는 별명이 사용되지 않는다 
-- * is a special expression that is not evaluated, it simply returns the number of rows.

-- 근데 또 order by 에서는 CNT가능,,,^^;
-- select에서 만든 컬럼의 별명 (alias)는 having 절에서 사용할 수 없음! 
select job,count(*) as CNT
from emp
group by job
having count(*)>=3
order by CNT;


--3)입사 연도별 급여 평균, 급여 최소/최댓값을 출력 
select to_char(hiredate,'YYYY') as YYYY, 
       avg(sal) as AVG,min(sal) as MIN,max(sal) as MAX, count(*)
from emp
group by to_char(hiredate,'YYYY')
order by YYYY;


--GUESS 
select to_date('hiredate','YYYY'), avg(sal),min(sal),max(sal)
from emp
group by to_date('hiredate','YYYY')
order by to_date('hiredate','YYYY');
-- The original answer was correct on to_char and the rest 


-- 4)입사 연도별, 부서별로 몇명이 입사했는 지를 출력 
select to_char(hiredate,'YYYY')as YYYY, 
       deptno,count(*)as CNT
from emp
group by to_char(hiredate,'YYYY'), deptno
order by YYYY, deptno;

--5)수당(comm)을 받는 직원수와 받지 않는 직원수를 출력 
select comm,count(*)
from emp
group by comm
having nvl(comm,0);


--Teacher's Answer 
select nvl2(comm,'y','n') as COMM2,count(*)as CNT
from emp
group by nvl2(comm,'y','n');

--SUBQUERY 

