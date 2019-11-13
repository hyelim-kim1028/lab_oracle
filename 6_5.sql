 --JOIN SQL

--ORACLE METHOD of cross join 
select * 
from emp, dept;
-- deptno �׸��� produced deptno_1 : this is because there is another deptno column in both emp table and dept table 
-- to distinguish the two, Oracle produced a deptno_1 column 
-- the total records are 56 > ??? 
-- there 14 in emp and are 4 in dept table, so 56 results mean the return of all possible ����� �� (14*4) 
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
-- ���� �κп� where �� �ƴ� on�� ���ش� (��,,,?) 

-- In oracle method, there is no need for the user to remember the type of join, but the ANSI one has to specify 
-- When the table names are long, we give them an alias to shorten ( from (original table name) _space_ (alias)
select * 
from emp e join dept d 
on e.deptno = d.deptno 
order by e.deptno;
-- the above is the same as the line 45-48 
-- ������ �ѹ� �ָ� ��� �� �������� ����ؾ��Ѵ� :-) 

-- emp table �� dept table���� ���, �̸�, �μ���ȣ, �μ��̸� �� �˻��ϰ� ���� �� 
-- ����Ŭ ��� 
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

-- ERROR! ORA-00918: ���� ���ǰ� �ָ��մϴ�; 00918. 00000 -  "column ambiguously defined"
-- without specifying the table of origin, it occurs an error 

-- emp table �� dept table���� ���, �̸�, �μ���ȣ, �μ��̸� �� �˻��ϰ� ���� �� (��, �޿��� 2000 �̻��� �����) 
-- ����Ŭ ��� 
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
-- ���ʿ��� �ִ� column�� ��� ���̺��� ��ŵ�ص� ���� 

--emp���̺�� salgrade ���̺��� ���, �̸�, �޿�, �޿���� 
-- Oracle Method 
select empno, ename, sal, s.grade
from emp e, salgrade s 
where e.sal between s.losal and s.hisal;

-- In emp table, there was a sal column, but in salgrade table, there were grade, lowsal, highsal 
-- there is no the same column, so let's compare if sal is between high and low sal in the salgrade table 
-- nonquijoin -���ٴٸ��ٰ� �ƴ� ũ���並 refer to �ϴ� ��� 

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
-- emp, dept, salgrade table ���� ���, �̸�, �μ���ȣ, �μ��̸�, �޿�, �޿���� ��� 
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
-- ���̺��� �ΰ� �̻��� �Ǹ� �Ƚù���� ���������� (join-on-join-on ���� ����) 

-- emp table ���� ���, �̸�, �Ŵ������, �Ŵ��� �̸��� ����ϰ� �ʹ� (�ڱ��ڽ� self join) 
-- Oracle method 
select e1.empno, e1.ename,e1.mgr,e2.ename 
from emp e1, emp e2 
where e1.mgr = e2.empno;
-- e1 �� �������� ���� ���� ���̺��� e2��� ���ο� (������ ���� ���̺극�� �Ļ��Ǵ�) ������ �����Ѵ� 

--ANSI method 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1 join emp e2 
on e1. mgr = e2.empno;

-- �������� ǥ�ع������ ���� (����Ŭ��� ���) 
-- ANSI �� �� Ÿ���μ��� ������, �� ��Ȯ�ϴ� 
-- non-equi join (ũ��, �۴�) 
-- outer join (�ܺ�����,,,?): ���� ���̺��� �ִ� ������ ���� ���� �ִ�. �����̳� �����ʿ� �ִ� �͸� Ȥ�� ��� ���� �� �� �̳� 
-- Left (outer) join , right (outer) join 

-- dept table : there are four departments in this company 
-- emp table : if you look at the deptno, there is no deptno.40 appear (it appears in dept table, but no in emp table) 
-- It means there is no one in the department yet (no hired employee) 
-- Are we going to make deptno.40 appear on the joined table or not? 
-- when we want to make deptno.40 appear on emp table where dept40 does not exist > we use the outer join sequel 
-- refer to the notes (written one) 

-- emp table & dept table ���� ���, �̸�, �μ���ȣ, �μ��̸��� ��� 
-- ��, dept ���̺� �ִ� ��� �μ� ������ ��� 
-- Oracle method 
select e.empno, e.ename, d.deptno, d.dname 
from emp e, dept d 
where e.deptno=d.deptno;
-- ���, �̸��� deptno 40�� �������� �ʴ´� ( null) �� �߰�
-- �����ʿ� �ִ� ���θ� ����ϰڴ� (right join) > dept ���� 
-- 40�� �ش�Ǵ°� ���� �͵��� null�� �߰� > ���ʿ� (+)�� �߰� / �������� �������� ���� ��ĭ�� (+) null�̶� �߰����ּ���
select e.empno, e.ename, d.deptno, d.dname 
from emp e, dept d 
where e.deptno (+) =d.deptno;

-- left ����! 
select e.empno, e.ename, d.deptno, d.dname 
from dept d, emp e 
where d.deptno=e.deptno;
-- �� dept �� emp : left join > (+) on the right side 
select e.empno, e.ename, d.deptno, d.dname 
from dept d, emp e 
where d.deptno=e.deptno (+);


--ANSI method 
select e.empno, e.ename, d.deptno, d.dname 
from emp e right join dept d 
on e.deptno = d.deptno;
-- right join: �������� �������� ������ּ��� 

select e.empno, e.ename, d.deptno, d.dname 
from dept d left join emp e
on d.deptno = e.deptno;
-- left join:  ������ �������� ������ּ��� 

