--09.19.2019 
/*
<Procedure vs Function> 
1. Procedure 
    a. Ư�� ������ �����ϱ⸸ �ϰ�, ��������� ��ȯ(return)���� �ʴ� ���� ���α׷� 
    b. ����: �ٸ� PL/SQL(���α׷�) ���ο��� ����� (declare - begin - end;/). SQL �������� ����� �� ���� (select, update...).  
    c. �Ķ����: in, out, inout ������ ����� �� �ִ� 
    d. ��ȯ: ������� return ���� ����� ��ȯ�� �� �� ����. 
    out/inout �Ķ���͸� ���ؼ� 1�� �̻��� ���� ��ȯ�� ���� ���� > ������ ���� �ѹ��� ���ϵ� ���� 
    
    
2. Function 
    a. Ư���� ����� �����ϰ�, ������ �� �ݵ�� ������� ��������� ��ȯ�ϴ� ���� ���α׷� 
    b. ����: �ٸ� PL/SQL (���α׷�) ���� �Ǵ� SQL ���� �ȿ��� ����� �� ����. 
    c.in �Ķ���͸� ���: in ����� �Ķ���͸� ���. in�� ���� 
      (out, in out �� ���Ǳ�� ������, sql���忡�� ��� �� �� ����
       >���ν����� �ݼ��� ��谡 ��ȣ�ϰ�, ����Ŭ������ �Լ����� out �Ķ���͸� ������� �ʱ⸦ ���ϰ� �ִ�)  
    d. ��ȯ: �Լ��� �ݵ�� ���Ϲ��� ����ؼ� �Ѱ��� ���� ��ȯ�ؾ��Ѵ�! (2��, 3�� �ȵǱ���, ������ 1��) 

�Լ��� �����ϴ� ��� 
    create [or replace] function �Լ��̸� [(
        �Ķ���� 1 ������ Ÿ��,
        �Ķ���� 2 ������ Ÿ��, 
        ... 
    )] return ����Ÿ�� *** 
    is 
    begin 
    [exception] 
    end;
    /
*/

set serveroutput on;

-- ���ϱ� ������ �Լ� ����� 
    create or replace function my_add(
        p_x number,
        p_y number
    ) return number -- �������� ���� my_add �� ���� 2�� (p_x �� p_y)�� ������ 1���� ���� number �� ��ȯ�ϰڴ� 
    is 
        v_result number; -- ���ϰ��� �����ϱ� ���� ���� 
    begin 
        v_result := p_x + p_y;  -- �� ���� ������ �ؼ� ������ �ִ� �� 
        return v_result;        -- �Լ��� ȣ���� ������ ���� ��ȯ( return)/ ���� ��� 
    end;
    /

-- ����Ŭ ���� �Լ��� ������� Ȯ���� �� dual ���� ���̺� �̿� 

select upper('itwill') la_academia from dual;

-- �츮�� �ۼ��ϴ� �Լ��� SQL������ �����(return value)�� Ȯ���� �� �ִ� 
select my_add(3,7) from dual; -- p_x = 3, p_y = 7 

--�Լ��� PL/SQL������ ��� ���� 
declare 
    v_result number; 
begin 
    v_result := my_add(100,200);
    dbms_output.put_line(v_result);
end;
/

-- ���� �ΰ��� �Ķ���ͷ� ���޹޾Ƽ� ������ ����� �����ϴ� �Լ� �ۼ�/�׽�Ʈ 
-- ���ڿ� �ΰ��� �Ķ���ͷ� ���޹޾Ƽ� �� ���ڿ��� �ϳ��� ��ģ ���ڿ��� �����ϴ� �Լ� 

-- select 'p_x'||' - '||'p_y'
--   from dual; 
-- idea from: https://www.techonthenet.com/oracle/functions/concat2.php

-- ���� Ǯ���� �� 

create or replace function my_sub(
    p_x number,
    p_y number 
    )return number 
is 
    v_x varchar2;
    v_y varchar2; 
begin 
    select p_x, p_y into v_x,v_y from dual; 
  return 'v_x'||' - '||'v_y';
end;
/

select my_subt(7,3) from dual;
-- I think too complicated: which means I am lack the understanding nor have enough basic language to use the language 


--Teacher's Solution 
create or replace function func_sub(
    p_x number,
    p_y number 
    )return number 
is 
begin
  return p_x - p_y;
end;
/

select func_sub(1,2) from dual;

declare 
    v_result number;
begin 
    v_result := func_sub(123,100);
    dbms_output.put_line(v_result);
end;
/

create or replace function my_concat(
    str1 varchar2, 
    str2 varchar2 --���ڿ��� ũ�� ���� �����ּ��� 
)return varchar2 
is 
    v_result varchar2(1234); -- ���⼱ varchar2�� ũ�⸦ ����������� 
                            -- ������ ��ȣ�� ���� �ʾƿ� �ФФ�!!!!!!!!!!!
begin 
    v_result := str1 || str2; 
    return v_result;  
--return str1||str2;
end;
/


select my_concat(1,2) from dual;

select my_concat('Hello ','World') from dual;

declare
    v_result varchar2(100);
begin 
    select my_concat(ename ,job) into v_result
    from emp 
    where empno = 7788;
    dbms_output.put_line(v_result); 
end;
/

--�Ķ���ʹ� ��� �ʿ��ұ� > p_total�� ���ν������� in�� �Ķ���͵� 2�� > ���⼱ 2�� �ʿ� 
-- ����� tax rate(����)�� �Ķ���ͷ� ���� �޾Ƽ� 
-- �� �޿��� ����ؼ� �����ϴ� �Լ� �ۼ� 
-- SQL, PL/SQL�� ����Ͽ� �׽�Ʈ���� 

