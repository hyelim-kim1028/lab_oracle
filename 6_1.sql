-- �������� (constraint) 

-- ������ ����� ������ ���̺�鿡 ����� �������� Ȯ�� 
select constraint_name, constraint_type, table_name
from user_constraints;

select table_name from user_tables;

-- ���������� ������ 
-- not null : �ݵ�� ���� �־���ϴ� column 
-- unique: ����Ǵ� ������ �ߺ��Ǿ�� �ȵȴ� (no repeated value) 
-- Primary Key (PK)/����Ű/P:  ���̺��� ������ �Ѱ��� ��(���ڵ�)�� �˻��� �� �ִ� �÷� 
-- Foreign Key (FK)/ �ܷ�Ű,�ܺ�Ű / R:���踦 �ΰ� �ִ� �ٸ� ���̺��� PK 
-- not null, unique > constraint type (C = check?) 
-- check: ����(condition)�� üũ�ϴ� �������� 
--i.e. If we mae a column titled 'age' which cannot have a minus number (negative number) 
-- so we put a condition like age >= 0
-- default: column�� �⺻�� (insert���� �ʾƵ� �ڵ����� ����Ǵ� ��) �� ���� (i.e. �ð��� null, age�� 0 ��) 
-- In constraint type, U stands for unique (it does not appear in desc command) 

create table ex03(
      col1 number unique, 
      col2 varchar2(20) not null 
);

desc ex03;

select * from ex03;
-- �������� Ȯ�� SYS_C0011054	U	EX03/ SYS: system�� �ڵ����� ������� (automatically made by the system) 

insert into ex03 (col1,col2)
values (1,'aaa');

insert into ex03 (col1,col2) 
values (1,'bbb');
-- ERROR: ORA-00001: ���Ἲ ���� ����(SCOTT.SYS_C0011054)�� ����˴ϴ� 
-- because in col1, the condition in unique, it has to be a unique number, but we repeated the col1 > 1 
-- �� (values (1,'aaa'))���� �ȵȴ� (1�� ���⶧���� �� �� �� ����) 

insert into ex03 (col2)
values ('bbb');
-- no hay problema/ un exito con el insert 
-- aunque repite, no hay problema (function sin problema) 

insert into ex03 (col2)
values ('bbb');

select * from ex03;

insert into ex03(col1) 
values (10);
-- ERROR: ORA-01400: NULL�� ("SCOTT"."EX03"."COL2") �ȿ� ������ �� �����ϴ�
-- col2 ���� not null �̹Ƿ�, null�� ���� �� ���� 

commit;

-- ���̺� ���� �� ���� ���ǿ� �̸��� �ִ� ��� 
create table ex04(
    col1 number constraint ex04_unq unique, 
    col2 varchar2 (20) constraint ex04_nn not null
);

-- ��� 
create table ex04(
    col1 number constraint ex04_unq unique, 
    col2 varchar2 (20) constraint ex04_nn not null
);
-- ���������� �̸��� �� ��: constraint (���������̸�:ex04_unq) (�������� ����)
--,�� �ķ��� �÷��� ������ ������ ����, ������ �÷��� �װ� �� �̱� ������ ���� �ʴ´� 

-- ����Ű �����ؼ� ���̺� ������ 
create table ex05(
 col1 number constraint ex05_pk primary key,
 col2 varchar2(10) 
); 
 
 drop table ex05a;
 
 create table ex05(
    col1 number constraint ex05_pk primary key, 
    col2 varchar2(10) 
 );
 

create table ex05a(
 col1 number constraint ex05_pk primary key,
 col2 varchar2(10) 
); 

create table ex05a(
        col1 number constraint ex05a_pk primary key, 
        col2 varchar2(10)
);

desc ex05a;
-- col1 �� PK�� �ƴ϶� not null�̶�� �Ǿ��ִ� 
-- desc������ unique �� �Ⱥ����ְ� null������ ���δ� (nullable?) 

insert into ex05a 
values (1,'abc');
-- insert ���� �� �ι�° ������״��� �ȵȴ� (���Ἲ ���� ����(SCOTT.EX05_PK)�� ����˴ϴ�)
-- PK��� constraint ������ 

select * from ex05a;
 
insert into ex05a (col2)
 values('def');
 -- NULL�� ("SCOTT"."EX05A"."COL1") �ȿ� ������ �� �����ϴ� (PK�� not null + unique) 
 -- col1�� ����� �� ���� 
 
 -- ����: ���� ������ ���ԵǴ� ���ڿ��� ���̰� 8�̻� > �̷��� �� �� üũ�� ��� (�ʼ�����, ���ڱ���, �������� ���� ������ ���ɶ�) 
