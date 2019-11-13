--09.19.2019 PACKAGE 
-- ���ν����� ����ִ� �� (package: where the procedure is stored) 

-- �ܼ�â�� �Է��ؾ��ϴ� �͵��� / ������ �͵��� / ��Ƶ� �� (���ȭ) 
-- ����ϰ� ���õ� ��ɵ��� �ϳ��� ��Ƽ� ����� �� �ְԲ� �صа��� ��Ű�� 
-- PL/SQL ����� �Ͱ� ���������, function, procedure �� ����� �Ͱ��� ���� �ٸ��� 
-- i.e. dbms_output.putline, dbms_random 
-- ������ specification ���Ӹ� �̿���???? ��������(spec) 


/*
Package 
- ��� �ȿ��� �������� ���� ���ν���, �Լ�, Ÿ�� (���ڵ�, �÷���), Ŀ�� ���� ��Ƶ� ���� ���α׷� 
- When creating a package: ��Ű���� �� (specification)�� ����(body)�� ���� �������Ѵ�/ �����ؾ��Ѵ� 
-- �� ���ó: ����, �ݺ������ξ��� ���ڵ带 ���� 

    ��Ű�� �� 
        create [or replace] package ��Ű���̸� 
        is 
            -- Ÿ�� Ȥ�� ���ν���/�Լ� ������Ÿ�� ���� ����
            ...
        end;
        /

    ��Ű�� ����(��ü):
        create [or replace] package body ��Ű�� �̸� 
        is 
            ��Ű�� ��(����)���� ����� ���ν���/�Լ� ���� ���� 
            -- ��Ű�� ������ �����ϵ��� �����ͼ� ���� 
*/

-- ��Ű�� ��(����) �ۼ� 
create or replace package my_PKG 
is 
    -- type ���� 
    type rec_emp_sal is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal   emp.sal%type
    ); 
    
    --���� ���� 
    num1 number := 0;
    
    -- ���ν��� ������Ÿ�� (prototype) ���� 
    -- ������ ������ �ʴ� ��..?? ����°� �ƴϱ�?? 
    procedure my_proc (p_empno number); 
    -- ������ ���ν����� ���� ���� ���̿��� ������ �ؾ����� �����ش� ������ �̰� ���� ��� ���尡 ���� > �׷��� ������Ÿ���̶�� �θ� 
    -- �̸��� �����ϱ� �θ� �� ������ �ڿ��� ���� > ��¥ ���� ����ϴ� ���� ������Ÿ���� ����� �δ� �� 
    
    -- �Լ� ������Ÿ�� ���� 
    function my_add(p_x number,p_y number) return number;
end;
/

-- �ٵ� ������ ���� �ʾƵ� �ƹ��� ������ ���� �ʴ´� 
-- my_add �� ����غ��� 

select my_add(1,2) from dual;
-- �̷��� ���� �츮�� ������ �Լ��� ã�� ���� 
-- ������ �츮�� ��Ű���� ������ �ִ� ���� ��带 ����ϰ� ���� �� 

select my_PKG.my_add(1,2) from dual;
-- dbms_output.put_line�� �ſ� ����ϰ� ���� 
-- my_pkg.my_add => my_pkg > ��Ű�� ���� / . > ��Ű�� �ȿ� �Լ� �ִ� (�� �ȿ� �� �ִ�)/my_add > �Լ�

-- ���� ���� �Ұ� 
-- ERROR:  package body "SCOTT.MY_PKG"��(��) �������� �ʽ��ϴ�. 
-- 4067. 00000 -  "not executed, %s does not exist"
--*Cause:    Attempt to execute a non-existent stored procedure.
--*Action:   Make sure that a correct name is given.

-- ��Ű�� �ٵ� �ۼ� 
create or replace package body my_PKG
is 
    -- ��Ű�� ���� ����� ���ν��� ���� 
    procedure my_proc(p_empno number)  --- pkg �ȿ����� create ���� �� ���� ���� 
    is 
        v_result my_PKG.rec_emp_sal; 
    begin 
        select empno, ename, sal  -- rec_emp_sal �� ������ 
        into v_result 
        from emp 
        where empno = p_empno; 
        
        dbms_output.put_line(v_result.empno||' , '
                             ||v_result.ename||' , '
                             ||v_result.sal);
    end my_proc;
    
    -- ��Ű�� ���� ����� �Լ��� ���� 
    function my_add(p_x number, p_y number) return number 
    is
    begin
        return p_x + p_y;
        end my_add;
    end; 
    
    
end;
/
select my_PKG.my_add(1,2) from dual;

select my_PKG.num1 from dual;
-- ������ �̷��� �� �� �����

declare 
    v_result my_pkg.rec_emp_sal; -- package ���� � ���ڵ� Ÿ������ ������ ������ Ÿ�� ���� 
begin 
    dbms_output.put_line(my_pkg.num1);
    my_PKG.my_proc(); 
end; 
/ 




















