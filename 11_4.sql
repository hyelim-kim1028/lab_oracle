-- 09.18.2019 
-- EX35 in teacher's file 
-- �̸��� �ִ� procedure �� function�� ����� ��� 

/* 
1. �͸�(����) ��� (anonymous block); 
-- �̸��� �������� ���� PL/SQL ��� 
-- �̸��� ���� ������ ����Ŭ ������ ���� �� �� ����. �׷���, ���� �� �� ���� 
-- ��ũ��Ʈ ���� (*.sql) ���� ���� ���� 
-- ������ �ɶ����� ���� ������ > ����ӵ� ���� 

2. ���� ���� ���α׷� (stored sub program):procedure & function 
-- �̸��� �ִ� PL/SQL block 
-- procedure, function (�Լ�), package, trigger 
-- ����Ŭ ������ ����Ǵ� ��ü (object) > table, procedure, function.. (scott �� ������ �� ����Ʈ�� ������ ���̵��� �� ��ü,,,) 
-- ���̺�ó�� ���ν���, �Լ� ���� ���̵鵵 ���� ������ �� �ְ�, 
-- ����� ���̵��� �̸��� �ֱ� ������ �������� �ҷ��� ������ �����ϴ�
-- saved in ORACLE, thus can be reused (REUSABLE) 
-- it is compiled only once when it is saved in ORACLE (����Ŭ ������ ����� �� ������ ��) -> ���� �ӵ��� ���� 

3. ���ν��� (Procedure) 
-- The PL/SQL stored procedure or simply a procedure is a PL/SQL block which performs one or more specific tasks. 
    It is just like procedures in other programming languages. The procedure contains a header and a body.
            - Header: The header contains the name of the procedure and the parameters or variables passed to the procedure.
            - Body: The body contains a declaration section, execution section and exception section similar to a general PL/SQL block.

link: https://www.javatpoint.com/pl-sql-procedure

-- create procedure is also DDL (create, delete...) > review the previous lessons 

create [or replace] procedure ���ν����̸� [( 
    �Ķ����1 [mode] Ÿ��,
    �Ķ����2 [mode] Ÿ��, 
    ...
    
    [mode]: in,out,inout 
); ]

-- [ ] �� �κ��� ���� ���� (�Ķ���� ��������) 
-- [or replace] �� ���� ���� > create procedure OR create or replace procedure 
-- [or replace] ���߿� �̹� ������ ���ν����� ���װ� �־ �����ϰų� ���� �̸��� ����� �����ϰ� ���� �� 

is 
-- PL/SQL�̶� �ٸ���: declare ��� is�� ���� �ִ� 
-- is ���� ����,Ŀ�� ���� 

begin 
-- �����: ���������� ó���� �ڵ��; 

* exception ��� ���� / ���� ���� 
[exception ���� ó����] 

end;
/ 

-- is, begin, end �� ���� ������ �ȵȴ� 
-- is >  [procedure] is [the rest of the code/ begin + exception..] 

*/


set serveroutput on;

-- ���ν��� ���� 
-- parameter �� ����  procedure ����� 
create or replace procedure my_proc1  
is 
    v_empno emp.empno%type := 7788;
    v_ename emp.ename%type; 
begin 
    select ename into v_ename from emp where empno = v_empno;
    dbms_output.put_line('�̸�: '||v_ename);
end;
/

-- create or replace procedure ��� �� ���, �̸��� ������ �׳� �����ϰ�, ������ ���𰡰� ������ �ڵ����� replace �� �Ѵ� 
-- ������ ������ ���ν����� �ִ��� �𸣰� ���÷��̽� �� ��� : ������ : ���� �ִ� ���̰� ������,,,^^ 


-- ��������� ������ ����������� ������ ��Ű�°� �ƴϴ� > �̰� �ٸ� �� (���� O ���� X) 
-- ������ �ٸ� PL/SQL ���� �Ѵ� 

-- ���ν��� ���� 
begin 
    my_proc1(); --  is the same as: my_proc1 

    -- �Ķ���� ���� ���ν����� ������ ���, ��ȣ�� �� ����� 
    -- �Ķ���͸� ���� �ʴ� ���ν����� ȣ���� ���� () �������� 
end;
/
-- ���� �� �츮�� ������ proc1 ���� �����ٰ� �� �� �ִ� 

-- ���ν��� Ȯ�� 
select * from user_source where name = upper('my_proc1');

