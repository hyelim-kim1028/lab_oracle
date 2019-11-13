-- ALTER table (테이블 수정) 
-- 테이블이 컬럼이름 변경 
 alter table EX2 rename column ex_id to eid;
 select * from EX2; 
-- 테이블 데이터타입 변경 
alter table EX2 modify ex_text varchar2(100);
desc EX2; 

-- 테이블에 새로운 컬럼 추가 
alter table EX2 add ex_date date;
desc EX2;

alter table EX2 drop column ex_date; 

-- 테이블이 가지고 있는 컬럼에 제약 조건 추가 
alter table EX2 add constraint pk_ex2 primary key (eid);  
-- ERROR:  "column contains NULL values; cannot alter to NOT NULL" 
-- LOGIC: Primary key cannot have a null > therefore, the existing null prohibits the change 
-- not a grammatical error 

select * from EX2;

update EX2 set eid = 2 where ex_text = 'abcde';
-- or
update EX2 set eid = 2 where eid is null;

select * from EX2;

alter table EX2 add constraint pk_ex2 primary key (eid);  
desc EX2;

alter table EX2 add constraint nn_ex2 not null (ex_text);
-- not null은 이렇게 안된다! 안된다고 계속 말해짜나ㅏㅏㅏ!!!!!! 다른건 다 되는데 낫널은 안된다구 
-- 그럴땐 check 를 이용해서 만들어 보아용 

alter table EX2 add constraint nn_ex2 check (ex_text is not null);
-- null이 있는지 없는지 확인하는 그런 제약조건을 먼저줘서 제약조건걸어버리기ㅣㅣ 

-- 컬럼에 지정된 조건 삭제 
alter table EX2 drop constraint nn_ex2;
alter table EX2 drop constraint pk_ex2;

--사요나라,,, :( 

alter user scott 
identified by tiger account unlock;
-- admin만 user 만들고 변경가능 

-- just for the reference: when making a new account 
create user scott2 identified by tiger;
-- can only be used in a system account 
-- when deleting an account 
drop user scott2;



-- subquery is most used in 'where' clause, but it is also used in select or from as well (just to say it can be used in other clauses as well) 

select sal from emp where ename != 'SCOTT'; 
select avg(sal) from (select sal from emp where ename != 'SCOTT'
);
-- 계산과정 중간에 보이는 가상의 테이블 : view 