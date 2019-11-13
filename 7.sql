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
--ERROR: 사용자의 아이디는 8글자 이상이여야한다 를 위배 (체크 제약조건(SCOTT.SYS_C0011092)이 위배되었습니다)

insert into customers1 (customer_id,customer_pw)
values('admin1234','admin1234');
-- insert 성공 (두번째는 성공못함 > 무결성 제약조건 > PK 때문에 > PK는 유일한 값 이여야한다) 
select * from customers1;
-- age 의 default 0을 제외한, 이메일과 성별과 같이 insert하지 않은 값들은 null 로 저장되었다 

insert into customers1 (customer_id,customer_email) 
values ('12345678','test@test.com');
-- ERROR: NULL을 ("SCOTT"."CUSTOMERS1"."CUSTOMER_PW") 안에 삽입할 수 없습니다
-- not null의 조건을 가진 password가 없어서 

insert into customers1 (customer_id, customer_pw, customer_gender) 
values ('12345678','pw123456',9);
--ERROR: 9 is not among 0,1,2 which occurs error 

insert into customers1 (customer_id, customer_pw, customer_gender) 
values ('12345678','pw123456',0);

insert into customers1 (customer_id, customer_pw, customer_gender) 
values ('####5678','pw123456',0.1234);
-- 행은 삽입되지만, gender값은 그냥 0으로 저장된다 
-- 0.5 했을땐 1로 저장 > 그래서 조건문 더 추가 1) x=trunc(x,0) 

drop table customers1;
insert into customers1 (customer_id, customer_pw, customer_gender) 
values ('####5678','pw123456',0.1234);

-- customers1 테이블에서 성별의 값이 없는 고객의 성별을 2로 변경 
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

-- implicit cast (묵시적 타입 변환) (i.e. 1.1 >1, 1 > 1.0) 


 create table order_items2( 
 order_id number(12), 
 product_id number(10),
 quantity number(4) default 0,
 price number(10), 
constraint pk_oi primary key (order_id, product_id)
); 


