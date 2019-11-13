 --JOIN SQL

--ORACLE METHOD of cross join 
select * 
from emp, dept;
-- deptno 그리고 produced deptno_1 : this is because there is another deptno column in both emp table and dept table 
-- to distinguish the two, Oracle produced a deptno_1 column 
-- the total records are 56 > ??? 
-- there 14 in emp and are 4 in dept table, so 56 results mean the return of all possible 경우의 수 (14*4) 
--However, eventhough there is a relationship between deptno & deptno_1, it gave all the feasible ones (only the matchy ones will be the meaninful data) 


--ANSI METHOD of cross join (standadrd method) 
select *
from emp cross join dept;

-- The ORACLE and the ANSI results are the same
-- This is not the desired type of data result we want (we only want the matchy ones) 

-- Oracle method of JOIN
select *  
from emp, dept
where emp.deptno = dept.deptno;
-- where (the table name).(column name) 
-- EQUIJOIN ex.emp.deptno = dept.deptno 


--Gives out the same results 
select *  
from emp, dept
where emp.deptno = dept.deptno
order by empno;
--or
select *  
from emp, dept
where emp.deptno = dept.deptno
order by emp.empno;

select * 
from emp, dept
where emp.deptno = dept.deptno
order by emp.deptno;

--ANSI method of JOIN 
select * 
from emp join dept
on emp.deptno = dept.deptno
order by emp.deptno;
-- 조건 부분에 where 이 아닌 on을 써준다 (읭,,,?) 

-- In oracle method, there is no need for the user to remember the type of join, but the ANSI one has to specify 
-- When the table names are long, we give them an alias to shorten ( from (original table name) _space_ (alias)
select * 
from emp e join dept d 
on e.deptno = d.deptno 
order by e.deptno;
-- the above is the same as the line 45-48 
-- 별명을 한번 주면 계속 그 별명으로 사용해야한다 :-) 

-- emp table 과 dept table에서 사번, 이름, 부서번호, 부서이름 만 검색하고 싶을 때 
-- 오라클 방식 
select e.empno, e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno
order by e.deptno;
-- on the line 62, we had to specify which table which the column comes from 
-- en select, se usaban e o d proque hemos puesto el alias/apodo en from 
-- en select> deptno, le da igual a user e o d  
--or 
-- ANSI Method 
select e.empno, e.ename, d.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno
order by e.deptno;

-- ERROR! ORA-00918: 열의 정의가 애매합니다; 00918. 00000 -  "column ambiguously defined"
-- without specifying the table of origin, it occurs an error 

-- emp table 과 dept table에서 사번, 이름, 부서번호, 부서이름 만 검색하고 싶을 때 (단, 급여가 2000 이상인 사람만) 
-- 오라클 방식 
select e.empno, e.ename, e.sal, d.deptno, d.dname 
from emp e, dept d 
where e.deptno = d.deptno 
      and 
      e.sal >= 2000
order by e.deptno;
-- when joining two conditions under 'where' clause, use and not , 
-- or 
-- ANSI Method 
select e.empno, e.ename, e.sal, d.deptno, d.dname 
from emp e join dept d
on e.deptno = d.deptno 
where e.sal >= 2000
order by e.deptno;
-- on is under the from clause 

select empno, ename, sal, d.deptno, dname 
from emp e join dept d
on e.deptno = d.deptno 
where e.sal >= 2000
order by e.deptno;
-- 한쪽에만 있는 column에 경우 테이블을 스킵해도 무관 

--emp테이블과 salgrade 테이블에서 사번, 이름, 급여, 급여등급 
-- Oracle Method 
select empno, ename, sal, s.grade
from emp e, salgrade s 
where e.sal between s.losal and s.hisal;

-- In emp table, there was a sal column, but in salgrade table, there were grade, lowsal, highsal 
-- there is no the same column, so let's compare if sal is between high and low sal in the salgrade table 
-- nonquijoin -같다다르다가 아닌 크기비요를 refer to 하는 용어 

