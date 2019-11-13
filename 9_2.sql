-- PL/SQL data type ���� 
-- 1) Scalar(��Į��) Ÿ��: number, varchar2, date,... 
-- 2) Reference (����) Ÿ��: � Ư�� ���̺��� ��(column)�̳� ��(row)�� �����ϴ� ���̺� 
-- column �� ���� (�Ѱ��� Ÿ��): dept table > deptno, dname, loc ... 
-- ���� �����ϴ� Ÿ���� ������� �ִ�. However, in a row, there are different types of data in a row.(���յ�����Ÿ��) /compound type 
-- 3) composite type: a. collection: collection of rows in one column b. record: collection of rows (������ �����Ͽ�,,,^^ Ŀ�� ��~) 
-- https://docs.oracle.com/database/121/TTPLS/dtypesfunc.htm#TTPLS163

-- �÷� ���� Ÿ�� ���� ����: �����̸�(or �ĺ���/identifier) ���̺��̸�.�÷��̸� %type := ��;  '
-- �÷��̸�%type �ϸ� �ش� �÷��� ���� Ÿ���� �ȴ� 
-- �� ���� Ÿ�� ���� ����: �����̸� ���̺��̸�%rowtype := �� 
-- rowtype �� ���ٱ�? how? 

set serveroutput on;

-- �÷� ���� Ÿ�� ���� ����
declare 
 -- dept ���̺��� �� �÷��� ������ ������ �� �ִ� ���� ���� 
 /*v_deptno number(2); =  v_deptno dept.deptno%type := 10; */
 v_deptno dept.deptno%type := 10;
 -- Ÿ���� �� ��, ���� ���ؼ����� �ƴ϶�, ����� ���� ������ ���ؼ��� ����ϴ� �ڵ� 
 v_dname dept.dname%type; 
 v_loc dept.loc%type; 
begin 
 select dname, loc 
 into v_dname, v_loc 
 from dept 
 where deptno = v_deptno; 
 DBMS_OUTPUT.put_line(v_deptno||' : '||v_dname||' : '||v_loc);
end;
/

-- �� ���� Ÿ�� ���� ����
declare 
    -- emp table�� row�� ��� ������ ������ �� �ִ� ������ �����Ѵ�. row�� �ִ� 8���� ���� 
    v_emp7788 emp%rowtype; 
    -- �����̸��� not over 30 bytes
begin 
    select * into v_emp7788 from emp where empno = 7788; 
    dbms_output.put_line('NAME: '||v_emp7788.ename);
    dbms_output.put_line('SALARY: '||v_emp7788.sal);
    dbms_output.put_line('DEPARTMENT NUMBER: '||v_emp7788.deptno);
    dbms_output.put_line('HIRE DATE: '||v_emp7788.hiredate);
end;
/

-- record data type: emp ��� �ϴ� �̸� �ϳ��� (�ѹ� ������ n number(2)�̷��� ���� ���� > �ϳ� �ۿ� ���� �ȵ� > �̷��� scalar) 
-- row type data �� �ȿ� �������� Ÿ�Ե��� ���� ���� (emp > number number > sal number > ename varchar2) 
-- ������ Ÿ�Կ� ���� �̸��� �ϳ��ε�, �� �ȿ� �������� �����Ϳ� �پ��� Ÿ�Ե��� ���� ���� (���ڵ� Ÿ��) 





