-- 09.18.2109 
-- ����ó�� 
set serveroutput on; 

declare 
    v_result number; 
    
begin 
    dbms_output.put_line('Before execution'); 
    select * into v_result from emp;
    dbms_output.put_line(v_result); 
    
end;
/

/*
����/����(exception/error) ó�� 

declare 
-- �����: ����, Ÿ�� (record, collection) ����, Ŀ�� ���� 
begin 
-- �����: ���������� ������ �ڵ���� �ۼ� 
>>>> new! exception 
-- �����(begin)�� �ڵ���� �����ϴٰ� ������ �߻����� �� ó���ϴ� �κ� 
-- �� ���ܸ� ó���ϴ� �κ� 
�����, DB�� ���� ó�� ���� �κи� �ذ� 
���� �� �� �ִٸ� �ڵ带 ��ġ�°� ���� ���� 

exception formula: 
    when ���� �̸� then 
        �ش� ���ܰ� �߻����� �� ó���� �ڵ�; 
-- when �� �������� �� ���� �ִ� 
-- �����̸��� ���� ��쿡�� 
    when others then ... 
    ������ ������ ���ܵ��� �ƴϰų� �Ǵ� ���� �̸��� �� �� 

end;
/

*/

-- ����ó������ 

declare 
    v_result number; 
begin 
    dbms_output.put_line('���� �߻� ��'); 
    v_result := 'TENGO_HAMBRE'; 
    dbms_output.put_line(v_result);

exception 
  when value_error then 
        dbms_output.put_line('Not a number'); 
end;
/

-- ���� �߻� > ������ �ڵ带 �� ��: others ���ֱ� 
declare 
    v_result number;
    
begin 
    dbms_output.put_line('Before the exception takes place');
    v_result := 123/0;
    dbms_output.put_line(v_result);

exception
    when others then 
        dbms_output.put_line('���� �ڵ�'||sqlcode);
        dbms_output.put_line('���� �ڵ�'||sqlerrm);
    when zero_divide then 
        dbms_output.put_line('0���� ���� �� �����ϴ�.');
        
end;
/
-- OTHERS�� ��ϳ��� ���� ó���� �� ���� �������� ��ġ�Ͽ��� �մϴ�


-- ORA 01476: the divisior is equal to zero 
-- link: https://www.techonthenet.com/oracle/errors/ora01476.php 

-- when ������ �ΰ�, ������ 1�� 

declare 
    v_result number;
    

begin 
    select * into v_result from emp where empno = 7788; 

exception 
    when value_error then 
        dbms_output.put_line('ValueError');
    when others then 
        dbms_output.put_line(sqlcode||' , '||sqlerrm);

end;
/
-- ERROR:  ORA-00947: ���� ���� ������� �ʽ��ϴ�
-- compilation error: �̰� �츮�� exception ���� ó���� �� ���� ���� 
-- ORA-00947 not enough values/ 06550. 00000 -  "line %s, column %s:\n%s"
-- *Cause:    Usually a PL/SQL compilation error.
-- Cause: This error occurs when a SQL statement requires two sets of values equal in number, 
--but the second set contains fewer items than the first set. 
--This can occur in a WHERE or HAVING clause in which a nested SELECT returns too few columns as in:
-- can be solved using: WHERE (A,B) IN (SELECT C FROM ...) or INSERT INTO EMP(EMPNO,ENAME) VALUES('JONES')

-- compilation error > the upper code does not show the error but the lower code shows it 
-- different kinds of errors: 
--(1) compilation error -- grammatically wrong; so the process does not start from the beginning.
--                         so we cannot use the exception for the code to work, rather we have to fix it before we start the code 
-- SQL Ȥ�� PL/SQL ������ ���� �ʾƼ� ���� ��ü�� ���� �ʴ� ����. ������ Ʋ�� �κ��� ã�Ƽ� ������ �°Բ� �����ؾ߸� �� 
-- ������ �°Բ� ��ġ�� ������ ������ ���� �ʱ� ������ exception ó���� ���� �ʴ´�. 
-- �츮�� �ۼ��� �ڵ�� ��ǻ�� ���� �ٲ��ִ� ����: compile > compilation error = ���� ����!! 

--(2) ������ ����(runtime error) 
-- grammatically correct, so it can be compiled, but an error occurs (���� �߿� � ������ �߻��ϴ� ����)  
--(so random huhuhuhu) > think this way: sometimes there are things that are grammatically correct but that does not make sense

declare 
  v_result number;
begin 
  select ename into v_result from emp where empno = 7788;  
exception 
    when value_error then 
        dbms_output.put_line('Value Error');
    when others then 
        dbms_output.put_line(sqlcode||' , '||sqlerrm);
end;
/

declare 
    v_result number; 
begin 
    dbms_output.put_line('���� �߻� ��'); 
    v_result := 'TENGO_HAMBRE'; 
    dbms_output.put_line(v_result);

exception 
  when value_error then 
        dbms_output.put_line('Not a number'); 
end;
/

declare 
  v_result number;
  v_row emp%rowtype;
begin 
  select * into v_row from emp;  
  dbms_output.put_line('v_row.ename');
exception 
    when value_error then 
        dbms_output.put_line('Value Error');
    when too_many_rows then 
        dbms_output.put_line('too many rows');
    when others then 
        dbms_output.put_line(sqlcode||' , '||sqlerrm);
end;
/
-- too many rows (ORA ...) 
-- ���� ���� �޽����� �ȶ� �Ф� ���� > ���ν����� ���������� �ȴ� set serveroutput on; �� �ȴ�����,,, �͸��� 





