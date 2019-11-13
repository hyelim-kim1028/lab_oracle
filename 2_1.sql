--���̺��� ������ �˻� 
--1) column ���� �˻� (projection) 
--2) row ���� �˻� (selection) 
-- SQL���忡�� column���� �˻� 
-- select �÷� �̸�1, �÷� �̸� 2, ... from ���̺��̸� 
-- ��� ���̺�(emp) ���� ��� (empno)�� ����̸� (ename)�˻��ϱ� 
select empno, ename from emp;
-- ejer. 01 ������̺��� ���, �̸�, �Ի糯¥, �޿��� �˻� 
select empno, ename, hiredate, sal from emp;
select ename,empno,mgr, deptno from emp;
--* ���̺��� ��� Į���� �˻��ϰ� ���� �� > ***** *��ǥ �ϳ� ���ֱ� (ALL) 
-- select * from table name; 
select * from emp;

-- when we need to print the table out as a document to be presented 
-- select (column name) as  (�����̸�, ... from (���̺� �̸�);
select ename as �̸�, empno 
as ��� from emp;

-- �Ʒ� ó�� �ϸ� ename�� �ٸ��� ���, empno�� �״�� ��� �� 
select ename as �̸�, empno from emp;

select empno, ename, sal from emp;
-- ������ ������� ���ϴ°� �������� �޿��� �ƴ� �����̶��?! �ε� 
-- select sal * 12 as annumalsal from emp;
select sal * 12 as annual_sal from emp;
-- select sal * 12 + comm from emp; �ش��ڵ�� ���� �ȵ�, comm null�� �����Ǿ��ִ� observations���� ��� null�� 
select sal * 12 from emp;
select empno, ename, sal, sal*12 from emp;
--  (��) ������ �ڵ� (�Ʒ�) ������ �ڵ� 
select empno, ename, sal, sal * 12 as ANNUAL_SAL from emp;

-- ejer02. sal ���� comm �̶�� column �� �ִ�. comm �� �޴� ������ 4�� (0�� ����) , ���� Ư¡��, �׵���  salesmen �������� 
-- �޿� + ���ʽ� (�Ŵ� ���� ������ �޴´ٰ� ���� ���� ��) 
select empno, ename, sal, sal * 12 + comm as ANNUAL_SAL from emp;
 --  �ڵ� ���� �ȵ� (comm�� ����Ǿ� ���� �ʰ�, null�� �Ǿ��ִ� �������� �� null�� ��) 
 -- null = ���� �����ϴ�/ 0�� null�� �ٸ���, 0�� ��(0)�� �ֱ� ������ ��� ����������, null�� ��� �Ұ���.  
 
 -- ������̺��� ��å (job)�� �˻� 
 select job from emp;
 --  the results gives 14 observations, however, if you only want to know the number of jobs 
 -- then, we have to delete the repeated ones 
-- �ߺ��� ���� ���� �����ϰ� �˻� 
select distinct job from emp;

select job, deptno from emp;
select distinct job, deptno from emp;
--(������� gdocs�� ����)
 
 select * from emp where deptno = 10;
 select * from emp where sal >=3000;
 select * from emp where sal BETWEEN 1000 AND 2500;