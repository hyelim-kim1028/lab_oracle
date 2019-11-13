--09.17.2019.Martes 
-- ex33 in teacher's file 
/* Ŀ��(cursor): PL/SQL ���ο��� SQL ������ ó���ϴ� ������ ������ �޸� ����  
When an SQL statement is processed, Oracle creates a memory area known as context area. 
A cursor is a pointer to this context area. 
It contains all information needed for processing the statement. 
In PL/SQL, the context area is controlled by Cursor. 
A cursor contains information on a select statement and the rows of data accessed by it.

A cursor is used to referred to a program to fetch and process the rows returned by the SQL statement, one at a time. 
There are two types of cursors:
Implicit Cursors (������ Ŀ��)
-- ���ٸ� ������� SQL������ ������� �� �ڵ����� ��������� Ŀ�� 
-- ���ٸ��� �Ұ� ����,, 
Explicit Cursors (����� Ŀ��) 
-- �����ڰ� ���� �̸��� �����ϰ� ����ϴ� Ŀ�� 
LINK: https://www.javatpoint.com/pl-sql-cursor


����� Ŀ��: ���� -> open -> fetch -> close 

*/

set serveroutput on;

select * from dept;

begin 
 select * from dept;
 end;
 /
 -- ERROR: �ش� SELECT ���� INTO ���� �ʿ��մϴ�.
 
 declare 
    v_dept dept%rowtype; 
 begin 
    select * into v_dept from dept where deptno = 10; 
-- ����Ŭ DB���ο��� ������ Ŀ���� �ڵ����� ������. (select��� ó�� ����� ������ �ִ� Ŀ���� �ڵ����� �־��� �� > �׷��� v_dept.deptno ���� �� ������� ���°�?)     
    dbms_output.put_line(v_dept.deptno);
end;
/
-- �� �ڵ忡���� ���ν����� ���������� �Ϸ�Ǿ��ٰ� ������ ��, ����� ����� ȭ�鿡 ������ �ʴ´� 
-- dbms... �ϰ� ��¹��� ���� ������߸� ���� 
-- �������� Ŀ���� ���� �������� ������ �� ���� (������ row Ÿ���̴ϱ�, deptnot, dname �� �������� ������ Ÿ���� ������ ������, no se cabe) 
-- �̷� �� ����� Ŀ���� ����� �־���� 


-- select into ������ 1�� �̻��� ��(row)�� select �Ǵ� ���� ����� �� ����. 
-- �̷� ��� ����� Ŀ���� ���������Ѵ� 
-- ����� Ŀ���� select�� ����� ���� ������ ������� ����� �� �ִ�. 
-- Ŀ�� ��� ���: cursor Ŀ���̸� is (SQL ����); 
declare 
-- explicit cursor declaration: 
    cursor my_cursor is(
        select * from dept where deptno = 10 
    ); 
-- when using cursor, no need to use 'into' 
-- in this case, there will be one or no row/ without the where clause, there will be multiple rows returned 
    v_row dept%rowtype; -- Ŀ���� ������ ����(fetch) �� �� ����� ���� 
begin 
    -- open the cursor (Ŀ�� ����, ����, SQL���� ���� )
    open my_cursor;
    -- deptno = 10 �� �ش��ϴ� �޸𸮰� ���� 
    
    -- fetch the cursor (������ �м�/�б�) ����� ������� �о���� ���� 
    fetch my_cursor into v_row;
    -- ����� ��� �б� > ������ �о�´� deptno 10 �� �ش��ϴ� 
    dbms_output.put_line(v_row.deptno||' , '||v_row.dname||' , '||v_row.loc);
    -- close the cursor (�ݱ�)
    close my_cursor;
end;
/


-- close ���� ������ ��� �ؼ� �� ���̰� �޸𸮿� �����ִٰ� ���߿� DB�� ������ ���� �ִ� 


-- ��� ���� 1���� ����� Ŀ�� 
declare 
--(1) Ŀ�� ���� 
 cursor sel_emp is (
    select * from emp where empno = 7788
    ); 
    
    v_row emp%rowtype; 
begin 
    open sel_emp;
    fetch sel_emp into v_row; 
    dbms_output.put_line(v_row.empno||' , '||
                         v_row.ename);
    close sel_emp;
end;
/

-- ��� ���� �������� �� �� �ִ� ����� Ŀ�� 
declare 
-- ����� Ŀ�� ���� 
    cursor sel_dept is (
    select * from dept
    );
-- ���� SQL ������ ���� ���� �� ������ dept ���̺��� ������, �Ѳ����� ������ �� �־���ϱ� ������ �����ϴ� ���� 
-- dept���̺��� row Ÿ�� > ��, v_rows dept%rowtype;  

-- Ŀ�� ���� ����� fetch�� �� ����� ���� 
  v_row dept%rowtype;   
  
