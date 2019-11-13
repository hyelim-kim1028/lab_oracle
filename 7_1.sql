/*1. ���θ����� ������ ������ ������ customers ���̺��� ������� �Ѵ�.
������ ���� ������ ���̺��� ������ ����.
- ���̺� �̸�: customers
- �÷�: customer_id(�� ���̵�, 8 ~ 20 bytes�� ���ڿ�)
        customer_pw(�� ��й�ȣ, 8 ~ 20 bytes�� ���ڿ�)
        customer_email(�� �̸���, 100 bytes���� ������ ���ڿ�)
        customer_gender(�� ����, 1�ڸ� ����)
        customer_age(�� ����, 3�ڸ� ����)
- ���� ����: PK�� customer_id
             customer_pw�� not null
             customer_gender�� 0, 1, 2 �� �ϳ��� ����
             customer_age�� 0 ~ 200���� ����, �⺻���� 0


2. ���θ����� ����� �ֹ�(orders) ���̺��� ������� �Ѵ�.
������ ���� ������ ���̺��� ������ ����.
- ���̺� �̸�: orders
- �÷�: order_id(�ֹ� ��ȣ, 12�ڸ� ����)
        order_date(�ֹ� ��¥)
        order_method(�ֹ� ���, 8����Ʈ ���ڿ�)
        customer_id(�ֹ� �� ���̵�, 6�ڸ� ����)
        order_status(�ֹ� ����, 2�ڸ� ����)
        sales_rep_id(�Ǹ� ��� ���̵�, 6�ڸ� ����)
- ��������: PK�� order_id
            order_date�� ���� �ð�
            order_method�� 'direct', 'online'�� �Է� ����
            order_status �⺻���� 0

3. ���θ����� ���� �ֹ��� ��ǰ ������ �����ϴ� order_items ���̺��� ������� �Ѵ�. ������ ���� ������ ���̺��� ������ ����*/

--1. 
create table customers3(
    customer_id varchar2(20) 
        constraints pk_customer_id primary key 
        constraint length_customer_id check (length(customer_id) >= 8),
    customer_pw varchar2(20) 
        constraint length_customer_pw check (length(customer_pw) >= 8)
        constraints nn_customer_pw not null,
    customer_email varchar2(100), 
    customer_gender number(1)
        constraints customer_gender_int (customer_gender in (0,1,2),
    customer_age number(3) default 0 
        constraints c_customer_age check age between 0 and 200
);



--2. 
create table orders(
order_id number(12),
order_date date, 
order_method varchar2(8),
customer_id number(6),
order_status number(2), 
sales rep_id number(6) 
constraints order_id primary key, 
constraints order_date default sysdate,
constraints order_method in ('direct','online'), 
constraints order_status default 0,
);

--3. 
 create table order_items( 
 order_id number (12), 
 product_id number (10),
 quantity number (4),
 price number (10) 
constraints pk_order_items primary key (order_id, product_id),
constraints quantity default 0,
constraints fk_order_items references order_id foreign key orders(order_id) 
); 

----------------------- Teacher's Solution 

--1. customers 1 & customers 2 
-- customers 1 table
create table customers1(
    customer_id varchar2(20) 
                primary key check (lengthb(customer_id) >= 8),
    customer_pw varchar2(20) 
                not null check (lengthb(customer_pw) >= 8),
    customer_email varchar2(100), 
    customer_gender number(1) 
             check (customer_gender in (0,1,2)),
    customer_age number(3)
              default 0 check (customer_age between 0 and 200)
);



-- check (customer_gender in (0,1,2)), �̰͵� ����! check (customer_gender between 0 and 2),
-- When there is both default and constraints, prioritize the default
-- check (customer_age between 0 and 200) ���⿡�ٰ� constraints ���̸� Ʋ����. constraints �� ������ ���� �̸��� �پ�� �ϴ� 


-- �̹� ������� ���̺� ���ֱ� :-) 
drop table customers2;
drop table customers;