-- upper�� ����ؼ� �빮�ڷ� �����ش� (����Ŭ�� �빮�ڸ� 4���Ѵ�) > �⺻�� �빮���� ���α׷��� 

-- ���ν��� ���� 
drop procedure my_proc1;

-- DDL�̱� ������ commit�� �ڵ����� �̷������ (= DB������ �������) 


-- �Ķ���͸� ���� ���ν��� ���� 
create or replace procedure my_proc2(
	p_empno emp.empno%type
) 
is 
 v_ename emp.ename%type; 
begin 
    select ename into v_ename from emp where empno = p_empno;
    dbms_output.put_line('name: '||v_ename);
end; 
/ 

-- ������ ���ν��� ���� 
begin 
    my_proc2;
end;
/
-- �̰� procedure �� ���� ���� ��쿡�� ���� 
-- ERROR: 'MY_PROC2' ȣ�� �� �μ��� ������ ������ �߸��Ǿ����ϴ� *Cause:    Usually a PL/SQL compilation error.

begin 
    my_proc2(7839);
    -- 7788: ���ν����� ���ϴ� ���� �־��ֱ� > �츮�� empno > 'name: '||v_ename �̷��� ��� 
end;
/

-- empno ��� ������ �������ν� ename �̶�� ������ ��� > ���⼭ �ָӴ�: parameter�� empno 
-- for loop 1..9999 > �������� exception ó�� 


-- ���ν��� ���� 
declare 
    cursor my_cursor is 
        select empno from emp; 
begin 
    for r in my_cursor loop 
        my_proc2(r.empno); -- r: �÷� empno: �� 
    end loop; 
end;
/

-- ���ν��� �Ķ������ ���(mode) 
-- in/out/inout 
-- in: ���ν��� �������� �����°� : ���ν����� ȣ���� �� ������ ���� �����ϴ� �ŰԺ���(parameter): stored values    
-- out: ���ν��� �ٱ� ������ ������ ��  : ���ν����� ȣ���� ������ ���� ��ȯ�� �� ����ϴ� �ŰԺ��� 
-- inout: ���� ���� �ޱ⵵ �ϰ�, ���� ��ȯ�ϱ⵵ �ϴ� �ŰԺ��� 
-- �Ķ������ �⺻�� in�̶� �������� / out�� inout�� �����Ұ�!!!!!!!! 

create or replace procedure my_proc3(
    -- declare parameter 
    in_empno emp.empno%type, -- in ��� �Ķ���� (���� �޾ƾ߸� �ϴ�) 
    out_ename out emp.ename%type, --out��� �Ķ���� (���� �����ִ� �뵵�� ���)
    out_deptno out emp.deptno%type 
)
-- ; �����ϵ¾ƾƾ�!!!!!!!!!!!
    
is 
-- ����ο� �ڵ尡 ������ is�� �����ϸ� �ȵ�! 
-- �Ķ���Ͱ� ����Ǿ� �ֱ� ������, ������ ���� ������ �ʿ䰡 ���� 
-- �ָӴϿ��� ������ �������� �ǰ���,,, 
begin 
    select ename,deptno into out_ename, out_deptno from emp where empno = in_empno;    
    -- ������ Ŀ�� ����? 
end; 
/

declare 
   v_ename emp.ename%type; 
    v_deptno emp.deptno%type;
begin 
    my_proc3(7788,v_ename,v_deptno);
        -- in mode�� �Ķ���Ϳ��Դ� ���� �ְ�, out mode �� �Ķ���Ϳ��Դ� ������ �༭ ������ ����   
    dbms_output.put_line(v_ename||' , '||v_deptno);
end; 
/
-- 7788 ���� �ڵ�� ���� (in_empno), out �� �������� �ָӴϿ��� ���´� 
-- procedure �� return �� �ƴ϶� parameter �� ���� �̷� process �� ���� 

-- in�� out�� ���ÿ� ���� parameter 

create or replace procedure my_proc4(
    v_number in out number 
)
--     ���� ���޵� �ް�, ���� �����ٰ�,,,?
is 
    
begin 
    v_number := 2* v_number;
    
end;
/

declare 
    v_test number := 10; 
    
begin 
    dbms_output.put_line('Procedure ȣ�� �� v_test = '||v_test);
    my_proc4(v_test); -- ���ν��� ȣ��
    dbms_output.put_line('Procedure ȣ�� �� v_test = '||v_test);
end;
/

