--������ �����ϴ� ���ڵ� �˻� 
--select (column), ... from (table name) where (condition)

--��� ���̺��� �μ� ��ȣ�� 10�� ������� ��� �÷��� �˻� 
select * from emp where deptno = 10;

--��� ���̺��� �޿䰡 2500 �̻��� ��� 
select * from emp where sal>=2500;

--oracle������ 1000<=sal<2000 �̷� ������ ����. �ΰ��� �ɰ� ���� 
--1000<=sal, and sal<2000 
--������̺��� �޿��� 1000 �̻�, 2000 �̸��� �������� ��� �÷��� �˻� 
select * from emp where 1000 <= sal and sal < 2000;

--�Ʒ� �� �� ���� �� 
select * from emp where 3000 <= sal and sal <= 5000;
select * from emp where sal between 3000 and 5000;
-- between A and B: used for <= & <= combination 
-- but this is different, the combination of <= & < is not workable with 'between...and...' function 
select * from emp where 3000 <= sal and sal < 5000;
-- ��� ���̺��� �޿��� 1000 ���� �̰ų� �Ǵ� 5000 �̻��� �������� ��� �÷� �˻� 
 select * from emp where sal <= 1000 or sal >= 5000;
 
 -- ��� ���̺��� �μ���ȣ�� 10 Ȥ�� 20�� ��� 
 select * from emp where deptno in (10, 20);
 select * from emp where deptno = 10 or deptno = 20;
 -- �̷��� �ϸ� �ȵȴ�: select * from emp where deptno = 10 or 20 > �� �о�� 
 -- ���α׷��� ���� ���ܾ��� �� ������Ѵ� 
 -- in (A,B,C) (or more) is also possible 
 -- between A and B ���� A�� B�� �������� ��. ������ in (A,B)�� �񿬼����ΰ� 

-- �μ���ȣ�� 10���� �ƴ� ��� ( different ways to express 'not' in SQL) 
select * from emp where deptno != 10;
select * from emp where deptno <> 10;
select * from emp where deptno ^= 10;
select *from emp where not deptno = 10;
 
--���� ���̺��� ��å�� clerk �� �������� ��� ������ �˻��� ���ڴ� 
select * from emp where job = 'CLERK';
-- ���ڿ��� �񱳸� �� �� ����('')�� �����־���� 
 -- keyword, table name, column name  �׶�� �Ӵ�,,, 
 select * from emp where job = 'clerk'; 
--�ش� �ڵ�� ����� 1�� �ȳ��� > ���� ����� ���ٴ� ��. ����: clerk �� ���̺��� �빮�ڷ� ����Ǿ����� 
--����Ŭ���� �����(select, from, where, ...),  ���̺� �̸�, �÷� �̸��� ��ҹ��ڸ� �������� �ʽ��ϴ� 
-- ��Ȯ�� �����ڸ�, ����Ŭ�� �̷� �͵��� �빮�ڷ� �����ϱ� ������ �׳� �ڱⰡ �˾Ƽ� �빮�ڷ� �ϴ°���
-- ������ ����� ������ ��ҹ��ڸ� �����մϴ� 

-- ���ڿ��� ũ��� (alphabetical order)
-- ���ڿ��� ũ�� �񱳰� ������. 
select * from emp where ename > 'D';
select * from emp where ename < 'D';
-- select * from emp where ename > 'F'; ���� �� FORD��� �̸��� ���ԵǾ�����? FORD�� F���� ũ�� 
select * from emp where ename > 'G';

--ejer 03.01
-- ���� ���̺��� �μ� ��ȣ�� 20�� �̰ų� ��å�� ������� �� �������� ��� ������ �˻��� ������ 
-- select * from emp where DEPTNO = 20 or JOB = SALESMAN;
select * from emp where deptno = 20 or job = 'SALESMAN';

-- ���� ���̺��� ��å�� 'CLERK'�̰ų� �Ǵ� 'ANALYST' �Ǵ� 'MANAGER' �� ��� 
select * from emp where job = 'CLERK' or job = 'ANALYST' or job='MANAGER';
select * from emp where job in ('CLERK','ANALYST','MANAGER');

--�� ���̺��� ��å��  clerk, analyst, manager�� �ƴ� �������� ��� ���� �˻� 
select * from emp where job = 'CLERK'or job = 'ANALYST' or job= 'MANAGER';
select * from emp where job != 'CLERK' and job != 'ANALYST' and job != 'MANAGER';

--�������� ��������ǥ ('')�� �ƴ� ū ����ǥ ("") ��� 
select empno as "���" from emp;
-- �Ʒ��� ���� ���: �߰��� �� ������ �ִ� �׷� ��쿡�� �ݵ�� ū ����ǥ ��� 
select empno as "��� ��ȣ" from emp;

