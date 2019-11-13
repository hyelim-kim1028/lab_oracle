--20190920 QUESTION 5

--ex 5. 
--(1) �̸��� SCOTT �� ����� �̸��� �μ� ��ġ�� ����ϴ� SQL �ۼ�.
--
--(2) �̸��� prompt�� �����, �ش����� �μ� ��ġ�� ����ϴ� PL/SQL �ۼ�. ��, �̸��� �ҹ��ڷ� �Է��ص� ����ǰ� �ۼ�.
--(��)
--�̸� �Է� ~ scott
--SCOTT�� DALLAS���� �ٹ��մϴ�

set serveroutput on;

accept p_ename prompt 'What is your name?';

declare 
    v_ename emp.ename%type := '&p_ename'; 
    v_loc   dept.loc%type;
    v_deptno dept.deptno%type;
    
begin 
    select e.ename, d.loc, d.deptno 
    into v_ename, v_loc, v_deptno 
    from emp e join dept d  
    on e.deptno = d.deptno
    where UPPER(e.ename)=UPPER(trim(v_ename));
    
    dbms_output.put_line(v_ename||' works in '||v_loc);

end;
/ 