create table customers2(
    customer_id varchar2(20) 
                constraint pk01 primary key
                constraint ck01 check (lengthb(customer_id) >= 8),
    customer_pw varchar2(20) 
                constraint nn_1 not null 
                constraint ck02 check (lengthb(customer_pw) >= 8),
    customer_email varchar2(100), 
    customer_gender number(1) 
             constraint ck03 check (customer_gender in (0,1,2)),
    customer_age number(3)
              default 0 constraint ck04 check (customer_age between 0 and 200)
              );

drop table customers2;
drop table customers1;


create table customers3(
    customer_id     varchar2(20), 
    customer_pw     varchar2(20) constraint nn_pw not null, 
    customer_email  varchar2(100), 
    customer_gender number(1),
    customer_age    number(3) default 0, 
    constraint pk_id primary key (customer_id),
    constraint ck_id check (lengthb(customer_id) >= 8),
    constraint ck_pw check (lengthb(customer_id) >= 8),
    constraint ck_gender check (customer_gender in (0,1,2)),
    constraint ck_age check (customer_age between 0 and 200) 
);

-- 124�� ���� column name �ٿ���, ������ 125~128�� �ȿ� ��������Ƿ� �� �ʿ� ���� 
        
------2. 
--2. 
create table orders(
order_id number(12),
order_date date default sysdate, 
order_method varchar2(8),
customer_id number(6),
order_status number(2) default 0, 
sales_rep_id number(6), 
constraints pk_oi primary key (order_id), 
constraints ck_method check (order_method in ('direct','online')) 
);

drop table orders;

create table orders2(
order_id number(12) 
    constraint pk_oi primary key, 
order_date date default sysdate, 
order_method varchar2(8) 
    constraint ck_method check(order_method in ('direct','online')),
customer_id number(6),
order_status number(2) default 0, 
sales_rep_id number(6) 
);

select * from orders2;

-----3
create table order_items( 
 order_id number(12), 
 product_id number(10),
 quantity number(4) default 0,
 price number(10), 
constraint pk_order_items primary key (order_id, product_id)
); 

-- order items table �� record insert 
insert into order_items (order_id, product_id, quantity, price)
values (100000,1,2,1000);

insert into order_items (order_id, product_id, quantity, price) 
values (10000,2,3,1500);

insert into order_items(order_id, product_id, quantity, price) 
values (100001,123,10,10000);

select * from order_items;

-- orders, order_items ���̺��� �ֹ���ȣ, �ֹ���¥, ��ǰ ���̵�, ��ǰ ����, ��ǰ ������ ��ȸ 
select o.order_id, o.order_date,i.product_id, i.quantity, i.price 
from orders2 o join order_itmes i
on o.order_id = i.order_id; 

-- delete  �� ������ �����, ������ ������ �����ִ� ��. ������, truncate�� �ƿ� �߶������ �� 
-- ����: ��Ʈ�� ������ ���찳�� ����� > delete, �� ������ ��ü�� ��������� >  truncate 
-- DML: insert, update, delete, select : �����ڰ� commit�� ��������� �ؾ����� �����ͺ��̽��� ������ ����� > rollback ���� ���� Ŀ�Ի��·� �ǵ��� �� �ִ� 
-- DDL: create, drop,  truncate, alter > �ڵ� Ŀ���� �ȴ�. �ѹ��ϸ� ��, rollback���� �� �츲 

commit;

select * from order_items;
delete from order_items;
-- �� 3����� ������ 
-- select �ص� ��� ���� (���� ������ �ʴ� ������ �����־���) 
rollback;
-- �ٷ� ���� Ŀ�Ե� ���·� �ǵ��ƿ��� 
select * from order_items;
--��ȣȣȣ �ű���� �ǵ��ƿ����� 

truncate table order_items;
select * from order_items;
-- table remains, so we can select but no data remain 
rollback;
select*from order_items;
-- even we did the roll back, still there is no data
-- DDL: automatic commit 

-- ���̺��� ����ٰ� Ŀ������ �ʰ� ���ο� ���� ����� ���� transaction ���̴� ���̺��� automatically commit �� �Ǿ���� 
-- ���߿� ��ġ���� roll back �ص� ������,,, (applies to all DDL) 

drop table ex_emp2;
drop table EX03;
-- drop �ϸ� ��ü�� ���� �׳� ���������,,, 



