--������ �Լ� (multi-row function or group function) 
-- �������� ���� �Լ��� argument�� ���޵Ǽ� �ϳ��� ������� ��µǴ� �Լ� 

select sum(sal),round(avg(sal),2),
       max(sal),min(sal),
       variance(sal),stddev(sal) 
from emp;

--��� ����� �޿��� �� �հ�  
--select sum (column name) from (the table to withdraw the data);  
select sum(sal) from emp;
--��� ����� �޿��� ��� 
select avg(sal) from emp;
-- ���ڰ� �ʹ� ũ��, round or trunc 
select round(avg(sal),2) from emp;
--�ִ�, �ּڰ� 
select max(sal),min(sal) from emp;
--�л�
select variance(sal) from emp;
--ǥ������
select stddev(sal) from emp;
--�л�� ǥ�������� ũ�Ⱑ Ŭ���� ��տ��� �ִ� (�׷����� �ϰ� �����ִ�), ũ�Ⱑ �������� ��տ� ������ (�׷����� ���� �ھ��ִ�?) 

-- �������� ������ ���ִ� �Լ� 
--count(����): �������� ������ ����/��ȯ(���� �ش�)���ִ� �Լ� 
select count(*)from emp;
--���� ���� (14) �� �������ش� 
--Ư�� �÷��� �̸��� �� ���� �ֵ� 
select count (empno) from emp;
-- null �� ������ �÷� 
select count(mgr) from emp;
--1���� null���� (King/pres); null�� ������ (count�Լ��� null�� �ƴ� ������ ������ ����)
--�׷��� null���� ��� �ִ����� �˾ƺ� ���� ���� ��� 
select count(comm) from emp;

select count (deptno) from emp;
-- answer:14; �ߺ��� ���� ���� ! ������!!!! 
select count (deptno),count(distinct deptno) from emp;
-- distinct�� ����Ͽ� �ߺ��� ���� �����ƴ�,,,! :  count(distinct ����): �ߺ����� �ʴ� ������ ������ ���� 

select empno, count(empno) from emp;
-- ERROR! ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�/00937. 00000 -  "not a single-group group function"
--�� ����� ���� ������ �޶� > empno�� ���� (column 1���� �� 14���� �ִ� ���) ,  count�� �׷� �Լ� (��� 1��) (�ΰ��� ���ÿ� ��� �Ұ�) 
--(����) ���� ���� ����� ��µǴ� ������ �׷� �Լ��� �Բ� select�� �� ���� (��� ���°� �ٸ��� ������) 

--Max()�� Min()�� ���ڿ�, ����Ʈ Ÿ�Կ��� ��� �� �� �ִ�. 
select max(hiredate),min(hiredate) from emp;
-- max: 1987/05/03, min:1980/12/17
-- ���ݰ� �� ����� ��¥�� max, �������� ���� min > ���ڰ� ũ�� �嶯 
--�ټ� ������ ���� : max(hiredate)�� �̿��ؾ��Ѵ� 

--[order by column]:  ����� ������ �����ش� 
--otfrt by ���� (Į��)�̸� ���Ĺ��; 
-- ���Ĺ��: ��������: descending, ��������: asc
-- order by�� default ���� ����� ���������̶�, ������������ �Ҳ���� ���� ����
select * from emp order by empno desc;
select * from emp order by empno;
select * from emp order by empno asc;
--57&58 �� ���� ����� ���´� 

select * from emp order by deptno;
-- ���� deptno�ȿ����� �� �ȿ��� ������ ������� ���´� 

select * from emp order by deptno asc, empno desc;
-- ������ �������� ������ ������ ��Ű��, �� ���Ľ�Ų ���¿��� �ι�°�� ������ ���� 
-- �μ��ѹ���� ���� > 10�ȿ��� empno desc, 20�ȿ��� empno desc ... 
-- ���ĵ� �� �Ű� ���� ������ �ð��� ���� �ɸ��� (order by �� ����), �ǹ������� ���ĵ��� ���� ���� �޾ƿͼ� ���̽��̳� �ڹٰ��� ���α׷��� ���� �ٽ� ���Ľ�Ų�� 