create table ex06(
 col varchar2(20) constraint ck_ex06 check(length(col) >=8)
 );

drop table ex06;

create table ex06(
        col varchar2(20) constraint ck_ex06 check(length(col) >= 8)
);

desc ex06;
-- only shows nullable or not, but it does not say anything about check 

create table ex06a(
 col varchar2(20) constraint ck_ex06 check(length(col) >=8)
 );

create table ex06a(
    col varchar2(20) constraint ck_ex06a check (length(col) >= 8)
);
 
 insert into ex06 values ('abcdefg');
 --ERROR: üũ ��������(SCOTT.CK_EX06)�� ����Ǿ����ϴ� (less than 8 letters) 
 insert into ex06 values ('abdkejslfj');

-- PK�� �ΰ��� column���� ������ �� ����. (�ȵǼ� �÷� 2���� ���� �ʴ� �̻� ���̺� �ϳ� �� �ϳ��� PK) 

-- Default���� ���� �÷� 
drop table ex07;

create table ex07(
    ex_id number default 0,
    ex_date date default sysdate 
);

create table ex07(
       ex_id number default 0, 
       ex_date date default sysdate
);

create table ex07(
    ex_id number default 0, 
    ex_date date default sysdate
);
    
desc ex07;
-- ������������ ���������� ������, but it is still indicated 

insert into ex07
values (1,to_date ('2019-09-13','yyyy-mm-dd'));

select * from ex07;
-- (��¥�� ����ð��� �ƴѰ��) ��¥�� �Ҷ����� to_date�� ����Ͽ� ���ڿ����ְ� �Է� 

insert into ex07(ex_id) 
values (100);

insert into ex07(ex_id) 
values(100);

select * from ex07;
-- �ð��� default �� ����ð� ���� 

insert into ex07 (ex_date) 
values (sysdate +1);

select * from ex07;

commit;

--foreign key ����� 

drop table ex_dept;

create table ex_dept(
    deptno number(2) constraint pk_ex_dept primary key , 
    dname varchar2(20) 
);

create table ex_dept(
    deptno number(2) constraint pk_ex_dept primary key, 
    dname varchar2(20)
);

drop table ex_emp;

create table ex_emp( 
    empno number(4) constraint pk_ex_emp primary key,
    ename varchar2(20),
    deptno number(2) constraint fk_ex_dept references ex_dept(deptno)
); 

-- foreign key �ֱ�: constraint (alias) references original_table_name(original_column_name)
-- ex_dept ���̺� �����Ͱ� ���� ��� (�μ� ��ȣ�� 1���� ���� ���) 
insert into ex_emp 
values (1001,'����',10);

insert into ex_emp 
values(1001,'����',10);

--ERROR: ���Ἲ ��������(SCOTT.FK_EX_DEPT)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ� 
-- foreign key�� deptno �� ��� 
-- emp�� �� dept �� �����ؾ��ϴµ� (�θ�Ű) - ���� (���,,) 
-- ex_emp���� ex_dept ���̺� �����Ǿ� ���� ���� �μ� ��ȣ�� insert�� �� ����! 
--FK�� ������ ex_emp���̺��� deptno�÷����� null�� ���� 
insert into ex_emp(empno, ename) 
values (1001,'����');
-- Fk�� null�̳� �ƴϾ߸� üũ�ϴ°� �ƴ϶�, �������� ���̺� �ִ��� �����ĸ� Ȯ�� 

insert into ex_emp (empno, ename) 
values(1001,'����');


insert into ex_dept values (10,'������');
insert into ex_dept values (20,'�м���');


insert into ex_emp 
values (2001,'ȫ�浿',10);

insert into ex_emp 
values (2001, 'ȫ�浿',10);

insert into ex_emp 
values (3001,'scott',20);

insert into ex_emp 
values (3001, 'scott', 20);


select * from ex_emp;

-- foreign key �κ��� referred table�� �����Ͱ� �־�� insert �����̰�, 
-- �ƴϸ� ������ �ƴϸ� ���̰ų� 
-- table�� ���� ���� foreign key�� ���� �ʰ�, ���߿� �߰����ش� (alter ���) 

select * from ex_emp;
select * from ex_dept;

commit;

-- check �� ������ �ſ� �پ��ϰ� �� �� �ִ� (where �������� ��� �� ó��) 

