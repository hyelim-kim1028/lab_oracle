-- HOW TO MAKE A TABLE 
-- there are already existing tables in Scott's account 
-- what are the column variances are about 

drop table ex1;

-- Table making 
create table ex1( 
    ex_id  number,
    ex_text  varchar2(10),
    ex_date  date
);

-- �Ŀ� ������ ������ ���ΰ�ħ���ֱ� 

-- ���̺� ���� (�÷� �̸�, ������ Ÿ��, null����) Ȯ�� 
desc ex1;

-- ���̺� ������(���ڵ�) ����(����) / insert ���� ��� / ����� 
insert into ex1()
values ();
-- insert into table name (the column name) 
-- values(the value for the row)

insert into ex1 (ex_id, ex_text, ex_date) 
values (1,'�ȳ��ϼ���',sysdate);
-- insert caluse does not have much transformations 

-- ���̺� ����� ������(���ڵ�)�� �˻� 
select * from ex1; 


-- ����� ������ �������� 
commit;

insert into ex1 (ex_id, ex_text, ex_date)
values (2,'�޷ո޷�',null);

-- DDL (Data Definition Language) / ������ ���� ��� 
-- Create, alter, drop, truncate �� 
-- DDL ����� ���� ���� �ڵ����� commit�� �� 
-- DML (Data Manipulation Language)/ ������ ���� ���
-- insert, update (abc > abcd),delete (���̺� ��ü�� �ƴϰ� ���� ���ִ� ��)  
-- DML �� �ڵ����� commit�� �̷������ �ʴ´� (commit;) �׷��Ƿ�, DB�� ������ ����ڰ� commmit����� �����ؾ߸� DBMS�� ���������� �ݿ��� 

-- insert basic structure 
insert into ex1 (ex_id, ex_text)
values (2,'�޷ո޷�');
select * from ex1;

insert into ex1 (ex_text, ex_id)
values ('�ؽ�Ʈ', 10);
-- ���� �� ������ ������� �� ���� 
select * from ex1;

-- table�� ��� �÷��� ���� ���� �� �� (��� �÷��� �����͸� ���� �ְ� �ʹٸ�, �����ص� �ȴ�.) 
-- insert into �������� �÷� �̸��� ������ �� �ִ�
-- ��, values�� ���̺��� �÷� ������ ��ġ���Ѽ� ��� ���� �����ؾ� ��! 
insert into ex1 
values (11,'data',sysdate);
select * from ex1;
-- �� ���� ������ �ſ� �߿��ϴ� (���̺��� ������� ����� �÷� ������ ������) 

-- SOME ERRORS WE CAN FACE 
insert into ex1 values (20);
-- ERROR!  "not enough values" : Since there is no column indicated after the table name, so Oracle expects the user to 
-- insert three variables (as indicated by the original). But here, we have inserted only one (even though right position), so 
-- there is an error 

insert into ex1 values (sysdate,'test',0);
-- ERROR! "inconsistent datatypes: expected %s got %s"/  NUMBER��(��) �ʿ������� DATE�� 
-- So if we do not indicate the column name after the table name, we have to strictly follow the order 

-- ERROR�޽����� ���� �� ���� �޾Ƶ帮�� ������ �ؾ��Ѵ�. ������ Ʋ�ȴ���, ������ ���α׷��� ���ϴ���,,, �׸��� ��ġ�� ����! 
-- DEVELOPE THE PROGRAMMER'S MIND 

insert into ex1 (ex_text) 
values ('����ֳ���?');
-- ERROR! ORA-12899: "SCOTT"."EX1"."EX_TEXT" ���� ���� ���� �ʹ� ŭ(����: 11, �ִ밪: 10) 
-- not a grammatical error, however, we have exceeded our limit (10 byte) 
-- varchar2(10)�� ������ �� �ִ� ���ڿ� ���̸� �ʰ� 


select * from ex1;

commit;
-- commit 1) write the command (commit;) 2) click the botton on the upper middle with DB + green check sign 3) F11 

-- �ι�° ���̺� (�÷� 2��¥��) : EX2 
create table ex2( 
    ex_id number(2),
    ex_text varchar2(5 char)
);

desc ex2;

-- number 2 : �Ҽ����� ���� ���� 1~99 ���� 
-- varchar2: 5 char : byte �� �����ߴ��� �ѱۿ� ������ �� ���� > �׷��� ���ڼ��� ���� 

-- number 2: �Ҽ����� ���� ���� 1~99 ���� 
-- varchar2: 5 char: byte �� �����ߴ��� �ѱۿ� ������ �� ���� �׷��� ���ڼ��� ���� 

insert into ex2 
values (1,'�ȳ��ϼ���');
select * from ex2;

insert into ex2 
values (1,'�ȳ��ϼ���');

commit; 

--ERRORs
insert into ex2(ex_id) values (100);
-- ERROR! �� ���� ���� ������ ��ü �ڸ������� ū ���� ���˴ϴ�.
--- not grammatically wrong, hoever, the number is only allowed upto two digits. 100 is a three digit number 



insert into ex2(ex_text) values ('abcde');
insert into ex2(ex_text) values ('abcdef');
-- ERROR: ���� ���� ���� �ʹ� ŭ(����: 6, �ִ밪: 5) 
-- ������ ���� exceeds what is conditioned 
-- In Korean, CHinese & Japanese > using character number is better than byte setting (but English is better for byte) 

-- insert select /ple �� ����ؼ� �ٸ� ���̺��� �������ų�, �μ�Ʈ�� ������ ������ �� �ִ� 
-- ���� �츮�� ���� �� �� ����,, ����ó�� �����ϸ� �Ӵ뿩,,, (�ý��ۿ��� ������ ���踦 �ξ �ؾ��ϱ� ������) 
-- �ݵ�� ������ ���°� �ƴϴ� 