begin
    open sel_dept;
    loop 
    fetch sel_dept into v_row;
    exit when sel_dept%notfound;
    dbms_output.put_line(v_row.deptno||' , '||v_row.dname||' , '||v_row.loc);
    end loop; 
        -- ��� ���� �ϳ��� �ƴ϶�, ������ > �� ���� ������ �о���� ���� fetch �Ѵ� ��� ǥ�� 
        -- (���� 1���� �ƴ϶� �������� ���� ���� �ִ�) �ݺ����� �������Ѵ� 
        -- ������ fetch �� �� 1���� �о���� �� > �ݺ��� �ȿ��� ��ġ�Ѵ� 
        -- not found" there is no more data in the db 
        -- select ino �� �������� ���� ���� 
         
    
    close sel_dept;

end;
/

-- emp table ���� deptno = 30 �� �������� ���, �̸�, �޿並 ��� 

declare 
    cursor emp_cursor is (
    select * from emp where deptno = 30
    ); 
    
    v_emp emp%rowtype;
begin 
    open emp_cursor; 
    loop 
     fetch emp_cursor into v_emp;
    exit when emp_cursor%notfound;
    dbms_output.put_line(v_emp.empno||' , '||v_emp.ename||' , '||v_emp.sal); 
    end loop; 
    close emp_cursor; 

end; 
/ 

-- exit �� dbms clause �� �ڸ��� �ٲٸ� ������ ����� �ι� ��µǰ� ������ > ���� 
-- fetch �� ������ DB ���� ���̺� �ִ� ������ ������ ���� �� 
-- not found �����͸� ���� �� �Ŀ� �� �����Ͱ� �ִ��� ������ �˾ƺ��� �� 
-- �׷��� ����� �ϴٰ� not found�� �߻� �������� �ұ��ϰ�, ������ ������ �ϳ� �� ��µȴ� (�������� �����ִ� ���� �ϳ��� ��µǴ� ��) 

-- ���� �ڵ带 ������ ��� ����! 
declare 
    --cursor emp_cursor is (
    --select * from emp where deptno = 30
    --); 
    
    cursor my_cursor is (
        select empno, ename, sal from emp where deptno = 10
    );
    -- �ʿ��� ��Ҹ� �˻��� ����! 
    
    type my_record is record(
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type
        );
        v_row my_record;
    
    -- rowtype  ���� �ʿ��� ��� (empno, ename, sal) ���� �� �پ��� ��ҵ��� �ִ� (sal,com��...) �׷��� ¦�� �� ���� 
    --v_row emp%rowtype;
    -- ERROR: FETCH ���� INTO �׸� ���� ���� �߸��ƽ��ϴ� 
begin 
    open my_cursor; 
    loop 
     fetch my_cursor into v_row;
          exit when my_cursor%notfound;
    dbms_output.put_line(v_row.empno||' , '||v_row.ename||' , '||v_row.sal); 
    end loop; 
    close my_cursor; 
    -- cursor �� ������ �� �̻� �޸𸮴� fetch �� �� ���� : �޸𸮿��� �������Ŵϱ�,,,! 
end; 
/ 

-- ���� loop �� �ƴ϶� while �� ���ٸ�? 
declare 
 
    cursor my_cursor is (
        select empno, ename, sal from emp where deptno = 10
    );
    
    type my_record is record(
        empno  emp.empno%type,
        ename  emp.ename%type,
        sal    emp.sal%type
        );
        v_row my_record;
    
begin 
    open my_cursor;
    
    fetch my_cursor into v_row; 
        while my_cursor%found loop 
            dbms_output.put_line(v_row.empno||' , '||
                                 v_row.ename||' , '||
                                 v_row.sal); 
            fetch my_cursor into v_row;
    end loop; 
    -- %found ������ ���輺: fetch�� ����� fetch�� �غ��� �� �� �ִ� (found or not found) 
    -- fetching is a process of draw data from oracle db 
    
    close my_cursor; 

end; 
/ 

-- ����� Ŀ���� FOR LOOP���� ���
-- open, fetch, close�� �ڵ����� ����� 
-- for ���� in Ŀ�� loop ... end loop; 

declare 
    cursor my_cursor is ( 
    select * from dept 
    );
    
begin 
    for row in my_cursor loop 
        dbms_output.put_line(row.deptno||' , '||row.dname||' , '||row.loc);
    end loop; 

end;
/
-- ��Ʈ���� ���ּ��� (open, close, fetch �� ������ for �� �ϳ��� �������) 
-- ���� ����ߴ� for clause �ʹ� format �� �� �ٸ��� 


-- EJERCICIO 
-- ������� Ŀ���� for loop�� ����ؼ� 
-- 20�� �μ��� �������� ���, �̸�, �޿��� ��� 

declare 
    cursor my_cursor is(
        select * from emp where deptno = 20
    );
    -- ���� ���� SQL ���忡�� ���ҿ� ������ �� ���: select empno, ename name, sal from emp... 
begin 
    for row in my_cursor loop 
        dbms_output.put_line(row.empno||' , '||
                             row.ename||' , '||
                             row.sal);
    -- ���⼭�� row.ename �� �ƴ϶� row.name ���� ������ ���󰣴�    
    end loop; 
end; 
/

