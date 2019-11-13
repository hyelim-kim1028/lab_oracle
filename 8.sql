-- ����(variable): ���α׷�(���ν���)���� �ʿ��� ������(��)�� �����ϴ� ���� 
-- ��� (constant): ���� �ѹ� ����(�Ҵ�)�Ǹ� ���� ������ �� ���� ���� 
-- ���ͷ� (literal): ���α׷��̳� ���ν������� �������� ���Ǵ� �� 

declare 
    --���� ����&�ʱ�ȭ 
    var1 number := 1;   
    -- ���⼭ 1�̶�� ���� �� ��ü�� ���ͷ��̶�� �θ��� (�� �� ��ü) 
    var2 varchar2(20) := 'abc'; 
    -- ���⼭ 'abc'�� ���ͷ�. �츮�� �ڵ����� ���� �ʴ� �̻� �� ���� �ٲ� �� ���� 
    -- �������: 
  --�����̸� constant ������Ÿ�� := ��  
  -- ����� ����� ���ÿ� �ʱ�ȭ�� �ؾ� ��! 
    const1 constant number := 3.14;
    -- �̷��� ������ ���ڸ� ������ �Ѵ� 
    -- ������ �߿��� ���� ����ǰ� ���� �ٲ� �� ���� �͵��� ������ �Ѵ� 
    -- �� ������� �ٸ� ���ڵ�� �����ϱ� ���� (�ٲ� �� �ִ� �ٸ� ���ڵ���) �츮�� ���ͷ��̶�� �θ��� 
    const2 constant number;
begin 
    const2 := 100; 
    var1 := 2; -- �������� �������� ���� ����(����, ���Ҵ�)�� �� �ִ�.
    var2 := '������'; -- ���� �� ������ ���� ���� (�Ҵ�) 
    const1 := 3.141592;
end;
/

-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�. = ������ ������ 
-- begin �� const1 := 3.141592 ��� �� ���:  'CONST1' ���� ���Ҵ��ڷ� ���� �� �����ϴ�/ 
-- PL/SQL: Statement ignored/ Usually a PL/SQL compilation error. 
-- ��: ���ϴ°�, �޴� / �Ҵ��� �޴� �뵵�δ� ����� �� �� ���� 
-- constant ��� �ٿ��ָ�, �ѹ��� ���� ���� �� �� �ְ�, ���߿� ���� �Ұ� 

--- 

set serveroutput on;
declare 
    v_num number default 0;
begin 
    dbms_output.put_line('v_num= '||v_num);

end; 
/

declare 
    v_num1 number := 10; --nullable variable 
    v_num2 number not null := 20;
begin 
    v_num1 := null;
    v_num2 := null; --not null �������� null�� �Ҵ��� �� ���� 
end;
/

-- p for parameter 
declare 
    -- ����� �޿��� ������ �� �ִ� ������ ���� 
    v_sal number; 
begin 
-- emp table ���� 7788�� ����� �޿��� �˻� 
    select sal into v_sal from emp where empno = 7788;
    -- �츮�� �ϰ� ���� ���� �� ���� �׳� ���°� �ƴ϶�, v_sal�̶�� �������� �־��ְ� ���� �� (into) 
    -- �׷� ��, into ��� ���̸� ����ؼ� �־��ش� 
    dbms_output.put_line('�޿�: '||v_sal);
end;
/

-- declare   v_sal number; ���⼭ ������Ÿ���� ���� �� ����, the original table has length of (7,2). 
-- If we put v_sal number (4 or other random number), it would have caused a problem. 

-- ����� �Է� �޾Ƽ� (accept - prompt) 
-- �Է¹��� ����� ��� �̸��� �μ� ��ȣ�� �˻��ؼ� ȭ�鿡 ����ϼ��� 

accept p_empno prompt '�����ȣ?';
-- My Answer + Teacher's solution 
declare 
--   v_empno number(4) := &p_empno; 
   v_ename varchar2(10); -- ����̸��� ������ ���� 
   v_deptno number(2); -- �μ� ��ȣ�� ������ ���� 
begin 
--select ename into v_ename from emp where empno = v_empno;  
--select deptno into v_deptno from emp where empno = v_empno; ���ε��� or ���� 
select ename,deptno
into v_ename,v_deptno 
from emp 
where empno = &p_empn0; -- v_empno;  
dbms_output.put_line('���'||&p_empno);  --v_empno
dbms_output.put_line('�̸�'||v_ename);  
dbms_output.put_line('�μ� ��ȣ'||v_deptno);  
end;
/

-- ctrl + /: ���� Ŀ���� �ִ� ��ġ�� ������ �ּ� ó��/���� (toggle) 

-- ����� �Է� �޾Ƽ� �ش� ������ �ѱ޿� (sal+comm)�� ȭ�鿡 ��� 
-- comm�� null�� ���� 0���� ��� 

-- My Answer 
accept p_empno prompt '�����ȣ?';

declare 
   --v_empno number(4) := &p_empno; 
   --v_sal number(7,2);
   --v_comm number(7,2) null := 0;  
   v_sum number(7,2); -- �ѱ޿�(sal+comm)�� ������ ���� ���� := v_sal + v_comm; -- �̷��� �ϸ� �ȳ��´�,, 
begin 
    select sal+nvl(comm,0)into v_total_sal
    from emp 
    where empno = &p_empno;
    
/*    v_sum := v_sal + v_comm; 
    select sal,comm into v_sal,v_comm from emp where empno = &p_empno;
    dbms_output.put_line('salary'||v_sal);
    dbms_output.put_line('commission'||v_comm);   
    dbms_output.put_line('sum'||v_sum)*/
    
    
/*  Not the above one, but the below one is the correct one (look how different) 
    select sal,comm into v_sal,v_comm from emp where empno = &p_empno;  
    dbms_output.put_line('���'||&p_empno||'����� �� �޿��� '||(v_sal + nvl(v_comm,0)))*/
end;
/

--    v_sum := v_sal + v_comm; 

-- teacher's solution 
accept p_empno prompt '�����ȣ?';
declare 
    v_sum number(7,2);
begin 
    select sal+nvl(comm,0)into v_sum
    from emp 
    where empno = &p_empno;
    dbms_output.put_line('��� '||&p_empno||'����� �ѱ޿��� '||v_sum);
end;
/
-- null��!!! 

declare 
v_sal number(7,2);
v_comm number (7,2);
v_total_sal number (7,2);
begin 
select sal, nvl(comm,0) into v_sal,v_comm 
from emp 
where empno = &p_empno;
v_total_sal := v_sal + v_comm; 
dbms_output.put_line('��� '||&p_empno||'����� �ѱ޿��� '||v_total_sal);
end;
/
