--30�� �μ� ������� �޿��� �հ�, �ּڰ�, �ִ�, ���, �л�, ǥ������ 
select sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 30;

-- If we include deptno under select, then there will be an error (number invalid)/ "not a single-group group function" 
select deptno,
       sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 30;

-- �ļ�: select 30 as DEPTNO 
select 30 as DEPTNO,
       sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 30;


select 10 as DEPTNO,
       sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 10;

select 20 as DEPTNO,
       sum(sal) as sum,
       max(sal) as max,
       min(sal) as min,
       round(avg(sal),2) as avg,
       round(variance(sal),2) as variance, 
       round(stddev(sal),2) as stddev
from emp
where deptno = 20;


-- �Ȱ��� ����� ���� ���̵��� 'union'���� ��� �ϳ��� ���� �� �ִ� 

select 10 as DEPTNO,
       max(sal) as max,
       min(sal) as min,
       avg(sal) as avg
from emp
where deptno = 10
union
select 20 as DEPTNO,
       max(sal) as max,
       min(sal) as min,
       avg(sal) as avg
from emp
where deptno = 20
union
select 30 as DEPTNO,
       max(sal) as max,
       min(sal) as min,
       avg(sal) as avg
from emp
where deptno = 30;

--��� �׷� �Լ��� �⺻������ null�� �����ϰ� ����� ���� 
select sum(comm),avg(comm) from emp;
-- There is no need to put an additional condition such as "where comm is not null"
-- null �� ���� �Ǵ� ���� ���� ���� �ƴҼ���,,,^^; 
-- ��: null���� sum: 4���� comm, avg: sum for the 4 people/4 

select sum(comm)as sum,avg(comm) as avg1,avg(nvl(comm,0)) as avg2 from emp;
--AVG2 comm of the 4 people/14(everybody) 

--null�� ó���� ������ �߿��ϴ� (������� �κ�) 

--GROUP BY�� ����� ���� 
--����� ���̵鳢�� ���� �� > group by 
select deptno, round(avg(sal),2), max(sal),min(sal)
from emp
group by deptno
order by deptno;

--��å�� �޿� ���, �ּڰ�, �ִ�
select job, round(avg(sal),2) as avg,max(sal),min(sal)
from emp
group by job;

--�Ŵ����� �޿� ��� 
select mgr, round(avg(sal),2) as avg
from emp
group by mgr;

-- select ���� ���� �� �ִ� Į���� > �׷������� Į���� ��밡�� 
select ename, deptno, avg(sal)
from emp 
group by deptno;
-- ERROR! ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
-- 00979. 00000 -  "not a GROUP BY expression"
-- group by ���� ������ ���� ����/Į�� �� select �� �� �����ϴ� (i.e. ename) 

--�μ��� �޿� ��� ���, �� ��� �޿��� 2000�̻��� �μ��� ���  . 
select deptno,avg(sal)
from emp
group by deptno
having avg(sal)>=2000;
-- where �� group by �� ��� �� �� �־���ϴ� �� + �� group �� average
-- having �ڸ��� where �� ����: ERROR! ORA-00933: SQL ��ɾ �ùٸ��� ������� �ʾҽ��ϴ�
--00933. 00000 -  "SQL command not properly ended"
-- �׷��� having! 

-- ���࿡ ~ �Ѵٸ�: ���� > If, having, 
-- having (���� ���� ����� ������ �� ��) (dept/mng�� �޿� ����) 
-- where �׷� ���� �Ŷ��� ��� ���� �� (i.e. ���࿡ mng�� null�� ����� ���� ���� ��) 