-- WHAT I'VE DONE 
create or replace function func_total( 
    p_empno emp.empno%type,
    p_tax   number := 0.05
) return number 
is 
    v_sal emp.sal%type;
    v_comm emp.comm%type;
    v_total number;
begin
    select sal, comm into v_sal, v_comm from emp where empno := p_empno;
    v_total := (v_sal + nvl(v_comm,0)) * (1-p_tax); 
    return v_total;
end;
/

-- TEACHER's SOLUTION 
-- ���� �ٽ� ���� (the default tax rate doesnt work in the processing part) 
create or replace function func_total( 
    p_empno emp.empno%type,
    p_tax   number := 0.05 
) return number 
is 
    v_total number;
begin
    select (sal + nvl(comm,0)) * (1-p_tax)
    into v_total 
    from emp
    where empno = p_empno;
    
    return v_total; 

end;
/

select empno,ename,sal, comm, func_total(7839) 
from emp 
where empno = 7839;

-- ���� 
--create or replace function func_total( 
--    p_empno emp.empno%type := 7788,
--    p_tax   number 
--���⼭ �ý��� ����Ʈ�� ����, ,empno ���� Ƽ��Ʈ�� �ְ� ���� ��Ű�� ��� �ɱ�? 
--�ȵȴ�. ������� ���� �Է� > ���� empty�̰�, �ڸ��� ���� �� �� ���� 
-- �ƴϸ� (p_tax=>0.1) �̷��� �ᵵ �� 



create or replace function func_total2( 
    p_empno emp.empno%type := 7788,
    p_tax   number  
) return number 
is 
    v_total number;
begin
    select (sal + nvl(comm,0)) * (1-p_tax)
    into v_total 
    from emp
    where empno = p_empno;
    
    return v_total; 

end;
/

select empno,ename,sal, comm, func_total2(p_tax => 0.1) 
from emp 
where empno = 7788;

-- ������ func_total2(p_tax => 0.1) �� ���ŷο��, �����ϸ� ����Ʈ�� ���� �ʴ� �������� �տ� ����, �ڿ� ����Ʈ�� ���� �������� ������ 
-- �����ٲ� ���� ���� (p_tax => 0.1,p_empno=>7788)

-- RECORD/LOOP �� ����� �ڵ� (�� �̵� �� ���Ͽ��� ������) 
create or replace function func_total3( 
    p_empno emp.empno%type := 7788,
    p_tax   number  
) return number 
is 
    v_total number;
begin
    select (sal + nvl(comm,0)) * (1-p_tax)
    into v_total 
    from emp
    where empno = p_empno;
    
    return v_total; 

end;
/

select empno,ename,sal, comm, func_total2(p_tax => 0.1) 
from emp 
where empno = 7788;









-- �������Լ� ����� factorial 
-- fact(0) = 0! = 1/ fact(1) = 1! = 1*1 = 1/ fact(2) = 2! = 1*2 = 2/ fact(3) = 3! = 1* 2*3 = 6

-- my code > brain fried 
create or replace function f_fact( 
   param_1 number 
) return number 
is 
    v_fact number;
begin
     for r in 1..5 loop 
        v_x := v_x ;
            if r = 0 then 
            dbms_output.put_line(1) 
            end if; 
        r+1 
     end loop; 
     return v_fact;
end;
/

-- Teacher's Solution : �̰͵� �� �̵� ������ 
    create or replace function my_factorial (n number) return number 
    is 
        v_result number := 1; -- ��� ����� ������ ���� 
        
    begin
        for i in 1..n loop 
        v_result := v_result * i; 
        end loop; 
        
        return v_result;
    end;
    /

-- �μ�, ����, �ŰԺ���(�Ű� like a mediating variable)  


begin 
    for n in 0..5 loop 
        dbms_output.put_line(my_factorial(n));
    end loop; 
end;
/

-- for loop�� ������� �ʰ� �ϴ� ��� 

create or replace function factorial2 (n number) return number 
is  
    v_result number := -1; 
begin
    if n = 0 then -- n refers to the n in the parameter  
        v_result := 1; 
        elsif n>0 then 
            v_result := factorial2(n-1)*n;
    end if; 
        
    return v_result;
end;
/
-- ����: 1���丮���� ����� �ȵ� (1-1) * 1 = 0*1 =0 �ڿ��� ������ ���� 0 ���� ��� 
-- ���ȣ��(recursion): �Լ��� �Լ� ���ο��� �ڱ� �ڽ��� �ٽ� �ѹ� ȣ�� �ϴ� �� 
-- ������ ���������� �� ��Ͱ� ���� �� �ִ� ������ ���������Ѵ� (���⼭�� 0!������ �������� �ȵȴ�) 

begin 
    for n in 0..5 loop 
    dbms_output.put_line(factorial2(n));
    end loop;
end;
/

/*
Parameter(�ŰԺ���, ����) vs Argument(�μ�, ��������) 

> Parameter: �Լ��� ���ν����� ������ �� ���޹޴� ���� �����ϱ� ���� �����ϴ� ����  
    create procedure proc_name(pram1 number, param2 varchar2, ... ) 
     create function func_name(pram1 number, param2 varchar2, ... )
> Argument: �Լ�, ���ν����� ȣ���� �� �����ϴ� �� 
    proc_name(123, 'abc');
    func_name(100,'������'); 
*/









