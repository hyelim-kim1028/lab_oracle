/*1. 테이블 복사 SQL 문 작성
  1) emp 테이블을 복사해서 emp2를 생성
  2) dept 테이블을 복사해서 dept2를 생성
  3) salgrade 테이블을 복사해서 salgrade2를 생성

2. dept2 테이블에 아래와 같은 부서 정보를 등록하는 SQL 문 작성
  deptno  dname   loc
  -----------------------
  50      ORACLE  Seoul
  60      SQL     Jeju
  70      DDL     Pusan
  80      DML     Incheon

3. 2에서 등록한 부서에서 근무하는 사원 정보(empno, ename, job, mgr, hiredate, sal, comm)를 자유롭게 emp2 테이블에 등록하는 SQL 문 작성

4. emp2 테이블에서 20번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받는 사원들을 80번 부서로 옮기는 SQL 문 작성

5. emp2 테이블의 사원들 중에, 10번 부서의 사원 중 입사일이 가장 늦은 사람보다 더 늦게 입사한 사원들의 급여를 10% 인상하고, 부서를 70번으로 이동하는 SQL 문 작성

6. emp2 테이블의 사원들 중 급여 등급이 5인 사원을 삭제하는 SQL 문 작성

7. 모든 작업 결과를 데이터베이스에 영구히 저장*/

---1. 
-- 1) emp 테이블을 복사해서 emp2를 생성
create table emp2
as (select * from emp);

-- I did not use the parenthesis but it worked, however the teacher put it to make it sure I guess 

select * from ex_emp3;

-- 2) dept 테이블을 복사해서 dept2를 생성
create table dept2
as select * from dept;
select * from dept2;

--3) salgrade 테이블을 복사해서 salgrade2를 생성 
create table salgrade2
as select * from salgrade;
select * from salgrade2;

/*2. dept2 테이블에 아래와 같은 부서 정보를 등록하는 SQL 문 작성
  deptno  dname   loc
  -----------------------
  50      ORACLE  Seoul
  60      SQL     Jeju
  70      DDL     Pusan
  80      DML     Incheon*/

create table dept2 
as select * from dept;
select * from dept2;

insert into dept2 (deptno, dname, loc) 
values (50, 'ORACLE', 'Seoul');

insert into dept2 (deptno, dname, loc) 
values (60, 'SQL', 'Jeju');

insert into dept2 (deptno, dname, loc) 
values (70, 'DDL', 'Pusan');

insert into dept2 (deptno, dname, loc) 
values (80, 'DML', 'Incheon');

select * from dept2;

commit;

-- 3. 2에서 등록한 부서에서 근무하는 사원 정보(empno, ename, job, mgr, hiredate, sal, comm)를 자유롭게 emp2 테이블에 등록하는 SQL 문 작성 
rollback;
select * from emp2;

insert into emp2 (empno, ename, job, mgr, hiredate, sal, comm,deptno) 
values (7001,'Kim','Developer', 7839,to_date('1997/10/28','YYYY-MM-DD'),4500,1100,50);

-- 나는 날짜만 입력했는데 입력이 되었다, 하지만 to make sure, it's better t use to_date clause 

insert into emp2 (empno, ename, job, mgr, hiredate, sal, comm,deptno) 
values (7701,'Jung','Developer', 7839,to_date('1994/02/14','YYYY-MM-DD'),3000,null,60);

insert into emp2 (empno, ename, job, mgr, hiredate, sal, comm,deptno) 
values (7007,'June','Analyst', 7839,to_date('1985/06/24','YYYY-MM-DD'),3200,null,70);

insert into emp2 (empno, ename, job, mgr, hiredate, sal, comm,deptno) 
values (7001,'April','Analyst', 7839,to_date('1981/05/31','YYYY-MM-DD'),2975,null,80);

select * from emp2;

commit;

-- 4. emp2 테이블에서 20번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받는 사원들을 80번 부서로 옮기는 SQL 문 작성
update emp2 
set deptno=80 
where sal> (
      select avg(sal) from emp2 where deptno=20
      ); 

select * from emp2;

-- 5. emp2 테이블의 사원들 중에, 10번 부서의 사원 중 입사일이 가장 늦은 사람보다 더 늦게 입사한 사원들의 급여를 10% 인상하고, 
-- 부서를 70번으로 이동하는 SQL 문 작성

select * from emp2 where deptno=10;
-- hiredate 1982/01/23 

update emp2 
set sal = sal * 1.1 and deptno=70  
where hiredate > (select max(hiredate) from emp2 where deptno = 10); 

----- I was not able to finish from here, the ff are teacher's solution:

update emp2 
set sal = sal * 1.1, deptno=70  
where hiredate > (select max(hiredate) from emp2 where deptno = 10); 

-- 오답노트: select 에 and가 아니고 그냥 comma 였다! 
-- and는 and연산자!!!!! 

-- 6. emp2 테이블의 사원들 중 급여 등급이 5인 사원을 삭제하는 SQL 문 작성

delete e.empno, e.sal, s.grade
from salgrade2 s, emp2 e
where empno = (select empno from emp2 where salgrade between s.minsal and s.hisal);

----- teacher's solution (천천히 생각이 안된드아,,) 
select e.empno, e.sal, s.grade
from emp2 e join salgrade2 s
on e.sal between s.losal and s.hisal 
where s.grade = 5;


--- 선생님께 여쭤보기: "invalid table name" 
delete from emp2 
where empno in (select e.empno 
from emp2 e join salgrade2 s
on e.sal between s.losal and s.hisal 
where s.grade = 5
);

-- different ways to solve the problem (= as the above) 
delete from emp2 where empno in (7839,7001,7007);
delete from emp2 where empno = 7839 or empno = 7001 or empno = 7007;
delete from emp2 where sal between 3001 and 9000;
delete from emp2 where (select losal from salgrade where grade=5) and 9000;


-- 7. 모든 작업 결과를 데이터베이스에 영구히 저장
commit; 


-- transaction: all or nothing
-- session: session includes different transactions (not yeb been committed) (접속 시작~접속 종료까지) 
-- each process from the beginning up to commit is called a transaction 
-- In order to view a process in other db, the transaction must be finished 
-- commit 과 rollback 은 Transaction Control Language (not really a DDL) 

-- lock: 데이터 잠금, 조작중인 (조작 = manipulate = under the process of dml) 데이터를 다른 세션이 조작할 수 없음 
-- 행 레벨 lock (locked a certain row), 테이블 레벨 lock (the whole table has been locked) 


