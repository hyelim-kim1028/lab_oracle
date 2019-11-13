/*sql_ex_08txt.txt
1. emp ���̺�� �Ȱ��� ����(�÷��̸�, ������ Ÿ��)�� ���� ���̺��� hw_emp��� �̸����� ����

2. hw_emp ���̺� ���ο� �÷��� �߰�
   �÷� �̸�: etc
   ������ Ÿ��: �ִ� 20 bytes ���� ���� ���ڿ�

3. etc �÷��� 100 bytes���� ���ڿ��� ������ �� �ֵ��� ����

4. etc �÷��� �̸��� remark�� ����

5. emp ���̺��� �����͸� ��� hw_emp�� ����. remark �÷��� ���� ��� null

6. hw_emp ���̺��� empno �÷��� ����Ű ���� ������ �߰�*/

--1. emp ���̺�� �Ȱ��� ����(�÷��̸�, ������ Ÿ��)�� ���� ���̺��� hw_emp��� �̸����� ����
create table hw_emp1
as (select * from emp where 1 != 1);
-- �÷� �̸� + ������ Ÿ���� ���簡 ������, ���� ������ ���簡 ���� �ʴ´� 

--2. hw_emp ���̺� ���ο� �÷��� �߰�
--�÷� �̸�: etc
-- ������ Ÿ��: �ִ� 20 bytes ���� ���� ���ڿ�
alter table hw_emp1 add etc varchar2(20);

select * from hw_emp1;

--3. etc �÷��� 100 bytes���� ���ڿ��� ������ �� �ֵ��� ����
alter table hw_emp1 modify etc varchar2(100);

desc hw_emp1;

--4. etc �÷��� �̸��� remark�� ����
alter table hw_emp1 rename column etc to remark;


--5. emp ���̺��� �����͸� ��� hw_emp1�� ����. remark �÷��� ���� ��� null

-- the below is teacer's solution ( I was not able to understand the problem itself) 
insert into hw_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
select * from emp;
-- column�� ���� emp�� ���߱� ���ؼ� specify the columns as remarks 

select * from hw_emp;

-- remark �� �����Ͱ� ���� ������ ��� null 


--6. hw_emp ���̺��� empno �÷��� ����Ű ���� ������ �߰�
alter table hw_emp1 add constraint pk_empno primary key (empno);


--7. 
drop table hw_emp1;
drop table hw_emp;

