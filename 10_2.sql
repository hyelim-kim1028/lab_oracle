-- 14.2 


set SERVEROUTPUT ON;


/* 

*
**
***
****

*/
declare 
 i number; 
 j number;
begin 
    i := 1; 
    loop 
       j := 1;
    loop 
        dbms_output.put('*');   
    j := j+1;
    exit when j>i;
    end loop;
    dbms_output.new_line();
    
    i := i+1; 
    exit when i=5;
    end loop;
end;
/


-- 1���� 100 ���� ��� > 10�� ������ 

begin 
    for x in 1..100 loop 
    --dbms_output.put(x ||' '); -- sin rpad 
    dbms_output.put(rpad(x, 4, ' ')); -- con rpad 
    -- rpad : �ڸ��� ä���༭ �ڸ��� �����ش� 
        if mod(x,10) = 0 then -- 10�� ��� 
        dbms_output.new_line();    
        end if; 
    end loop;    
end;
/

-- rpad(x, 4, ' ')); 
--        4�ڸ��� ���, ������ �������� ��´�. �����ʿ��� ������ ��´� 


-- �Ʒ��� ���� ����ϴ� PL/SQL 
-- 1 2 * 4 5 * 7 8 * 10 
-- 11 12 * 14 15 * ... 
-- 21 22 * 
-- * * # * * # ... 
-- ************* 100 

set serveroutput on;

-- My Solution 

begin 
    for x in 1..100 loop 
    dbms_output.put(rpad(x, 4, ' ')); 
    if mod(x,10) = 0; 
    dbms_output.put('*'); 
     --   if x = with 3,6,9 then 
       -- dbms_output.put('*');
       --elsif x = double 3,6,9
      -- 33,36,39,63,66,69,93,96,99 then 
       --dbms_output.put('#');
       --else
       --mod(x,10) = 0 then 
       --dbms_output.new_line();
        -- end if; 
    end loop;
    dbms_output.new_line;
end;
/

-- Teacher's Solution 
declare 
    n1 number; -- 1�� �ڸ� ���ڸ� ������ ���� 
    n10 number; -- 10�� �ڸ� ���ڸ� ������ ���� 
    -- ��� �������� ������ 
begin
    for x in 1..100 loop
    --1�� �ڸ� ���ڴ� x�� 10���� ���� ������ 
    n1 := mod(x,10); 
    -- 10�� �ڸ� ���ڴ� x�� 10���� ���� �� 
    n10 := trunc(x/10,0);
    
    if n1 in (3,6,9) and n10 in (3,6,9) then 
    -- 1�� �ڸ��� Ȥ�� 10�� �ڸ����� 3,6,9, �̸�,,, 
        dbms_output.put('# '); 
   -- or �� ���� �������� �θ� ��� �ɷ����� and���� ���°� ���� ���̴�, �׷��ϱ� and �� ���� �ְ�  
    elsif n1 in (3,6,9) or n10 in (3,6,9) then 
        dbms_output.put('* '); 
    else
    dbms_output.put(x||' ');
    end if; 
    if mod(x,10) = 0 then 
    dbms_output.new_line();
    end if;
    end loop;
    
end;
/

-- 3,6,9 ���� ����,,, ������ 
-- num  = (x-1)*10 + y -- 1~100 ������ ��� ǥ���� �� �� �ִ� ������ 
declare 
    num number;
begin 
    for x in 0..9 loop -- x�� 10�� �ڸ� ����  --- 1~100������ ���ڸ� �������� 
        for y in 0..9 loop -- y�� 1�� �ڸ� ���� 
           num := x*10 + y; 
           
            if x in (3,6,9) and y in (3,6,9) then 
            dbms_output.put('# ');
            elsif x in (3,6,9) or y in (3,6,9) then  
            dbms_output.put('* ');
            else 
            dbms_output.put(num || ' ');
            end if; 
    
        end loop; 
        dbms_output.new_line; 
    end loop; 

end; 
/

declare 
    num number;
begin 
    for x in 0..9 loop -- x�� 10�� �ڸ� ����  --- 1~100������ ���ڸ� �������� 
        for y in 0..10 loop -- y�� 1�� �ڸ� ���� 
           num := x*10 + y; 
           
           if num in (30,60,90) then 
                dbms_output.put('* '); 
           elsif x in (3,6,9) and y in (3,6,9) then 
            dbms_output.put('# '); 
           elsif x in (3,6,9) and y!=10 or y in (3,6,9) then 
            dbms_output.put('* ');
            else 
           dbms_output.put(num||' ');
           end if; 
           end loop; 
           dbms_output.new_line(); 
           end loop; 
end; 
/


-- factorial 5! = 1* 2* 3* 4* 5 

accept p_num prompt '���丮���� ����� ����?';

declare 
    v_num number := &p_num;  -- n+1 
    v_factorial number := 1; 
    
begin 
    for i in 1..v_num loop
        v_factorial := v_factorial * i; 
        end loop; 
        dbms_output.put_line(v_factorial);   
end;
/
        
     
        
        
        
        
        
        
        
        