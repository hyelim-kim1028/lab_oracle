/*�� ��� �տ� --�� ������, ���� ���̰� ���� �ٲ�� ���̻� protect? what word should I use duh ���� �ʴ´� */
set serveroutput on;

-- ���ڵ� & �÷��� 
-- RECORD: ������ Ÿ���� ���� �ٸ� �������� ��(������)���� ������ �� ����ϴ� ������ �̸�. (���� ������ �̸�) 
-- COLLECTION: ���� Ÿ���� �����͵��� �����Ҷ� 
-- ~ with the concept of row and column 

-- ���ڵ� ����/���� ���:
-- type ���ڵ��̸� is record(���� �̸�, ���� Ÿ�� .. ); 
-- ���ڵ忡 ���� ����: 
-- ���ڵ�. �ʵ� := ��; (From my understanding, as described by the teacher "it is an element of a record" it is a column in the table, 
            -- but is it more specific or what? 
declare 
    -- define the record 
    type rec_dept is record(
     deptno number, 
     dname varchar2(20),
     loc varchar2(20)
    );
    -- not making it the same as the table itself 
    -- ���� �̸� ����Ÿ��; dname varchar2(20);  ������ ������ �� ����� �� �ִ� ������ Ÿ���� ���(?) 
    
    
    -- ���ڵ��� �̸��� ������ ������ �� ��� 
    v_dept_row rec_dept; --v_dept_row��� ������ rec_dept ��� Ÿ���Դϴ� ��� �� 
    -- ���ڵ带 ����� ������ Ÿ���� ���ϱ����ؼ�  
begin 
    -- ���ڵ� ������ ���� ���� 
    v_dept_row.deptno := 99; 
    v_dept_row.dname := 'ITWILL';
    v_dept_row.loc := 'GANGNAM, SEOUL';
    
    dbms_output.put_line('��ȣ: '||v_dept_row.deptno||' �μ��̸�: '||v_dept_row.dname||' ��ġ: '||v_dept_row.loc);
    
end;
/
-- �μ�Ʈ�� ������Ʈ�� �� �� �� �� ����� �� �ִ�  
-- ���ڵ� ����ؼ� �μ�Ʈ ��� 
--

select * from dept2;
-- dept2 ���̺� ���ڵ带 insert 
desc dept2;

declare 
    type rec_dept is record(
    deptno dept2.deptno%type,
    dname dept2.dname%type,
    loc dept2.loc%type
    );
    
    v_row rec_dept; -- 3���� ���� �Ѳ����� ���� ������ Ÿ���� v_row 
    
begin 
    v_row.deptno := 11;
    v_row.dname := 'DATABASE';
    v_row.loc := 'SEOUL';
    
-- dept2 ���̺� ���� �� insert  
--insert into dept2
--values(v_row.deptno,v_row.dname,v_row.loc)... -- ��¥�� v_row�� �� ����� ���� 

insert into dept2
values v_row;

-- record type �� ������ ����� dept 2���̺� ������Ʈ 
-- update dept2 set deptno =?,dname = '',loc ='' where deptno = 11;  
 v_row.deptno := 99;
 v_row.dname := 'PL/SQL';
 v_row.loc := 'GANGNAM';
 update dept2 set row = v_row where deptno = 11; -- �̷��� �� �� �ִ� �� ���̺�� ������ ������ ������ �־�߸� ���� 
 -- �ΰ��� �ִ� ����: �ѹ� �� �����Ű�ϱ� �ѹ� �� insert �� �� (begin > insert ���⼭���� ����,,,) �׷��� ���� �� ������ ���߰� 
 -- PL/SQL�� ������ ���� �� ����� > insert�� �ѹ� �� �Ǵ� ���� 
end; 
/

select * from dept2;

-- dept2.loc%type > ���� �� ����� ������? 

declare 
    -- row Ÿ�� ���� ���� ���� 
    v_row1 dept%rowtype; --������ ������ Ÿ�� 
    -- ���̺��� ����(�÷� �̸�/Ÿ��)�� �Ȱ��� ���ڵ� Ÿ�� 
    
begin 
    -- ���̺�� �Ȱ��� �Ϸ��� ���� �׷��� ���� �θ� �ʿ� ���� 
    v_row1.deptno := 22;
    v_row1.dname := 'ABC';
    v_row1.loc := 'KOREA';
    
    insert into dept2 values v_row1;
    -- row Ÿ���� ���� ������ ����Ʈ �� �� �ʿ��ؼ� �׷� 
    
end; 
/ 

-- ���ڵ带 ����� select 
-- emp ���̺��� ��� �� �ƴ϶�, 3���� �÷��� ����Ʈ �Ѵ� ��� �Ѵٸ�,���ڵ带 ���� �����ؼ� ��� 

declare 
-- ���̺��� ��� �÷��� �˻��ϴ� ��쿡�� ���ڵ带 ���� �����ϴ� �� ���� %rowtype ������ ����ϴ� ���� ����. 
 v_emp_row1 emp%rowtype;
 
 -- ���� 
 type rec_emp is record(
    empno emp.empno%type,
    ename emp.ename%type,
    job emp.job%type
    );
-- ���ڵ� ������ ������ ���� 
    v_emp_row2 rec_emp;
begin 
    select * into v_emp_row1 from emp where empno = 7788; 
    dbms_output.put_line(v_emp_row1.empno||','||v_emp_row1.ename);
    --���̺��� ��� �÷��� ����� �� ���� 
    -- ������, ���࿡ ���̺��� ��� �÷��� �ƴ϶�, ���̺��� �Ϻ� �÷��� �˻��ϰų� Ȥ�� �ΰ� �̻��� ���̺��� �����ϴ� ��� 
    -- ����� ���� ���ڵ带 �����ϴ� ���� ���մϴ�.  
    
    -- ���̺��� �Ϻ� �÷��� �˻��ϴ� ��� 
    select empno, ename, job 
    into v_emp_row2
    from emp 
    where empno = 7839; 
-- �÷� 3���� �˻��ϰ�, into ���� �÷��� ���� ������ ��) row1�� ���, ������ �� (ERROR: ���� ���� �ʹ� �����ϴ�) 
-- Ȥ�� into �� ���̵��� ���� ���� �����ؼ� ��� Ȥ�� ���ڵ�� ���� ��� > �ƴϸ� �÷��� ���� ���� �ʾƼ� ���� 
dbms_output.put_line(v_emp_row2.empno||' , '|| 
                     v_emp_row2.ename||' , '|| 
                     v_emp_row2.job);
                     