--ANSI method 
 select empno, ename, sal, s.grade
 from emp e join salgrade s 
 on e.sal between s.losal and s.hisal;
 --between (min) and (max) 
--or 
  select empno, ename, sal, s.grade
 from emp e join salgrade s 
 on e.sal >= s.losal and e.sal<=s.hisal; 
 
-- CONNECTING THREE TABLES 
-- emp, dept, salgrade table 에서 사번, 이름, 부서번호, 부서이름, 급여, 급여등급 출력 
-- Oracle method 
select e.empno, e.ename, d.deptno, d.dname, e.sal, s.grade
from emp e, dept d, salgrade s 
where e.deptno = d.deptno 
      and 
      e.sal between s.losal and s.hisal;

-- ANSI method 
select e.empno, e.ename, d.deptno, d.dname,e.sal,s.grade
from emp e join dept d join salgrade s 
on e.deptno=d.deptno and e.sal between s.losal and s.hisal;
-- nonono 
select e.empno, e.ename, e.deptno, d.dname, e.sal, s.grade
from emp e join dept d 
        on e.deptno=d.deptno 
    join salgrade s
        on e.sal between s.losal and s.hisal;
-- 테이블이 두개 이상이 되면 안시방식은 복잡해진다 (join-on-join-on 으로 연결) 

-- emp table 에서 사번, 이름, 매니저사번, 매니저 이름을 출력하고 싶다 (자기자신 self join) 
-- Oracle method 
select e1.empno, e1.ename,e1.mgr,e2.ename 
from emp e1, emp e2 
where e1.mgr = e2.empno;
-- e1 의 정보들을 통해 같은 테이블에서 e2라는 새로운 (하지만 같은 테이브레서 파생되는) 정보를 리턴한다 

--ANSI method 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1 join emp e2 
on e1. mgr = e2.empno;

-- 기사시험은 표준방식으로 출제 (오라클방식 노노) 
-- ANSI 가 더 타이핑수는 많지만, 더 명확하다 
-- non-equi join (크다, 작다) 
-- outer join (외부조인,,,?): 한쪽 테이블에만 있는 값들이 있을 때도 있다. 왼쪽이나 오른쪽에 있는 것만 혹은 모두 조인 할 것 이냐 
-- Left (outer) join , right (outer) join 

-- dept table : there are four departments in this company 
-- emp table : if you look at the deptno, there is no deptno.40 appear (it appears in dept table, but no in emp table) 
-- It means there is no one in the department yet (no hired employee) 
-- Are we going to make deptno.40 appear on the joined table or not? 
-- when we want to make deptno.40 appear on emp table where dept40 does not exist > we use the outer join sequel 
-- refer to the notes (written one) 

-- emp table & dept table 에서 사번, 이름, 부서번호, 부서이름을 출력 
-- 단, dept 테이블에 있는 모든 부서 정보를 출력 
-- Oracle method 
select e.empno, e.ename, d.deptno, d.dname 
from emp e, dept d 
where e.deptno=d.deptno;
-- 사번, 이름의 deptno 40은 존재하지 않는다 ( null) 로 추가
-- 오른쪽에 있는 전부를 출력하겠다 (right join) > dept 기준 
-- 40에 해당되는게 없는 것들은 null로 추가 > 왼쪽에 (+)로 추가 / 오른쪽을 기준으로 왼쪽 빈칸에 (+) null이라도 추가해주세요
select e.empno, e.ename, d.deptno, d.dname 
from emp e, dept d 
where e.deptno (+) =d.deptno;

-- left 조인! 
select e.empno, e.ename, d.deptno, d.dname 
from dept d, emp e 
where d.deptno=e.deptno;
-- 왼 dept 오 emp : left join > (+) on the right side 
select e.empno, e.ename, d.deptno, d.dname 
from dept d, emp e 
where d.deptno=e.deptno (+);


--ANSI method 
select e.empno, e.ename, d.deptno, d.dname 
from emp e right join dept d 
on e.deptno = d.deptno;
-- right join: 오른쪽을 기준으로 출력해주세요 