-- �⺻���� ���� ���ν����� �Ķ���� > �ָӴϰ� �⺻���� ���� �� �ִ�! (������) 
create or replace procedure my_proc5(
    param1 number,  --�⺻���� �������� ���� �Ķ���� 
    param2 number := 123 --�Ķ���Ϳ� �⺻��(I guess it's the default number) 123 �� �ذ� 
)
is  
        
begin
    dbms_output.put_line(param1||' , '||param2); 
    
end;
/

begin 
   my_proc5(1,2);
   my_proc5(100);
end;
/

drop procedure my_proc7;
drop procedure my_procA;

-- �ι�° ���̴� �ƹ��͵� �Ƚᵵ �׳� ����Ʈ�� ��µȴ� 

--���ν���: get_total_sal 
-- �Ķ���͸� ���´�: 1) p_empno - in ���, ���� Ÿ�� 2) p_total   out��� ����Ÿ�� 3) p_tax in ��� ����Ÿ�� �⺻�� = 0.05 
-- ���: ���޹��� ������� salary�� com�� �˻� 
-- out total = (sal + com) * (1-0.05)   => �� ��ȯ (�Ķ���͸� ���� ��ȯ) 
-- com > null�� ��쿣 0 


create or replace procedure get_total_sal (
    p_empno in     emp.empno%type,
    p_total out  number,
    p_tax   in    number := 0.05
)
is 
  -- emp ���̺��� �ش� ����� �޿�(sal)�� �󿩱��� ������ ���� 
    v_sal emp.sal%type;
    v_comm emp.comm%type;
begin  
    select sal, comm 
    into v_sal, v_comm 
    from emp 
    where empno = p_empno;

    p_total := (v_sal + nvl(v_comm,0)) * (1-p_tax); 
    
        --    dbms_output.put_line('Employee Number'||' , '||p_empno||
        --                         'Tax'||' , '||p_tax||' , '||
        --                         'Salary: '||v_sal||' , '||
        --                         'Comm: '||v_comm||' , '||
        --                         'Total Salary: '||p_total);

end;
/

declare 
-- give variable name to p_total, v_sal & v_comm? 
    v_empno emp.empno%type := 7788;
    v_total number; 
    v_tax number := 0; 
begin 
  get_total_sal(v_empno, v_total, v_tax);
        dbms_output.put_line(v_total);
end;
/



-- ������� ã�°� 
-- �װ� �̿��ؼ� proc �� ���� total�� ������ �ϴ� �� 
-- a. ���޹��� ������� salary�� com�� �˻� > ��Ż�� ������ �ϱ� 










/*
create or replace procedure my_procA(
    -- declare parameter 
    p_empno      emp.empno%type, 
    p_sal   out  emp.sal%type, 
    p_comm  out  emp.comm%type := nvl(comm,0) 
    p_tax   out  number := 0.05 
    p_total out  number := (v_sal + v_com) * (1-p_tax)
)
is 

begin 
    select sal, comm into p_sal,p_comm from emp where empno = p_empno;  
    p_total := (v_sal + v_com) * (1-p_tax); 
    dbms_output.put_line my_procA('empno '||' , '||7788||' total salary'||' , '||p_total||'tax'||' , '||p_tax);
    
end; 
/

begin 
    my_procA(7788,p_total,p_tax); 
end;
/
*/



create or replace procedure get_total_sal2 (
    p_empno in     emp.empno%type,
    p_total out  number,
    p_tax   in    number := 0.05
)
is 
  -- emp ���̺��� �ش� ����� �޿�(sal)�� �󿩱��� ������ ���� 
--    v_sal emp.sal%type;
--    v_comm emp.comm%type;
    
begin 
       select (sal + nvl(comm,0)) * (1-p_tax) 
        into p_total 
        from emp 
        where empno = p_empno; 
        
exception 
    when no_data_found then 
        dbms_output.put_line(p_empno||' : '||'No Data Found');
        p_total := 0; 
end;
/

declare 
-- give variable name to p_total, v_sal & v_comm? 
    v_empno emp.empno%type := 7788;
    v_total number; 
    v_tax number := 0; 
    
--    cursor my_cursor is 
--    select empno from emp; 
begin 
  get_total_sal2(v_empno, v_total, v_tax);
        dbms_output.put_line(v_total);
        
--    for r in my_cursor loop 
--        get_total_sal(r.empno,v_total); 
--        dbms_output.put_line(r.empno||' : '||v_total);
--        end loop; 
       
end;
/
