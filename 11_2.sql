-- 09.17.2019 EXERCISE 
/*1) ��ü ������ �޿� ��պ��� ���� �޿��� �޴� �������� �̸��� ����ϴ� PL/SQL 
  2) 10�� �μ�����, 10�� �μ� �������� �޿� ��պ��� ���� �޿��� �޴� �������� �̸��� 
  3) �� �μ�����, �� �μ� �������� �޿� ��պ��� ���� �޿��� �޴� �������� �μ���ȣ�� ���� �̸��� ����ϴ� PL/SQL
    (select avg(sal) from emp)
  */
 
declare 
    cursor my_cursor is (
    select * from emp where sal < (select avg(sal) from emp)) 
    );

  v_row emp%rowtype;   
  
begin
    open my_cursor;
    loop 
    fetch my_cursor into v_row;
    exit when my_cursor%notfound;
    dbms_output.put_line(v_row.deptno||' , '||
                         v_row.empno||' , '||
                         v_row.ename||' , '||
                         v_row.sal);
    end loop; 
    
    close my_cursor;

end;
/


-- Teacher's Solution 

declare 
    cursor my_cursor is (
    select ename from emp where sal < (select avg(sal) from emp) 
    );
   
begin
    for result in my_cursor loop 
    dbms_output.put_line(result.ename);
    end loop; 
        
end;
/

-- parameter(�Ű�����)�� ���� Ŀ�� ���� 
-- cursor Ŀ���̸�(���� Ÿ��, ���� Ÿ��, ... ) is SQL ����; 
--                > �Ķ���Ͱ� ���� �ڸ� 

declare 
    v_avg number;
    --cursor my_cursor is 
      --  select ename from emp where sal < ?;
    cursor my_cursor(p_avg number) is 
      select ename from emp where sal < p_avg;
      -- p_avg parameter average
      -- my_cursor(p_avg number) ~ my_cursor has a parameter average 
      -- average  �� ã�ƾ� average �� ȣ���� �� �־��� �� �ִ� 
    
begin 
    -- ��ü ������ �޿� ����� �˾Ƴ� 
    select avg(sal) into v_avg from emp; 
    dbms_output.put_line(v_avg);
    -- �Ķ���͸� ���� Ŀ���� open/fetch/close 
    for row in my_cursor(v_avg) loop 
    dbms_output.put_line(row.ename);
    end loop; 
    
end;
-- ��Ʈ���� 
/

--2) 

declare 
    cursor my_cursor is (
    select * from emp where deptno = 10 and sal < (select avg(sal) from emp where deptno = 10) 
    );

  v_row emp%rowtype;   
  
begin
    open my_cursor;
    loop 
    fetch my_cursor into v_row;
    exit when my_cursor%notfound;
    dbms_output.put_line(v_row.deptno||' , '||
                         v_row.empno||' , '||
                         v_row.ename||' , '||
                         v_row.sal);
    end loop; 
    
    close my_cursor;

end;
/

-- Teacher's Solution 
declare 
    cursor my_cursor is (
                          select deptno,ename 
                          from emp 
                          where deptno = 10 
                          and 
                          sal < (select avg(sal) from emp where deptno = 10) 
                         );
  
begin    
    for row in my_cursor loop
    dbms_output.put_line(row.deptno||' , '||row.ename);
    end loop; 

end;
/

-- 3) �� �μ�����, �� �μ� �������� �޿� ��պ��� ���� �޿��� �޴� �������� �μ���ȣ�� ���� �̸��� ����ϴ� PL/SQL 
-- VERSION 1 
declare 
    cursor my_cursor is ( 
    select * from emp where sal < (select avg(sal) from emp) 
    );
    

    v_deptno number := 10;
    
begin 
loop 
    v_deptno := 10; 
    for row in my_cursor loop
        dbms_output.put_line(row.deptno||' , '||
                             row.empno||' , '||
                             row.ename||' , '||
                             row.sal);
    end loop; 
    dbms_output.put_line('-------------------');
    v_deptno := v_deptno+10; 
        exit when v_deptno = 50; 
end loop;  
end;
/
-- ERRORS: 
--   ORA-20000: ORU-10027: buffer overflow, limit of 1000000 bytes
-- ORA-06512: "SYS.DBMS_OUTPUT",  32��
-- ORA-06512: "SYS.DBMS_OUTPUT",  97��
-- ORA-06512: "SYS.DBMS_OUTPUT",  112��
-- ORA-06512:  13��
-- 20000. 00000 -  "%s"
-- *Cause:    The stored procedure 'raise_application_error'
--           was called which causes this error to be generated.
-- *Action:   Correct the problem as described in the error message or contact
--           the application administrator or DBA for more information.


-- VERSION 2 
declare 
    v_deptno number;
    v_sal number;
    min_sal number; 
    
    cursor my_cursor is ( 
    select * from emp where sal < (select avg(sal) from emp) 
    );
   
