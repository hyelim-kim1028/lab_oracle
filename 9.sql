--1.
-- �̸��� �Է¹޾Ƽ� ����� �μ���ȣ �˻��ؼ� �̸�, ���, �μ���ȣ ��� 
-- �Էµ� �̸��� ��/�ҹ��ڿ� ������� ����� ����� �� �ֵ��� �϶� 

set serveroutput on; 

accept p_name prompt 'What is the name?';
-- �̸��� �Է��϶��� ������, ���ڳ� ���������δ� �������� ���Ѵ�. Ÿ���� ����������Ѵ� 

declare     
    v_empno number(4);
    v_deptno number(2); 
    v_ename varchar2(100) := '&p_name';
    -- v_ename varchar2(100) := upper('&p_name'); �̷���! 
begin 
    select empno,deptno
    into v_empno,v_deptno 
    from emp 
    where upper(ename) = v_ename;  
dbms_output.put_line('Ename '||v_ename||' has empno of '||v_empno||' and works in deptno '||v_deptno); 
end;
/

--- COMMON PROBLEM 
begin 
    dbms_output.put_line('&p_name');
end;
/
-- �̷��� Ȯ���غô���:  'SCOTT' �ĺ��ڰ� ���ǵǾ�� �մϴ�/ Statement ignored
-- &p_name�� �ڸ��� 111�� �����غô���, ���� 
-- prompt does not recognize characters, thus we have to put '' as well to make sure the prompt recognizes the characters as its kind 
-- to solve the probem of unrecognition, we put '' on &p_name





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


    