-- ejer 03.01 
-- ���� ���̺��� �μ���ȣ�� 20�� �̰ų� ��å�� ��������� ��� ������ �˻� 
select * from emp where deptno = 20 or job = 'SALESMAN';

-- ���� ���̺��� ��å�� 'CLERK', 'ANALYST' �Ǵ� 'MANAGER'�� ��� 
select * from emp where job = 'CLERK' or job = 'ANALYST' or job = 'MANAGER';
select * from emp where job in ('CLERK', 'ANALYST', 'MANAGER');

-- �� ���̺��� ��å�� clerk, analyst, manager�� �ƴ� �������� ��� ���� �˻� 
select * from emp where job != 'CLERK' or job != 'ANALYST' or job != 'MANAGER';

-- �������� ���� ����ǥ('')�� �ƴ� ū ����ǥ("") ��� 
select empno as "���" from emp;
-- the name of the column changes from empno -> ��� 

-- �߰��� �� ������ �ִ� ��� �ݵ�� ū ����ǥ("") ��� 
select empno as "��� ��ȣ" from emp;

-- ���� 
-- ����Ŭ���� ���ڿ��� �׻� ���� ����ǥ ��� ('') 
-- �÷��� ����(alias)������ ū ����ǥ("") ��� 

-- �Ʒ� �ڵ� ��� ��� ���� 
select empno ��� from emp;
select empno "���" from emp;
select empno as ��� from emp;
select empno as "���" from emp;

-- '%' : �ƹ� ����, �ڸ��� unli, including 0 
-- '_' : �ƹ�����, �ڸ��� = 1 
-- FOR EXAMPLE, 
-- 1) ���� ���̺��� �̸��� 'A'�� �����ϴ� �������� ��� ���� �˻� 
select * from emp where ename like 'A%';
-- A_: ���ڸ� �ۿ� �ȵ� (X ����) 
select * from emp where ename like 'A_';
-- practice: 
select * from emp where job like '_LERK';
select * from emp where job like '%ERK';
select * from emp where job like '%E%';
-- ex) how the search engines work �߱��� > LA ������> %������% �� ���� 

-- NULL!! IS NULL, IS NOT NULL 
select * from emp where comm = null;
-- nothing has been returned 
-- null�� �� �������� ����, Ư���� ������ Ű���� ��� �ؾ��� 
-- null�� ���� ���� ��, = null�ص� ���� ���̶� �������� ���� 
-- ���������, comm = null> ���� �����ϱ� ���� �� ���� 

-- ���� ���̺��� ����(comm)�� null�� �������� ��� ���� �˻� 
select * from emp where comm is null;
-- ���� ���̺��� ����(comm)�� null�� �ƴ� �������� ��� ���� �˻� 
select * from emp where comm is not null;
-- null���� is ��� 

-- ���� ���̺��� ������ �޴� ������ �߿��� �޿��� 1500 �ʰ��ϴ� ������ ���, �̸�, �޿��� �˻� 
select empno, ename, sal from emp where comm is not null and sal > 1500;
-- �򰥸� �� => ��ȣ�� ���ǽ� ��� 
select empno, ename, sal from emp where (comm is not null) and (sal > 1500);
-- ���� ���̺��� ������ ���� �ʴ� ������ �߿��� �޿��� 1500 �ʰ��ϴ� ������ ���, �̸�, �ݿ��� �˻� 
select empno, ename, sal from emp where (comm is null) and (sal >1500);

-- ���� 
-- ������(union), ������(intersect), ������(minus) 
select * from emp where deptno = 10 or deptno = 20;





