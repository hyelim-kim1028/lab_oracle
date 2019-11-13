/*1. 쇼핑몰에서 고객들의 정보를 저장할 customers 테이블을 만들려고 한다.
다음과 같은 구조의 테이블을 생성해 보자.
- 테이블 이름: customers
- 컬럼: customer_id(고객 아이디, 8 ~ 20 bytes의 문자열)
        customer_pw(고객 비밀번호, 8 ~ 20 bytes의 문자열)
        customer_email(고객 이메일, 100 bytes까지 가능한 문자열)
        customer_gender(고객 성별, 1자리 정수)
        customer_age(고객 나이, 3자리 정수)
- 제약 조건: PK는 customer_id
             customer_pw는 not null
             customer_gender는 0, 1, 2 중 하나만 가능
             customer_age는 0 ~ 200까지 가능, 기본값은 0


2. 쇼핑몰에서 사용할 주문(orders) 테이블을 만들려고 한다.
다음과 같은 구조의 테이블을 생성해 보자.
- 테이블 이름: orders
- 컬럼: order_id(주문 번호, 12자리 정수)
        order_date(주문 날짜)
        order_method(주문 방법, 8바이트 문자열)
        customer_id(주문 고객 아이디, 6자리 정수)
        order_status(주문 상태, 2자리 숫자)
        sales_rep_id(판매 사원 아이디, 6자리 정수)
- 제약조건: PK는 order_id
            order_date는 현재 시간
            order_method는 'direct', 'online'만 입력 가능
            order_status 기본값은 0

3. 쇼핑몰에서 고객이 주문한 상품 정보를 저장하는 order_items 테이블을 만들려고 한다. 다음과 같은 구조의 테이블을 생성해 보자*/

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



-- check (customer_gender in (0,1,2)), 이것도 가능! check (customer_gender between 0 and 2),
-- When there is both default and constraints, prioritize the default
-- check (customer_age between 0 and 200) 여기에다가 constraints 붙이면 틀린다. constraints 는 무조건 조건 이름이 붙어야 하다 


-- 이미 만들어진 테이블 없애기 :-) 
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

-- 124는 옆에 column name 붙여줌, 하지만 125~128은 안에 들어있으므로 할 필요 없음 
        
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

-- order items table 에 record insert 
insert into order_items (order_id, product_id, quantity, price)
values (100000,1,2,1000);

insert into order_items (order_id, product_id, quantity, price) 
values (10000,2,3,1500);

insert into order_items(order_id, product_id, quantity, price) 
values (100001,123,10,10000);

select * from order_items;

-- orders, order_items 테이블에서 주문번호, 주문날짜, 상품 아이디, 상품 수량, 상품 가격을 조회 
select o.order_id, o.order_date,i.product_id, i.quantity, i.price 
from orders2 o join order_itmes i
on o.order_id = i.order_id; 

-- delete  은 내용은 지우되, 물리적 공간은 남아있는 것. 하지만, truncate은 아예 잘라버리는 것 
-- 예시: 노트의 내용을 지우개로 지우기 > delete, 그 페이지 자체를 찢어버리기 >  truncate 
-- DML: insert, update, delete, select : 개발자가 commit을 명시적으로 해야지만 데이터베이스에 영구히 저장됨 > rollback 으로 최종 커밋상태로 되돌릴 수 있다 
-- DDL: create, drop,  truncate, alter > 자동 커밋이 된다. 한번하면 끝, rollback으로 못 살림 

commit;

select * from order_items;
delete from order_items;
-- 행 3개모두 삭제됨 
-- select 해도 결과 없음 (눈에 보이지 않는 공간이 남이있어요오) 
rollback;
-- 바로 이전 커밋된 상태로 되돌아오기 
select * from order_items;
--ㅇ호호호 신기허네 되돌아왔으어 

truncate table order_items;
select * from order_items;
-- table remains, so we can select but no data remain 
rollback;
select*from order_items;
-- even we did the roll back, still there is no data
-- DDL: automatic commit 

-- 테이블을 만들다가 커밋하지 않고 새로운 것을 만들면 위에 transaction 중이던 테이블은 automatically commit 이 되어버림 
-- 나중에 고치려고 roll back 해도 빠빠이,,, (applies to all DDL) 

drop table ex_emp2;
drop table EX03;
-- drop 하면 형체도 없이 그냥 사라진거지,,, 



