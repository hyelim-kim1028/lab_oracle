--sql notes-- 
select table_name from user_tables;

--���̺��� �ڷ� Ÿ�� Ȯ��-- 
desc dept; 

-- ����Ŭ �ڷ� Ÿ�� (data type): i.e. NUMBER, VARCHAR2, DATE, etc 
-- number: ����Ÿ�� (��: ��ü �ڸ���, �Ҽ��� �ڸ���) 
-- varchar2 (���ڿ� ����): ���ڿ� (string)/ ���� ���� ���ڿ� (variable-length characters/string) Ÿ�� 
-- ���ڿ��� ���̸� �ִ� ����: �ִ� �� ���� ����~ �����ֱ� 
-- date: �ð�(yy/mm/dd hh/mm/ss) ������ �����ϴ� Ÿ�� 

desc emp;

-- ���̺� ��ü ������ (���ڵ�) ��� 
select * from emp;

select table_name from user_tables;
-- user tables: tables that the user have permission to 
-- these are from hr 
-- received warning from commands below: 
-- ����: ORA-04043: countries ��ü�� �������� �ʽ��ϴ�. 
--desc countries;
--desc departments;
--desc employees;
--select * from countries; 
--select * from departments; 
--select * from employees; 

-- ������ �����ϴ� ���ڵ� �˻� 
-- select (column), .. from (table name) where condition 

-- ��� ���̺��� �μ� ��ȣ�� 10�� ������� ��� �÷��� �˻� 
select * from emp where deptno = 10;

-- ��� ���̺��� �޿��� 2500 �̻��� ��� 
select * from emp where sal >= 2500

-- oracle������ 1000 <= sal < 2000 �̷� ������ ����. 
-- �ΰ��� �ɰ� ���� => 1000 <= sal, sal < 2000 
select * from emp where 1000 <= sal and sal < 2000; 

-- �Ʒ� �� �� ���� �� 
select * from emp where 3000 <= sal and sal <= 5000; 
select * from emp where sal between 3000 and 5000;
-- between A and B == A <= X <= B 
-- but not workable with A <= X < B 
select * from emp where 1000 <= sal and sal < 2000; 

-- ��� ���̺��� �޿��� 1000 ���� �̰ų� �Ǵ� 5000 �̻��� �������� ��� �÷� �˻� 
select * from emp where sal <= 1000 or sal >= 5000; 

-- ��� ���̺��� �μ���ȣ�� 10 Ȥ�� 20�� ��� 
select * from emp where deptno in (10,20);  -- in (��,��,��) �� ����
select * from emp where deptno = 10 or deptno = 20;
-- ERROR IF: deptno = 10 or 20 > �� ���� 

-- ���α׷��� ���� ���ܾ��� �� ������Ѵ� 

-- between A and B vs in (A,B) 
-- the former is a continuous value (������), where the latter is discrete(�񿬼���) 

-- different ways to express 'not' in SQL
-- �μ���ȣ�� 10���� �ƴ� ��� 
select * from emp where deptno != 10;
select * from emp where deptno <> 10;
select * from emp where deptno ^= 10;
select * from emp where not deptno = 10;

-- SQLDeveloper ���� ũ�� ����: ���� > ȯ�漳�� > �۲� 

-- ���� ���̺�, ��å clerk, ��� ���� �˻� 
select * from emp where job = 'CLERK';

-- ���ڿ� �񱳽� ����ǥ�� ������ ('') 
-- ��) keyword, table name, column name ������ �ݵ�� ����ǥ ��� 
select * from emp where job = 'clerk'; 
-- ��� 1�� �ȳ���: clerk�� �빮�ڷ� ����Ǿ� �ֱ� ������ ����� ���� 
-- ����Ŭ���� �����(select, from, where, ...),  ���̺� �̸�, �÷� �̸��� �˾Ƽ� �빮�ڷ� �����ϱ� ������ ��ҹ��ڸ� �������� ����. 
-- ������, ������ ����� ������ ��ҹ��ڸ� �����Ѵ� 

-- ���ڿ��� ũ��� (alphabetical order) ���� 
select * from emp where ename >'D';
select * from emp where ename < 'D';
select * from emp where ename > 'F';
-- ���� FORD�� ���� (FORD�� F���� ŭ) 
select * from emp where ename > 'G';