--emp table���� ���, �̸�, �Ŵ������, �Ŵ����̸� ��� 
-- Oracle method 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1, emp e2 
where e1.mgr = e2.empno;
-- King (null) �� �����ִ� / e1�� ������ �ȴ� 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1, emp e2 
where e1.mgr = e2.empno(+);
--�޿��ٲٱ� 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1, emp e2 
where e2.empno(+) = e1.mgr;

-- ANSI Method 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1 left join emp e2 
     on e1.mgr = e2.empno;
-- ��ü ��� (king ����); �Ŵ����� �������� �ʴ� king�� ������ �Բ� ��� 
select e1.empno, e1.ename, e1.mgr, e2.ename 
from emp e1 right join emp e2 
     on e1.mgr = e2.empno;
-- �� ������ ����� 21����,,,? + King�� �Ⱥ��� 
-- �߰��� ����� �ڱ� ���� ������ ���� �ʴ� �������� ������ �Բ� ���/ ���� ���� �Ʒ��� �Ĺ谡 ��� �ִ� ������� ������  
-- left join: ���� �ִ� ŷ�� ���̴��� right join: ���� ���ϰ� ���� ������� ���̴��� 
select e1.empno, e1.ename, e2.empno, e2.ename 
from emp e1 right join emp e2 
     on e1.mgr = e2.empno;
-- King�� �ڱ� �ؿ� �Ŵ����� ����, ������̱� ������ 

-- �ٽ��غ��� + �����ϱ� (���ش� �ߴµ�  I want to do it more concretely) 

-- full (outer) join 
-- full joi �� ANSI ����� ������ �ְ�, Oracle ����� ������ ����. (��, oracle �� full join�� �Լ��� ����)
-- ���� left join results + right join results = full join results
select e1.empno, e1.ename, e2.empno, e2.ename 
from emp e1 full join emp e2 
    on e1.mgr = e2.empno;

-- Oracle  method  �� full join �� �Ϸ��� union �����ڸ� ����ؾ� �� 
select e1.empno, e1.ename, e2.empno, e2.ename 
from emp e1, emp e2 where e1.mgr = e2.empno(+) 
union 
select e1.empno, e1.ename, e2.empno, e2.ename 
from emp e1, emp e2 where e1.mgr (+) = e2.empno;
-- oracle ���� ���� �� (+)�ϴ� ����� ���� 
-- ���ʿ� (+) union �ٸ� �ʿ� (+) 

--JOIN ����
--(��� ������ Oracle ��İ� ANSI ��� �ΰ��� SQL ������ �ۼ�.)

--1. scott ���� ���
--1) emp ���̺�� dept ���̺��� ����ؼ�
--�μ���ȣ, �μ��̸�, �� �μ� �������� �޿� ���, �ִ�, �ּҰ�, ������ (������ �Լ���)�� ���.
--�Ҽ����� ���ڸ������� ǥ��.
--(��� ����)
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

-- �� solution (��: �� ����) 
--Oracle Method 
--1. -- dname �� ��� ��� emp������ �����ϱ� ������ �ϴ� ����� ���� 
select deptno,round(avg(sal),1) as avg,max(sal),min(sal),count(*) as cnt 
from emp
group by deptno;
-- select �� �ִ� �ư��� group by���� �־���Ѵ� (���⼭�� deptno) 
-- dept ���̺��� �߰����༭ ���̺� �̸��� �߰����ش� 
select d.deptno,d.dname,round(avg(sal),1) as avg,max(sal),min(sal),count(*) as cnt 
from emp e, dept d
where e.deptno = d.deptno
group by d.deptno,d.dname;
-- deptno �� e�� d ��ο� �ִ� ���̶� �� ������־���ϰ�, �������� uniqe in one table �̶� �����൵ �ȴ� 
-- select �� e.deptno ��� �ߴٸ�, group by ������ e.deptno�� ���� 
-- e.sal,d.dname �� �ٿ��� �ȴ� 
-- count(*) or count(empno) 

--ANSI Method 
select d.deptno,d.dname,round(avg(sal),1) as avg,max(sal),min(sal),count(*) as cnt 
from emp e join dept d
on e.deptno = d.deptno
group by d.deptno,d.dname;

--2) emp ���̺�� dept ���̺��� ����ؼ�
--�μ���ȣ, �μ��̸�, ���, �̸�, ��å(job), �޿��� ���.
--��, ��� �μ��� ��µǾ�� ��.
--(��� ����)
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
-- ��, ��� �μ��� ��µǾ�� ��.> outerjoin (left or right join) 
select d.deptno, d.dname,e.empno,e.ename,e.job,e.sal 
from dept d, emp e
;
-- �̷����ϸ� ��� ����� ���� ��Ÿ��, �׷��� where �� �ʿ� 
select d.deptno, d.dname,e.empno,e.ename,e.job,e.sal 
from dept d, emp e
where d.deptno = e.deptno (+)
;

-- ANSI Method 
select d.deptno, d.dname,e.empno,e.ename,e.job,e.sal 
from dept d left join emp e
on d.deptno = e.deptno 
;

--3) emp, dept, salgrade ���̺���
--�μ���ȣ, �μ��̸�, ���, �̸�, �Ŵ������, �Ŵ��� �̸�, �޿�, �޿� ����� ���.
--��, ��� �μ��� ��� ����� ��µǾ�� ��. �μ���ȣ �������� ���.
--(��� ����)
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
-- ���� ������ ���̺��� ������ �״�� �����־���ϹǷ�, �̾�� left join 
-- ���ʿ� ���ڸ� ���߸鼭 �����ʿ� ���̺��� �߰� 

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
-- join & on ���̿��� , �� ���� 
 