select e.empno, e.ename, d.deptno, d.dname 
from dept d left join emp e
on d.deptno = e.deptno;
-- left join:  왼쪽을 기준으로 출력해주세요 

--emp table에서 사번, 이름, 매니저사번, 매니저이름 출력 
-- Oracle method 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1, emp e2 
where e1.mgr = e2.empno;
-- King (null) 이 빠져있다 / e1이 기준이 된다 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1, emp e2 
where e1.mgr = e2.empno(+);
--왼오바꾸기 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1, emp e2 
where e2.empno(+) = e1.mgr;

-- ANSI Method 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1 left join emp e2 
     on e1.mgr = e2.empno;
-- 전체 출력 (king 포함); 매니저가 존재하지 않는 king의 정보도 함께 출력 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1 right join emp e2 
     on e1.mgr = e2.empno;
-- 왜 때문에 결과가 21개지,,,? + King도 안보임 
-- 추가된 사람들 자기 부하 직원을 갖지 않는 직원들의 정보를 함께 출력/ 위에 상사와 아래의 후배가 모두 있는 사람들이 교집합  
-- left join: 위에 있는 킹을 보이느냐 right join: 밑의 부하가 없는 사람들을 보이느냐 
select e1.empno, e1.ename, e2.empno, e2.ename 
from emp e1 right join emp e2 
     on e1.mgr = e2.empno;
-- King은 자기 밑에 매니저는 없다, 사장님이기 때문에 

-- 다시해보기 + 이해하기 (이해는 했는데  I want to do it more concretely) 

-- full (outer) join 
-- full joi 은 ANSI 방식의 문법만 있고, Oracle 방식의 문법은 없다. (즉, oracle 은 full join의 함수가 읎다)
-- 위의 left join results + right join results = full join results
select e1.empno, e1.ename, e2.empno, e2.ename 
from emp e1 full join emp e2 
    on e1.mgr = e2.empno;

-- Oracle  method  로 full join 을 하려면 union 연산자를 사용해야 함 
select e1.empno, e1.ename, e2.empno, e2.ename 
from emp e1, emp e2 where e1.mgr = e2.empno(+) 
union 
select e1.empno, e1.ename, e2.empno, e2.ename 
from emp e1, emp e2 where e1.mgr (+) = e2.empno;
-- oracle 에서 양쪽 다 (+)하는 방법은 없다 
-- 한쪽에 (+) union 다른 쪽에 (+) 

--JOIN 연습
--(모든 문제는 Oracle 방식과 ANSI 방식 두가지 SQL 문장을 작성.)

--1. scott 계정 사용
--1) emp 테이블과 dept 테이블을 사용해서
--부서번호, 부서이름, 각 부서 직원들의 급여 평균, 최대, 최소값, 직원수 (다중행 함수들)를 출력.
--소숫점은 한자리까지만 표시.
--(결과 예시)
--deptno  dname           avg     max     min     cnt
-----------------------------------------------------
--10	ACCOUNTING	2916.6	5000	1300	3

-- Oracle Method 
select d.deptno, d.dname, e.round(avg(sal),1) as avg ,e.max(sal) as max,e.min(sal) as min,e. count(*) as cnt 
from emp e, dept d
where e.deptno = d.deptno
group by deptno,dname;

-- ANSI Method 
select d.deptno, d.dname, round(avg(e.sal),1) as avg ,max(sal) as max,min(sal) as min,count(*) as cnt 
from emp e join dept d
on d.deptno = e.deptno;

-- 쌤 solution (위: 내 오답) 
--Oracle Method 
--1. -- dname 만 없어도 모두 emp가지고 가능하기 때문에 일단 만들어 본다 
select deptno,round(avg(sal),1) as avg,max(sal),min(sal),count(*) as cnt 
from emp
group by deptno;
-- select 에 있는 아가는 group by에도 있어야한다 (여기서는 deptno) 
-- dept 테이블을 추가해줘서 테이블 이름도 추가해준다 
select d.deptno,d.dname,round(avg(sal),1) as avg,max(sal),min(sal),count(*) as cnt 
from emp e, dept d
where e.deptno = d.deptno
group by d.deptno,d.dname;
-- deptno 는 e와 d 모두에 있는 것이라 꼭 명시해주어야하고, 나머지는 uniqe in one table 이라 안해줘도 된다 
-- select 에 e.deptno 라고 했다면, group by 에서도 e.deptno로 통일 
-- e.sal,d.dname 다 붙여도 된다 
-- count(*) or count(empno) 

