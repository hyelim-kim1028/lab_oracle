-- �������� 2 
/* �̰͵� �ּ��̴� ���ۺ��� ������ 
*/ 
-- �̰� �ش� �ٸ� �ּ��̴� 

/*���� ���� �ؿԴ� ���:
-- Method 1
create table tbl_name(
    col_name data_type constraint cost_name cost_content,
    add add...
    col_name data_type default �⺻��
    );*/


    
/* ������ ���� (�÷��� �̸��� ������ Ÿ���� �����ϴ� ��)�� constraint �� ���� �����ϴ� �� 
   Method 2 
create table tbl_name (
    col_name data_type, 
    col_name data_type 
    ..., 
    constraint ���������̸� �������ǳ���1 (���� �÷��� � �������� ���) 
    constraint ���������̸� �������ǳ���2
    ..., (*column ������� �Ƚᵵ �ȴ�) 
- �÷� ���� �Ŀ� ���� ������ ���> */

-- �ι��� ����� not null�� ��� �Ұ� (���� ù��°�� ����) 

/* In Method 2, there is no need to keep the order when writing constraints content, 
   therfore, we need to indicate which column corresponds to which prerequisite. 
   On the other hand in method 1, each line of constraints 
   refer to its line. There is no need for the user to indicate the column name*/

-- Making a table using the method 2

create table ex08(
    col1 number,
    col2 number, 
    constraint pk_ex08 primary key (col1),
    constraint uq_ex08 unique (col2)
);

drop table ex09;

create table ex09(
    col1 varchar2(10),
    constraint nn_ex09 not null(col1));
--Error: "%s: invalid identifier" : not null�� ������ column �̸� ������ 

-- ������� �ߴ� 

-- foreign key command:constraint fk_ex_dept references ex_dept(deptno) 
 
create table ex_emp2(
    empno number constraint pk_ex_emp2 primary key, 
    ename varchar2(20), 
    deptno number(2),
    constraint fk_ex_dept2 foreign key (deptno) references ex_dept(deptno)
    );


create table ex_emp2(
    empno number constraint pk_ex_emp2 primary key, 
    ename varchar2(20),
    deptno number(2), 
    constraint fk_ex_dept2 foreign key (deptno) references ex_dept(deptno)
    );

create table ex_emp2(
    empno number constraint pk_ex_emp2 primary key, 
    ename varchar2(20), 
    deptno number(2), 
    constraint fk_ex_dept2 foreign key (deptno) references ex_dept(deptno)
);

-- deptno: column name 
/*  constraint fk_ex_dept2 foreign key (deptno) references ex_dept(deptno) �̰Ŵ� 2nd method �� �� ���� ���*/

 
--�ϳ��� ���̺��� �ΰ� �̻��� �÷��� ��� �ϳ��� PK���� 
create table ex09( 
    col1 number primary key, 
    col2 varchar2(20) primary key 
);

create table ex09(
    col1 number primary key, 
    col2 varchar2(20) primary key 
);
--Error: "table can have only one primary key"/ ���̺��� ���� �Ѱ��� PK�� ���� �� �ֱ� ������ �����߻� 

create table ex09(
    col1 number,
    col2 varchar2(20),
    constraint pk_ex09 primary key (col1,col2)   
);
-- �̷� �� �ΰ��� ������ unique ������ �ȴ� 

insert into ex09 values (1,'a');
insert into ex09 values (1,'b');
-- �ι�° �൵ insert�ȴ�, �ֳ��ϸ� 1a�� 1b�� �ٸ��ϱ� 
insert into ex09 values (2,'a');
-- pair�� ���� �͵��� PK ������ �Ѵ� 

select * from ex09;

-- insert�� �ȵǴ� ���� �� ���� ��� �Ȱ��� �� 
insert into ex09 values (1,'a');

insert into ex09 values (100,null);
insert into ex09 values (100, null);
-- ERROR: ORA-01400: NULL�� ("SCOTT"."EX09"."COL2") �ȿ� ������ �� �����ϴ�. PK�� null�� ���� �� ���� 

select * from ex09;

-- INSERT SELECT CLAUSE 
--  �ٸ� ������ ������ �༮���� �츮 ���̺� �ִ°�,,,? 
-- ������ ���� �߰��ϴ� ��� 
-- �ٸ� ���̺��� select �� ������ ���̺� insert�ϴ� ��� 

-- ������� �ô�: �ؿ��� �ٸ� �� ���� �ٽ� �ö���� 
 
insert into ex_emp2 (empno,ename,deptno) 
select * from emp; 
-- �̷����ϸ� �ȵȴ� (�÷� ������ �� �����ϱ�) 

insert into ex_dept values (30,'�λ��'); 

insert into ex_emp2(empno,ename,deptno) 
select empno, ename, deptno from emp; 
-- ERROR: ���Ἲ ��������(SCOTT.FK_EX_DEPT2)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ� 
-- insert into ex_dept values (30,'�λ��');  add prior to the command 

select * from ex_emp2;


-- Oracle method 
select e.empno, e.ename, e.deptno, d.dname
from ex_emp2 e, ex_dept d 
where e.deptno = d.deptno;    

select e.empno, e.ename, e.deptno, d.dname
from ex_emp2 e join ex_dept d 
on e.deptno = d.deptno;
    
-- ���̺� ����: ���̺��� ������ �� �ٸ� ���̺��� ������ �����͸� �״�� �������� ��� 
-- ����ִ� ���̺� ���� ���� 
-- create ~ as select ���� 
create table ex_emp3 
as select * from emp;

select * from ex_emp3;
-- ���̺� �ִ°� �״�� ���� 

create table ex_emp4 
as select * from emp where deptno=10;
select * from ex_emp4;

create table ex_emp5 
as select * from emp where 1 != 1;
select * from ex_emp5;
--1 != 1 : 1�� 1�� �ٸ���/ �� Ʋ���Ӱž�,,, 

/*�ٸ� �ܺ� ����Ʈ (i.e. ��������) �� �𺧷��۷� ������ ���� �ʹٸ�, 
�޴�>���̺�(���͸���) > ������ Ŭ�� > ������ ����Ʈ (���� ��ġ > ����) > �̸����� / ����Ʈ ��� > ���� / ����Ʈ �� ���� �� ����,,
doc>docx/ xls>xlsx/ ppt>pptx (xml file format)  
*/ 

/* UPDATE table 
*/
    
    
    
    