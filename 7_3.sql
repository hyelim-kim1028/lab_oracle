/*1. ���̺� ���� SQL �� �ۼ�
  1) emp ���̺��� �����ؼ� emp2�� ����
  2) dept ���̺��� �����ؼ� dept2�� ����
  3) salgrade ���̺��� �����ؼ� salgrade2�� ����

2. dept2 ���̺� �Ʒ��� ���� �μ� ������ ����ϴ� SQL �� �ۼ�
  deptno  dname   loc
  -----------------------
  50      ORACLE  Seoul
  60      SQL     Jeju
  70      DDL     Pusan
  80      DML     Incheon

3. 2���� ����� �μ����� �ٹ��ϴ� ��� ����(empno, ename, job, mgr, hiredate, sal, comm)�� �����Ӱ� emp2 ���̺� ����ϴ� SQL �� �ۼ�

4. emp2 ���̺��� 20�� �μ����� �ٹ��ϴ� ������� ��� �޿����� ���� �޿��� �޴� ������� 80�� �μ��� �ű�� SQL �� �ۼ�

5. emp2 ���̺��� ����� �߿�, 10�� �μ��� ��� �� �Ի����� ���� ���� ������� �� �ʰ� �Ի��� ������� �޿��� 10% �λ��ϰ�, �μ��� 70������ �̵��ϴ� SQL �� �ۼ�

6. emp2 ���̺��� ����� �� �޿� ����� 5�� ����� �����ϴ� SQL �� �ۼ�

7. ��� �۾� ����� �����ͺ��̽��� ������ ����*/

---1. 
-- 1) emp ���̺��� �����ؼ� emp2�� ����
create table emp2
as (select * from emp);

-- I did not use the parenthesis but it worked, however the teacher put it to make it sure I guess 

select * from ex_emp3;

-- 2) dept ���̺��� �����ؼ� dept2�� ����
create table dept2
as select * from dept;
select * from dept2;

--3) salgrade ���̺��� �����ؼ� salgrade2�� ���� 
create table salgrade2
as select * from salgrade;
select * from salgrade2;

/*2. dept2 ���̺� �Ʒ��� ���� �μ� ������ ����ϴ� SQL �� �ۼ�
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

-- 3. 2���� ����� �μ����� �ٹ��ϴ� ��� ����(empno, ename, job, mgr, hiredate, sal, comm)�� �����Ӱ� emp2 ���̺� ����ϴ� SQL �� �ۼ� 
rollback;
select * from emp2;

insert into emp2 (empno, ename, job, mgr, hiredate, sal, comm,deptno) 
values (7001,'Kim','Developer', 7839,to_date('1997/10/28','YYYY-MM-DD'),4500,1100,50);

-- ���� ��¥�� �Է��ߴµ� �Է��� �Ǿ���, ������ to make sure, it's better t use to_date clause 

insert into emp2 (empno, ename, job, mgr, hiredate, sal, comm,deptno) 
values (7701,'Jung','Developer', 7839,to_date('1994/02/14','YYYY-MM-DD'),3000,null,60);

insert into emp2 (empno, ename, job, mgr, hiredate, sal, comm,deptno) 
values (7007,'June','Analyst', 7839,to_date('1985/06/24','YYYY-MM-DD'),3200,null,70);

insert into emp2 (empno, ename, job, mgr, hiredate, sal, comm,deptno) 
values (7001,'April','Analyst', 7839,to_date('1981/05/31','YYYY-MM-DD'),2975,null,80);

select * from emp2;

commit;

-- 4. emp2 ���̺��� 20�� �μ����� �ٹ��ϴ� ������� ��� �޿����� ���� �޿��� �޴� ������� 80�� �μ��� �ű�� SQL �� �ۼ�
update emp2 
set deptno=80 
where sal> (
      select avg(sal) from emp2 where deptno=20
      ); 

select * from emp2;

-- 5. emp2 ���̺��� ����� �߿�, 10�� �μ��� ��� �� �Ի����� ���� ���� ������� �� �ʰ� �Ի��� ������� �޿��� 10% �λ��ϰ�, 
-- �μ��� 70������ �̵��ϴ� SQL �� �ۼ�

select * from emp2 where deptno=10;
-- hiredate 1982/01/23 

update emp2 
set sal = sal * 1.1 and deptno=70  
where hiredate > (select max(hiredate) from emp2 where deptno = 10); 

----- I was not able to finish from here, the ff are teacher's solution:

update emp2 
set sal = sal * 1.1, deptno=70  
where hiredate > (select max(hiredate) from emp2 where deptno = 10); 

-- �����Ʈ: select �� and�� �ƴϰ� �׳� comma ����! 
-- and�� and������!!!!! 

-- 6. emp2 ���̺��� ����� �� �޿� ����� 5�� ����� �����ϴ� SQL �� �ۼ�

delete e.empno, e.sal, s.grade
from salgrade2 s, emp2 e
where empno = (select empno from emp2 where salgrade between s.minsal and s.hisal);

----- teacher's solution (õõ�� ������ �ȵȵ��,,) 
select e.empno, e.sal, s.grade
from emp2 e join salgrade2 s
on e.sal between s.losal and s.hisal 
where s.grade = 5;


--- �����Բ� ���庸��: "invalid table name" 
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


-- 7. ��� �۾� ����� �����ͺ��̽��� ������ ����
commit; 


-- transaction: all or nothing
-- session: session includes different transactions (not yeb been committed) (���� ����~���� �������) 
-- each process from the beginning up to commit is called a transaction 
-- In order to view a process in other db, the transaction must be finished 
-- commit �� rollback �� Transaction Control Language (not really a DDL) 

-- lock: ������ ���, �������� (���� = manipulate = under the process of dml) �����͸� �ٸ� ������ ������ �� ���� 
-- �� ���� lock (locked a certain row), ���̺� ���� lock (the whole table has been locked) 


