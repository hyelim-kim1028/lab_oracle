create table customers1(
    customer_id varchar2(20) 
                primary key check (lengthb(customer_id) >= 8),
    customer_pw varchar2(20) 
                not null check (lengthb(customer_pw) >= 8),
    customer_email varchar2(100), 
    customer_gender number(1) 
             check (customer_gender in (0,1,2)and customer_gender = trunc(customer_gender,0)),
    customer_age number(3)
              default 0 check (customer_age between 0 and 200)
);

create table customers1

insert into customers1 (customer_id,customer_pw)
values('admin','admin1234');
--ERROR: ������� ���̵�� 8���� �̻��̿����Ѵ� �� ���� (üũ ��������(SCOTT.SYS_C0011092)�� ����Ǿ����ϴ�)

insert into customers1 (customer_id,customer_pw)
values('admin1234','admin1234');
-- insert ���� (�ι�°�� �������� > ���Ἲ �������� > PK ������ > PK�� ������ �� �̿����Ѵ�) 
select * from customers1;
-- age �� default 0�� ������, �̸��ϰ� ������ ���� insert���� ���� ������ null �� ����Ǿ��� 

insert into customers1 (customer_id,customer_email) 
values ('12345678','test@test.com');
-- ERROR: NULL�� ("SCOTT"."CUSTOMERS1"."CUSTOMER_PW") �ȿ� ������ �� �����ϴ�
-- not null�� ������ ���� password�� ��� 

insert into customers1 (customer_id, customer_pw, customer_gender) 
values ('12345678','pw123456',9);
--ERROR: 9 is not among 0,1,2 which occurs error 

insert into customers1 (customer_id, customer_pw, customer_gender) 
values ('12345678','pw123456',0);

insert into customers1 (customer_id, customer_pw, customer_gender) 
values ('####5678','pw123456',0.1234);
-- ���� ���Ե�����, gender���� �׳� 0���� ����ȴ� 
-- 0.5 ������ 1�� ���� > �׷��� ���ǹ� �� �߰� 1) x=trunc(x,0) 

drop table customers1;
insert into customers1 (customer_id, customer_pw, customer_gender) 
values ('####5678','pw123456',0.1234);

-- customers1 ���̺��� ������ ���� ���� ���� ������ 2�� ���� 
update customers1
set customer_gender=2 
where customer_gender is null;

create table orders2(
order_id number(12),
order_date date default sysdate, 
order_method varchar2(8),
customer_id number(6),
order_status number(2) default 0, 
sales_rep_id number(6), 
constraints pk_oi primary key (order_id), 
constraints ck_method check (order_method in ('direct','online')) 
);

insert into orders2(order_id)
values(1000000);

select * from orders2;

insert into orders2(order_id,customer_id)
values(10000001,123456);

update orders2
set sales_rep_id = 100 
where sales_rep_id is null;

-- implicit cast (������ Ÿ�� ��ȯ) (i.e. 1.1 >1, 1 > 1.0) 


 create table order_items2( 
 order_id number(12), 
 product_id number(10),
 quantity number(4) default 0,
 price number(10), 
constraint pk_oi primary key (order_id, product_id)
); 