-- �Ŵ�����  null�� �ƴ� ������ �߿���, �Ŵ��� ���� ��� �޿� ��� 
select mgr, round(avg(sal),2)
from emp
where mgr is not null
group by mgr;
-- having �� �ᵵ ���� ����� ���´�, ������ where > quita el cell sin mgr primero, 
-- pero si se usa en having > hace la tablada de 7 y quita uno (tarda mas tiempo y inefficiente)

-- �ΰ� �̻��� Į���� ������ �׷��� ���� ��� 
-- �μ���, ��å�� ��� �޿� ��� 
select deptno, job, avg(sal)
from emp
group by deptno, job
order by deptno,job;

select deptno, job, avg(sal)
from emp
group by deptno,job
order by deptno,job;
-- �� ������ ������, ǥ�� ������ �޶����� 

--1)�μ���ȣ, �μ��� ��� �޿�, �μ��� �ְ�/�ּ� �޿�, ����� 
--�μ���ȣ ������������ ���. �Ҽ����� �ݿø��ؼ� ���ڸ� ������ ��� 
select deptno,round(avg(sal),1) as avg_sal,
       max(sal)as max,min(sal)as min,
       count(empno)as CNT
from emp
group by deptno
order by deptno;

--2)���� ��å�� ���� ������� 3�� �̻��� ��å�� ���ؼ�. ��å�� ������� ��� 

--MY ORIGINAL ANSWER 
select job,count(empno) as EMP#
from emp
where count(empno)>=3
group by job;

-- ERROR 1: ORA-00934: �׷� �Լ��� �㰡���� �ʽ��ϴ�
--          00934. 00000 -  "group function is not allowed here"
-- ERROR2: This is looking for the classification according to JOB not #ofpeople (KNOW_WHAT_IS_ON_THE_CENTER_OF_THE_PROBLEM)

-- After asking the seatmate 
select job,count(empno) as CNT
from emp
group by job
having count(job)>2; 


--Q. �� where �� �ƴϰ� having �ϱ�ФФ̤̤� �� �� �𸣰���,, 
-- �Ƹ�, ����� ���� �����ϱ�, where �� �� ���� (�׷� ���� �����ϱ�) 

-- teacher's solution
select job,count(*) as CNT
from emp
group by job
having count(*)>=3;

--CNT�� ���� > ȭ�鿡 ����ϱ� ���� ������ ��, ��꿡�� ������ ������ �ʴ´� 
-- * is a special expression that is not evaluated, it simply returns the number of rows.

-- �ٵ� �� order by ������ CNT����,,,^^;
-- select���� ���� �÷��� ���� (alias)�� having ������ ����� �� ����! 
select job,count(*) as CNT
from emp
group by job
having count(*)>=3
order by CNT;


--3)�Ի� ������ �޿� ���, �޿� �ּ�/�ִ��� ��� 
select to_char(hiredate,'YYYY') as YYYY, 
       avg(sal) as AVG,min(sal) as MIN,max(sal) as MAX, count(*)
from emp
group by to_char(hiredate,'YYYY')
order by YYYY;


--GUESS 
select to_date('hiredate','YYYY'), avg(sal),min(sal),max(sal)
from emp
group by to_date('hiredate','YYYY')
order by to_date('hiredate','YYYY');
-- The original answer was correct on to_char and the rest 


-- 4)�Ի� ������, �μ����� ����� �Ի��ߴ� ���� ��� 
select to_char(hiredate,'YYYY')as YYYY, 
       deptno,count(*)as CNT
from emp
group by to_char(hiredate,'YYYY'), deptno
order by YYYY, deptno;

--5)����(comm)�� �޴� �������� ���� �ʴ� �������� ��� 
select comm,count(*)
from emp
group by comm
having nvl(comm,0);


--Teacher's Answer 
select nvl2(comm,'y','n') as COMM2,count(*)as CNT
from emp
group by nvl2(comm,'y','n');

--SUBQUERY 

