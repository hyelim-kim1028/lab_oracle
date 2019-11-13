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


-- 1부터 100 까지 출력 > 10씩 나눠서 

begin 
    for x in 1..100 loop 
    --dbms_output.put(x ||' '); -- sin rpad 
    dbms_output.put(rpad(x, 4, ' ')); -- con rpad 
    -- rpad : 자리를 채워줘서 자리를 맞춰준다 
        if mod(x,10) = 0 then -- 10의 배수 
        dbms_output.new_line();    
        end if; 
    end loop;    
end;
/

-- rpad(x, 4, ' ')); 
--        4자리를 잡고, 공백은 공백으로 잡는다. 오른쪽에다 공백을 잡는다 


-- 아래와 같이 출력하는 PL/SQL 
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
    n1 number; -- 1의 자리 숫자를 저장할 변수 
    n10 number; -- 10의 자리 숫자를 저장할 변수 
    -- 몫과 나머지를 나눈다 
begin
    for x in 1..100 loop
    --1의 자리 숫자는 x를 10으로 나눈 나머지 
    n1 := mod(x,10); 
    -- 10의 자리 숫자는 x를 10으로 나눈 몫 
    n10 := trunc(x/10,0);
    
    if n1 in (3,6,9) and n10 in (3,6,9) then 
    -- 1의 자릿수 혹은 10의 자릿수가 3,6,9, 이면,,, 
        dbms_output.put('# '); 
   -- or 을 먼저 조건으로 두면 모두 걸러내서 and에는 남는게 없을 것이다, 그러니까 and 를 먼저 주고  
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

-- 3,6,9 이중 루프,,, 껄껄껄 
-- num  = (x-1)*10 + y -- 1~100 까지를 모두 표현해 줄 수 있는 방정식 
declare 
    num number;
begin 
    for x in 0..9 loop -- x는 10의 자리 숫자  --- 1~100까지의 숫자를 분해하자 
        for y in 0..9 loop -- y는 1의 자리 숫자 
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
    for x in 0..9 loop -- x는 10의 자리 숫자  --- 1~100까지의 숫자를 분해하자 
        for y in 0..10 loop -- y는 1의 자리 숫자 
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

accept p_num prompt '팩토리얼을 계산할 숫자?';

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
        
     
        
        
        
        
        
        
        
        