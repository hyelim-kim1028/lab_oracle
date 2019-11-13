--ex 6. 
--(1) �� ����� �ټӳ���� �˾ƺ����� �մϴ�. �Ʒ��� ���� ��µǵ��� SQL�� �ۼ��ϼ���.
--EMONO   ENAME   HIREDATE                YEAR
--7369	SMITH	1980-12-17 00:00:00	38
--7499	ALLEN	1981-02-20 00:00:00	38
--......


select empno, ename, hiredate,   

       to_char(hiredate,'YY') as year
from emp;

--(2) �μ��� ���� ���� �Ի� ��¥�� ����ϴ� SQL�� �ۼ�
--DEPTNO  MIN_HIREDATE
--10	1981-06-09 00:00:00
--20	1980-12-17 00:00:00
--30	1981-02-20 00:00:00
--

select min(hiredate)
from emp
where deptno = 10
union 
select  min(hiredate)
from emp
where deptno = 20
union 
select  min(hiredate)
from emp
where deptno = 30;

-- Problem: no se imprime el deptno 

--(3) 10�� �μ����� �Ի� ��¥�� ���� ���� ������ �μ� ��ȣ, ���, �̸�, �ټӳ���� ����ϴ� SQL�� �ۼ�
--(��� ����)
--10, 7782, CLARK, 38


select deptno, empno, ename, round((to_date(sysdate - hiredate),'year'),0) as Year 
from emp 
where deptno = 10 and hiredate = min(hiredate); 


--
--(4) �� �μ����� �Ի� ��¥�� ���� ���� ������ �μ� ��ȣ, ���, �̸�, �ټӳ���� ����ϴ� PL/SQL�� �ۼ�
--(��� ����)
--10, 7782, CLARK, 38
--20, 7369, SMITH, 38
--30, 7499, ALLEN, 38

select deptno, empno, ename, round(to_date(sysdate - hiredate),'Year') as Year
from emp 
where deptno = 10
union
select deptno, empno, ename, round(to_date(sysdate - hiredate),'Year') as Year
from emp 
where deptno = 20 
union
select deptno, empno, ename, round(to_date(sysdate - hiredate),'Year') as Year
from emp 
where deptno = 30; 
