--SUBQUERY
-- select  ���� ���� �Ǵٸ� subquery : ���ǹ� �Ӹ� �ƴ϶� �ٸ� ������ ���� 

--BEFORE to find out the manager's name
--����� 7369�� ����� �Ŵ����� ��� 
select mgr
from emp 
where empno=7369;
--�Ŵ��� �̸� �˾Ƴ��� 
select ename 
from emp
where empno=7902;

-- Using the subquery
select ename from emp 
where emp=??;

select ename from emp 
where empno =(
      select mgr from emp where empno = 7369
);

--������ Sub Query 
-- ������� 1�� 

--������ ���� ���� 
-- ������� �������� ������ ���ƿ��� �� 

-- ��� ���̺��� ��� �޿����� �� ���� �޿��� �޴� �����鸸 ��� 

--My Answer 
select empno, avg(sal) 
from emp 
where empo > (
      select avg(sal) from emp where empno > avg(sal));

-- Teacher's Answer 
select 
from emp
where sal>??? ;

select 
from emp
where sal> () ;

select *
from emp
where sal> (
      select avg(sal) from emp 
);
-- subquery ���� ���� ���� emp���� ���� ���� ���Ͽ� ��� 
-- ������: �߰��� �ִ� subquery �� �� 1���� �����ִ� �׷� ��� 

-- primary key: ���� �ߺ����� �ʴ� ��, ���ο� �ִ� �÷� (i.e. empno) 

--Allen ���� Ŀ�̼��� �� ���� �޴� ���� ���� ��� 
select *
from emp 
where comm > (
    select comm from emp where ename = 'ALLEN') ; 
-- subquery: Allen �̶�� ����� �޴� Ŀ�̼��� ã�Ҵ� 
-- �츮�� ���� ���̺��� ������ Ŀ�̼ǰ� �� (null�� ������ �ʴ´�) 
-- ���� ���� ������ �ڵ�, ������ �θ��̶��? (�Ʒ�) ���� �� Ȯ���� �ڵ� /empno��� 
select *
from emp 
where comm > (
    select comm from emp where empno = 7499) ; 

--������ ���� ���� 
-- ���������� ����� �����԰� ���´�. ���� ���� ������: ALL, ANY...��� 

-- �μ� ��ȣ�� 20�� �Ǵ� 30���� �������� ������ ����Ѵ� 
select * 
from emp 
where deptno = 20 or deptno = 30;
-- ���ʿ� �ִ� �ڵ带 ���� �ǹ̷� ������ �� �� �ִ°� in�̶�� ������ �̴� 
select * 
from emp 
where deptno in (20,30);
-- ������ �ΰ� �̻��� �Ͱ� ���Ѵ� > ���������� ���� ������ ���� ���� �;��Ѵ� 
-- �� in (20,30) �ڸ��� ���� ������ �ִ´� in ��� all,any �� �� �� �ִ� 

-- �� �μ����� �޿��� ���� ���� ������ ������ ��� 
select min(sal) from emp group by deptno;
-- �� �μ��� �̴ϸ� ���� �����Ͽ� 
select * from emp where sal in (950,800,1300);

-- ���� �Ʒ��� ���� ����� �ش� (pero del abajo es inefficiente)  

select * 
from emp 
where sal in (
      select min(sal) from emp group by deptno
      );
      
--���� �÷� ���� ���� 
-- in ������ select������ �� �������ν� �� �÷��� �� 

-- �� �񱳿��� �޿� �ּڰ��� �޴� ���� ������ ����ϰ� �ʹ� 
select deptno, min(sal)
from emp 
group by deptno; 
-- �÷��� �ΰ� ����� �� �ְԲ� �������� ����� ���ҵ�, �� �ֵ��� ������ ���ϵ��� ������ 

select * from emp where (deptno,sal) in (
    select deptno, min(sal)
    from emp 
    group by deptno
    ); 
-- �ΰ��� ���ÿ� ���ϴ� ��/ ����: ��Ȯ���� �� ���̱� ���ؼ� 
-- �ֳ��ϸ�, �ּҰ��� ���ϸ�, �� �μ��� �ּӰ����� �ƴ϶� �ٸ� �ߺ��� ���� ���� ���� �ֵ� 
-- ������, ���� ���ÿ� ���Ѵٸ�, (comparing in pair) �ٸ� ������ ���� �ǰ� ��¥ dept ���� ���� ���� ���� ���´� 

-- all, any (�� �ȿ� �ϳ��� �´°� ������), in (�� �ȿ� �ϳ��� �´°� ������) 


-- ���� ������ �� / �ִ� 

select * from emp where (deptno,sal) in (
    select deptno, min(sal)
    from emp 
    group by deptno
    ); 

-- or / any �� Ȥ�� ���� =/>
-- in  �� > �̰ſ����� ��� �Ұ� 

select min(sal) from emp group by deptno; 
--3���� �� from three different departments 
-- then find the employees correspond to these min salaries 
select * from emp 
where sal = any ( 
     select min(sal) from emp group by deptno
); 
-- in������ ��ȣ (=)�� ������, �ű⼭�� ���� ��ȣ ������ �ϴ� ��, ����� 
-- any ��, �� ���� ��ü���� ���ٶ�� �ϴ� �ǹ̴� ����, ���� �ִ� �͵� �߿� �ϳ� ��� �ǹ̸� �ִ� 

-- �Ʒ� ������ A��� �� �� 
select min(sal) from emp group by deptno; 
-- Para conseguir following Phrases en la forma de subquery que lleva la misma meaning: anadir A en (950,800,1300) 
select*from emp where sal in (950,800,1300);
select * from emp where sal = any (950,800,1300);
-- in = =any > �׷� �� any�� ����? in�� ũ��, �۴��� ��ȣ�� �� �� ���� (<,>) 
select * from emp where sal > any (950,800,1300);
-- 950,800,1300 �� �ƹ��ų� ũ�� > 800 ���� ũ�� �ȴ� > 800 �� ��ü population �߿� ���� minimum �̶� 800 ���� ������ �� 
select * from emp where sal = all (950,800,1300);
--False: �������� ������ �ƴ϶� ������ �ȶ�����, �����Ͱ� ������ �ʴ´� 
-- ��: 950,800,1300 ��ο� ���� �����͸� ã���ּ��� > ������ �� ���� 
select * from emp where sal > all (950,800,1300);
-- ��: �� ��� ���� ū ������ > 1300 ���� ū ���� ã�ƾ��Ѵ� 

-- El ejemplo de la combinacion (El subquery) 
select * from emp where sal > all (
         select min(sal) from emp group by deptno
);