--ANSI Method 
select d.deptno,d.dname,round(avg(sal),1) as avg,max(sal),min(sal),count(*) as cnt 
from emp e join dept d
on e.deptno = d.deptno
group by d.deptno,d.dname;

--2) emp 테이블과 dept 테이블을 사용해서
--부서번호, 부서이름, 사번, 이름, 직책(job), 급여을 출력.
--단, 모든 부서가 출력되어야 함.
--(결과 예시)
--deptno  dname           empno   ename   sal
-----------------------------------------------
--10	ACCOUNTING	7782	CLARK	2450
--...
--40	OPERATIONS	

--ORACLE METHOD 
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d, emp e 
where d.deptno = e.deptno (+);

--ANSI Method 
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d right join emp e
on d.deptno = e.deptno;

-- Teacher's Solution 
-- 단, 모든 부서가 출력되어야 함.> outerjoin (left or right join) 
select d.deptno, d.dname,e.empno,e.ename,e.job,e.sal 
from dept d, emp e
;
-- 이렇게하면 모든 경우의 수를 나타냄, 그래서 where 이 필요 
select d.deptno, d.dname,e.empno,e.ename,e.job,e.sal 
from dept d, emp e
where d.deptno = e.deptno (+)
;

-- ANSI Method 
select d.deptno, d.dname,e.empno,e.ename,e.job,e.sal 
from dept d left join emp e
on d.deptno = e.deptno 
;

--3) emp, dept, salgrade 테이블에서
--부서번호, 부서이름, 사번, 이름, 매니저사번, 매니저 이름, 급여, 급여 등급을 출력.
--단, 모든 부서와 모든 사원이 출력되어야 함. 부서번호 오름차순 출력.
--(결과 예시)
--deptno  dname           empno   ename   mgr    mgr_name sal    grade
----------------------------------------------------------------------
--10	ACCOUNTING	7934	MILLER	7782	CLARK	1300	2
--10	ACCOUNTING	7839	KING			5000	5
--...
--40	OPERATIONS						

-- ORACLE METHOD 
select e.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e2.ename as mgr_name, e1.sal,s.grade
from emp e1,emp e2, dept d, salgrade s 
where e.deptno (+) = d.deptno 
union 
select e.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e2.ename as mgr_name, e1.sal,s.grade
from emp e1,emp e2, dept d, salgrade s 
where e1.mgr = e2.empno 
union
select e.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e2.ename as mgr_name, e1.sal,s.grade
from emp e1,emp e2, dept d, salgrade s 
where e1.sal between s.losal and s.hisal
order by deptno asc;

-- Teacher's solution 
select d.deptno, d.dname, 
       e1.empno,e1.ename,e1.mgr,
       e2.ename as mgr_name, 
       e1.sal, s.grade
from dept d, emp e1, emp e2, salgrade s
where d.deptno = e1.deptno(+)
    and e1.mgr = e2.empno (+)
    and e1.sal between s.losal(+) and s.hisal(+)
order by deptno asc;
-- 원래 왼쪽의 테이블의 값들이 그대로 남아있어야하므로, 이어서도 left join 
-- 왼쪽에 숫자를 맞추면서 오른쪽에 테이블을 추가 

--ANSI METHOD 
select d.deptno, d.dname, 
       e1.empno,e1.ename,e1.mgr,
       e2.ename as mgr_name, 
       e1.sal, s.grade
from dept d left join emp e1
on d.deptno = e1.deptno
    left join emp e2
    on e1.mgr = e2.empno  
    left join salgrade s
    on e1.sal between s.losal and s.hisal;
-- join & on 사이에는 , 가 없다 
 


