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

create table ex03(
      col1 number unique, 
      col2 varchar2(20) not null 
);