begin 
 
    loop 
        v_deptno := 10; 
            for row in my_cursor loop 
                if v_sal <= min_sal then 
                    v_sal := min_sal(i) 
                        dbms_output.put_line(row.deptno||' , '||
                                             row.empno||' , '||
                                             row.ename||' , '||
                                             row.sal);
            end loop; 
        dbms_output.put_line('-------------------');
            v_deptno := v_deptno+10; 
            exit when v_deptno = 50; 
    end loop;  

end;
/

-- �ȵ� 


-- Teacher's Solution 
-- 2 ���� ���� Ŀ���� 3�� ������ �ȴ� (deptno = 10, 20, 30) 
declare 
    cursor my_cursor is (
                          select deptno,ename 
                          from emp 
                          where deptno = 10 
                          and 
                          sal < (select avg(sal) from emp where deptno = 10) 
                         );
    cursor my_cursor2 is (
                          select deptno,ename 
                          from emp 
                          where deptno = 20 
                          and 
                          sal < (select avg(sal) from emp where deptno = 20) 
                         );
    cursor my_cursor3 is (
                          select deptno,ename 
                          from emp 
                          where deptno = 30 
                          and 
                          sal < (select avg(sal) from emp where deptno = 30) 
                         );
-- ���� �ư���  deptno �� parameter �� �Ǹ� �ȴ� 
begin    
    for row in my_cursor loop
    dbms_output.put_line(row.deptno||' , '||row.ename);
    end loop; 
     for row in my_cursor2 loop
    dbms_output.put_line(row.deptno||' , '||row.ename);
    end loop; 
     for row in my_cursor3 loop
    dbms_output.put_line(row.deptno||' , '||row.ename);
    end loop; 

end;
/

-- Teacher's Solution 2 
declare 
    cursor my_cursor (p_deptno emp.deptno%type) is 
        select deptno, ename from emp 
        where sal < (select avg(sal) from emp where deptno = p_deptno)
        and 
        deptno = p_deptno; 
begin 
for i in 1..30 loop
  for row in my_cursor(i) loop 
        dbms_output.put_line(row.deptno||' , '||row.ename);
  end loop; 
end loop; 
end;
/


-- Teacher's Solution 3 
declare 
 cursor get_deptno is -- Ŀ���߰� 
    select deptno from dept; 
 cursor my_cursor(p_deptno emp.deptno%type) is 
    select deptno, ename from emp 
    where sal <(select avg(sal) from emp where deptno = p_deptno)
    and deptno = p_deptno; 

begin 
    for rslt in get_deptno loop -- �ٱ��� for loop 
    -- dbms_output.put_line(rslt.deptno);
        for row in my_cursor(rslt.deptno) loop 
            dbms_output.put_line(row.deptno||' , '||row.ename);
        end loop;
    end loop;
end;
/

-- �μ��� ����� �˾Ƴ���.. group by �� ���� �ذ� 

select deptno, avg(sal) from emp group by deptno; 

declare 
    cursor cur1 is 
        select deptno, avg(sal) average from emp 
        group by deptno
        order by deptno;
        
begin 
    for r1 in cur1 loop 
        dbms_output.put_line(r1.deptno||' , '||r1.average); -- r1.deptno = ��: r1 �÷��̸�: deptno 
        
    end loop; 

end;
/


-- upgraded version 

select deptno, avg(sal) from emp group by deptno; 

declare 
    cursor cur1 is -- �μ� ��ȣ & �޿��� �˾Ƴ� 
        select deptno, avg(sal) average from emp 
        group by deptno
        order by deptno;
    cursor cur2(p_deptno emp.deptno%type, p_avg number) is  -- �׸��� �� ������ parameter �� �Ѱܼ� ���� 
        select deptno, ename, sal from emp 
        where deptno = p_deptno and sal < p_avg; 
             
begin 
    for r1 in cur1 loop 
      dbms_output.put_line(r1.deptno||' , '||r1.average); -- r1.deptno = ��: r1 �÷��̸�: deptno 
            for r2 in cur2(r1.deptno, r1.average) loop 
                dbms_output.put_line(r2.deptno||' , '||r2.ename||' , '||r2.sal);
        end loop; 
    end loop;
    
end;
/


-- Another version using JOIN 

select deptno dno, avg(sal) average from emp 
group by deptno;
-- the result is a table composed of rows & columns 

select a.dno 
from (select deptno dno, avg(sal) average from emp 
        group by deptno) a; 
-- subquery > we can use the subquery not only in where clause but also in 'from' category 
-- we use the select caluse subquery as a table 

select 
    e.deptno, e.ename,e.sal,a.average 
from emp e 
     join (select deptno, avg(sal) average from emp 
           group by deptno) a 
     on e.deptno = a.deptno
where e.sal < a.average
order by e.deptno;


declare 
    cursor my_cursor is 
        select e.deptno, e.ename,e.sal,a.average 
        from emp e 
             join (select deptno, avg(sal) average from emp 
             group by deptno) a 
        on e.deptno = a.deptno
        where e.sal < a.average
        order by e.deptno;
begin 
    for r in my_cursor loop 
    dbms_output.put_line (r.deptno||' , '||r.ename||' , '||r.sal||' , '||r.average);
    end loop; 
end;
/