-- ���� 
-- ����Ŭ���� ���ڿ��� �׻� ���� ����ǥ('')�� ��� 
-- �÷��� ���� (alias) ������ ū����ǥ ("")�� ����� 
select empno ��� from emp;
select empno "���" from emp;
select empno as ��� from emp;
select empno as "���" from emp;

--'%' ��� ���ڰ� �� �� �� �ִ� 
--'_' �ڸ����� �� �ѱ��ڸ� �ƹ� ���ڰ� ��� �� �� �ִ� 
-- FOR EXAMPEL 
-- ���� ���̺��� �̸��� 'A'�� �����ϴ� �������� ��� ���� �˻� 
select * from emp where ename like 'A%';
--%�� ���� �ڸ����� �ƹ� ���ڳ� �͵� �ǰ�, �� ���ڵ� �������; 0���� ����  

select * from emp where ename like 'A_';
--��� ������! A�ڿ� �ƹ� ���ڳ� �͵� ������ �� ���ڸ� �ۿ� �ȵ� > �׷� �̸��� ���̺� �������� ���� 
select * from emp where job like '_LERK';
select * from emp where job like '%ERK';
select * from emp where job like '%E%';
--it works the same for how the search engines work. For instance, �߱��� > LA ������> %������% �� ���� 

--NULL!!! 
-- ���� ���̺��� ������ (comm) null �� ������� ��� ������ �˻�
select * from emp where comm = null;
-- ����� ���� ...��3�� �Ӿ�Ÿ��^ 
-- null�� �� �������� ����, Ư���� ������ Ű���带 ����ؾ��� 
-- null �� Ű���� = ���� ���� 
-- comm = null ���� ���µ� �� �� �� ����/ �񱳴� ���۵� �� �ؿ� 
select * from emp where comm is null;
-- ���� ���̺��� ������ ���� �ƴ� �������� ��� ���� �˻� 
select * from emp where comm is not null;
-- null ���� is ��� 

-- ���� ���̺��� ������ �޴� ������ �߿��� �޿��� 1500 �ʰ��ϴ� ������ ���, �̸�, �ݿ��� �˻� 
select empno, ename, sal from emp where comm is not null and sal>1500;
-- ��ȣ�� ���ǽ��� ����� �� �ִ� 
select empno, ename, sal from emp where (comm is not null) and (sal>1500);
-- ���� ���� ���Ǿ�� �� �� �𸣰ڴٰ� �ǴܵǸ�, �׳� ��ȣ�� ��������󤿤� 

-- ���� ���̺��� ������ ���� �ʴ� ������ �߿��� �޿��� 1500 �ʰ��ϴ� ������ ���, �̸�, �ݿ��� �˻� 
select empno,ename,sal from emp where (comm is null) and (sal>1500);

--����,,, 
-- ������ (union), ������ (intersect), ������ (minus) 
select * from emp where deptno = 10 or deptno = 20;
-- ������/  A: deptno = 10, B: deptno = 10 > ���� ��δϱ� 
-- (�Ʒ�) ���� (��) ���� / ��� ������ ���̴��� ������ 
select * from emp where deptno = 10 
union 
select * from emp where deptno = 20;
-- (��) ���տ����� (union, minus, intersection)�� ��� �� ��, �ΰ��� select ������ ���� �÷����� ���� ������ �˻��ؾ��Ѵ� (����!!) 
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
-- �̸��� 'E'�� �����ϴ� ��� ���� ���� 
select * from emp where ename like '%E%';
-- job�� 'E'�� �����ϴ� ��� ���� ����
select * from emp where job like '%E%';
-- ������ ����� 
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

--30�� �μ����� ���ϴ� ��å�� salesman�� �������� ���, �̸�, �޿�, �μ���ȣ�� �˻��غ��� 
--1.
select empno, ename, sal, deptno from emp where deptno = 30 
intersect
select empno, ename, sal, deptno from emp where job= 'SALESMAN';
--2.
select empno, ename, sal, deptno from emp where deptno = 30 and job= 'SALESMAN';

--20, 30�� �μ����� ���ϴ� ������ �� �޿��� 2000�� �ʰ��ϴ� �������� ���, �̸�, �޿�, �μ���ȣ�� �˻� 
--1.
select empno, ename, sal, deptno from emp where deptno in (20,30) and sal>2000;
--2.
select empno, ename, sal, deptno from emp where (deptno = 20 or deptno = 30) and sal>2000;
-- FAIL: select empno, ename, sal, deptno from emp where deptno = 20 or deptno = 30 and sal>2000;

--������ ���� ������ �߿���, �Ŵ����� �ְ�, ��å�� 'MANAGER' �Ǵ� 'CLERK'�� �������� ��� ������ �˻� 
--1.
select * from emp where (comm is null) and (MGR is not null) and (job = 'MANAGER' or job = 'CLERK');

--2. 
select * from emp
where comm is null
     and MGR is not null 
     and job in ('MANAGER','CLERK');
     
     