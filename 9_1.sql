set SERVEROUTPUT ON
--2. 
-- �̸��� �Է� �޾Ƽ� 
-- emp, dept ���̺��� Ȱ���Ͽ� (join) 
-- 'Scott'�� '�޶�'�� ��ġ�� '����ġ'�μ����� �ٹ��մϴ� �� ���� �������� ����϶� 

accept p_ename prompt 'What is the name?';

declare 
    v_ename varchar2(20) := '&p_ename';
    v_loc varchar2(13);
    v_dname varchar2(14);
   -- v_deptno number(2); no need to indicate it here 
begin 
    select e.ename, d.loc, d.dname 
    into v_ename,v_loc,v_dname
    from emp e join dept d    
    on e.deptno = d.deptno
    where UPPER(e.ename) = Upper(trim(v_ename));
dbms_output.put_line(v_ename||' ��(��) '||v_loc||' �� ��ġ�� '||v_dname||' �μ����� �ٹ��մϴ�'); 

end;
/

-- logic (��) �����: ������ �ذ��� ������ ���� 
-- �������ִ� ����: ����� �̸� (emp table)
-- �츮�� �� �� �ִ� ����: �μ���ȣ (emp>dept table) SQL ���� 1 
-- �츮�� �˰� ���� ����: �μ���ġ�� �μ��̸� SQL (deptno) ���� 2

accept p_name prompt '�̸� �Է��ϼ���...';
declare 
    v_ename varchar2(20) := upper(trim('&p_name'));
    v_dname varchar2(14); 
    v_loc varchar2(20);
    v_deptno number(2); 
    -- We did not indicate the deptno in the previous solution(s), however, following a new logic (under a supposition that we do not rememebr a join sentence)
begin 
    -- ��� �̸����� �� ����� �ٹ��ϴ� �μ� ��ȣ�� �˻� 
    select deptno into v_deptno from emp where upper(ename) = v_ename; 
    -- �μ� ��ȣ�� ����ؼ� �μ��� �̸��� ��ġ �˻� 
    select dname, loc into v_dname,v_loc from dept where deptno = v_deptno;
    -- �˻��� ������ ȭ�鿡 ��� 
dbms_output.put_line(v_ename||' ��(��) '||v_loc||' �� ��ġ�� '||v_dname||' �μ����� �ٹ��մϴ�'); 
end;
/

-- ������ ���� �� �� ����,,, 

