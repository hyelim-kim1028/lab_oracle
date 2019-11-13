/*UPDATE and DELETE/ ���ڵ� ����,����*/

select * from ex_emp3;
-- emp�� �״�� �����ߴ� ���̺� 
-- from ex_emp3 table, please change the salary of an employee whose empno is 7369 to 2000
update ex_emp3 
set sal = 2000 
where empno = 7369;
select * from ex_emp3;

update ex_emp3 
set sal = 2000, comm = 7000 
where empno = 7369;
select * from ex_emp3;

-- update���忡�� where ���� �����ϸ� ���̺��� ��� ���� �����ϰ� �� 
-- �׷��� ã�� �� �ִ� ���� ���� ������ ������ �����ؾ��� 

update ex_emp3 
set sal = 1234;
select * from ex_emp3;

-- commit�� ������ ���, rollback ���� 
rollback;
select * from ex_emp3;
-- rollback�� ���� Ŀ�� ���·� �����ش� 
-- transaction: commit���� �ϳ��� process�� �Ϸ�Ǵ� �� (transaction������ rollback ����) 
-- commit�ع����� �� �ǵ�����,,,^^ �߱پ�,,,^^ 

-- delete �� ���� ����°� �ƴ϶� �� ��ü�� ����� 
-- ex_emp3 ���̺��� �μ� ��ȣ�� 10���� �������� �����͸� �����ϰڴ� 
delete from ex_emp3 
where deptno = 10;
select * from ex_emp3;

-- ���� cell �ϳ��� �ٲٰڴ� > update > ���� ���� null > update�� null�� �ϸ� �ȴ� 
update ex_emp3 
set deptno=null 
where empno = 7369;
select * from ex_emp3;
-- �����ΰ��� null �� �ٲ� ���� = �� ��������� (i.e. set sth as null > set sth = null), 
-- where ���� null�̴� null�� �ƴϴ� �� ǥ�� �� ���� is/is not null ��� 
-- ���������� not null�̶�� �Ǿ�������, update �� ���� null�� �� �� (���� �ݵ�� �־���Ѵ�!) 
-- delete�� where �� ���ָ� �� �� ��������,,,^0^ 

commit;

-- delete �������� where���� ������� ������ ���̺��� ��� ���� ������! 

-- �������� ex_emp3 ���̺��� 20�� �μ����� ���ϴ� �������� ���� (comm)�� 100���� ���� (�� 1000 ���� ���,,,) 
update ex_emp3 
set comm=1000 
where deptno=20;
select * from ex_emp3;


--SUBQUERY 
--ex_emp3 ���̺��� �޿��� ��պ��� ���� �������� �޿��� 2��� �λ� 
update ex_emp3
set sal = sal*2
where sal < (select avg(sal) from ex_emp3);
select * from ex_emp3;

rollback;
select * from ex_emp3;
select avg(sal) from ex_emp3;
--avg = 1843

update ex_emp3
set sal = sal*2
where sal < (select avg(sal) from ex_emp3);
select * from ex_emp3;

commit; 