-- insert, update � ���Ǳ⵵ �ϰ�, 

    
end; 
/

--emp ���̺�, dept ���̺��� 
-- ���, �̸�, �޿�, �μ� �̸�, �μ� ��ġ 
-- joined by deptno 
-- �������� ������ �� �ִ� ���ڵ�(emp_dept)�� �����ϼ��� 
-- join ������ �ۼ��ؼ� 7788�� ����� ������ ����ϴ� PL�ۼ� 

declare 
    type emp_dept is record(
    empno emp.empno%type, 
    ename emp.ename%type, 
    sal emp.sal%type, 
    dname dept.dname%type,
    loc dept.loc%type
    );
    v_row emp_dept;
begin
    select e.empno, e.ename, e.sal, d.dname, d.loc 
    into v_row
    from emp e join dept d
    on e.deptno = d.deptno
    where e.ename = 'SCOTT';
    
    dbms_output.put_line(v_row.empno||','||v_row.ename||','||v_row.sal||','||v_row.dname||','||v_row.loc);
end;
/



-- salgrade�� �˾ƺ��� ! ���� ������ �� ���,,,! 
declare 
    type emp_sal is record(
    empno emp.empno%type, 
    ename emp.ename%type,  
    sal emp.sal%type,
    grade salgrade.grade%type
    );
    v_row emp_sal;
begin
    select e.empno, e.ename, e.sal, s.grade
    into v_row
    from emp e join salgrade s
    on e.sal between s.losal and s.hisal
    where e.ename = 'SCOTT';
    
    dbms_output.put_line(v_row.empno||','||v_row.ename||','||v_row.sal||','||v_row.grade);
end;
/






























