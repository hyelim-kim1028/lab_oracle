-- ALTER table (���̺� ����) 
-- ���̺��� �÷��̸� ���� 
 alter table EX2 rename column ex_id to eid;
 select * from EX2; 
-- ���̺� ������Ÿ�� ���� 
alter table EX2 modify ex_text varchar2(100);
desc EX2; 

-- ���̺� ���ο� �÷� �߰� 
alter table EX2 add ex_date date;
desc EX2;

alter table EX2 drop column ex_date; 

-- ���̺��� ������ �ִ� �÷��� ���� ���� �߰� 
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
-- not null�� �̷��� �ȵȴ�! �ȵȴٰ� ��� ����¥��������!!!!!! �ٸ��� �� �Ǵµ� ������ �ȵȴٱ� 
-- �׷��� check �� �̿��ؼ� ����� ���ƿ� 

alter table EX2 add constraint nn_ex2 check (ex_text is not null);
-- null�� �ִ��� ������ Ȯ���ϴ� �׷� ���������� �����༭ �������ǰɾ������Ӥ� 

-- �÷��� ������ ���� ���� 
alter table EX2 drop constraint nn_ex2;
alter table EX2 drop constraint pk_ex2;

--��䳪��,,, :( 

alter user scott 
identified by tiger account unlock;
-- admin�� user ����� ���氡�� 

-- just for the reference: when making a new account 
create user scott2 identified by tiger;
-- can only be used in a system account 
-- when deleting an account 
drop user scott2;



-- subquery is most used in 'where' clause, but it is also used in select or from as well (just to say it can be used in other clauses as well) 

select sal from emp where ename != 'SCOTT'; 
select avg(sal) from (select sal from emp where ename != 'SCOTT'
);
-- ������ �߰��� ���̴� ������ ���̺� : view 