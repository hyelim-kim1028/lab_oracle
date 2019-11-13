-- Session, Transaction, Lock 
/*SQL ���� 
- DML (Data Manipulation Language): ������ ���� ��� 
- insert, update, delete (can be converted or changed) 
- a change in a row is what oracle calls 'manipulation'
-DDL (Data Definition Language): ������ ���� ��� 
 - ���̺��� ��� ���鲨�� �� ���� ��� 
 - ���� ������/������ �߰�, ����, ���� �� DML,  ������ �װ��� ������ �����, �����ϰ� �����ϴ� ���� DDL 
 - ���̺� ��ü�� ����(create), ����(alter), ����(truncate/to cut & drop/to remove)
 - select is under DQL (Data Query Language) : ������ ����(����) ���
 - commit & rollback : transaction control language: Ʈ������ ���� ��� 
*/

select * from dept2;
-- the data has been committed, thus if it were commanded properly, it must be seen from cmd as well 

update dept2
set loc='����Seoul'
where deptno=50;

-- it hasn't been committed, but i can be seen from sqldeveloper. However, it cannot be seen from cmd (sqlplus)
-- it is only stored in memory not db 

-- �̷��� sqlplus �� sqldeveloper �� ���� ������ ���̰� �ְ�, ���𰡸� �����Ϸ��� �Ϸ��� > lock �� �ɸ��� �� 
-- SQL> update dept2
 -- 2  set dname ' '����Ŭ'
  --3  where deptno = 50;
-- ERROR:
-- ORA-01756: ���� �ο�θ� ������ �ֽʽÿ�
-- �̰� row lock (�� ���ɸ���) 
-- how to solve: do commit 

commit;
-- �ݴ��, developer ���� ���� �ɸ��Ե� (we have changed dname from Oracle to ����Ŭ from sqlplus) 

-- developer������ 50���� �� , plus������ 60���� �� > �׷���, 50���� plus �� access �ȵǰ�, 60���� developer ���� access �ȵ� 

commit;

-- �� �� Ŀ���� �ϸ� ������ �� �� ���� �����͸� ���� 

select * from dept2;

insert into dept2 values (90,'ITWILL','GANGNAM');
select * from dept2;
commit;
-- Ŀ���� ���� ������  developer �� plus �� �����̸�,,, ^^ 

-- table ������ lock�� ���� �ɸ�����? 
-- ������ ���Ǿ� ��� �Ұ� (���� ������) 
-- ��) 10 - accounting - new york �� �����ϰ� �ִٰ�, ���ο� �÷��� �����Ѵٰų�, �ƴϸ� �÷��� ������ Ÿ���� �ٲ۴ٰų� �Ѵٸ� ��ü �÷��� ���� ���� 
-- �׷� ��ɾ ���̺� ������ ���� �ɸ��� 

update dept2 
set loc = '����' 
where deptno = 10;
-- has been updated > and locked > 
select * from dept2;

--it's been changed and now go to cmd 
-- SQL> truncate table dept2;
-- truncate table dept2
--               *
--1�࿡ ����:
--ORA-00054: ���ҽ��� ��� ���̾ NOWAIT�� �����Ǿ��ų� �ð� �ʰ��� �����
-- ���·� ȹ���մϴ�.
 
 -- �൵ ���� �ɷ�������, ���̺� ���� �ɷ��ִ°�. plus ������ ������ �߻����Ѽ� truncate �� �� �ϰ��� 
 -- ���� �ϳ� �ٲ�� �ִ� ���̶� (Ŀ�� ���� ����) 
 
 
 