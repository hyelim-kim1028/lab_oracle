--20190920 QUESTION 1 

/*
1. 
dbms_random.value() 함수 이용해서, 주사위 2개를 던졌을 때 나오는 눈을 (x, y) 형식으로 출력하는 PL/SQL을 작성하세요. 주사위 2개의 눈이 같아졌을 때 출력을 멈추세요.
-- 반복, 조건문을 쓰자 / 조건문으로 <주사위 2개의 눈이 같아졌을 때 출력을 멈추세요.> x = y;  
(결과 예시)
1차: (1, 4)
2차: (5, 2)
3차: (6, 6)

Initial thoughts:  
loop - loop 
exit when  x = y

result sale como: 
dbms_output.put_line(v_n||'차: '||'('||v_x||' , '||v_y);
*/

set serveroutput on;

declare 
    v_x number;
    v_y number;
begin 
     v_x := trunc((dbms_random.value(1,7)),0); 
     v_y := trunc((dbms_random.value(1,7)),0);
    dbms_output.put_line(v_x||' , '||v_y); 
end;
/

----' , '||v_y
--
---- version 1 : using associative array 
---- 그런데 이걸로 하면 원래 1개에 1개의 값을 저장하는 거잖아,,, 
--
--declare 
--    type dice_roller is table of number index by pls_integer; 
--    v_dice dice_roller; 
--     
--begin 
--    for i in 1..v_cnt loop 
--        v_dice(i) := trunc((dbms_random.value(1,7)),0);
--            for v_y in 1..v_cnt loop
--            v_y(i) := trunc((dbms_random.value(1,7)),0);
--            end loop;
--    end loop; 
--
--
--end;
--/
--
--
---- version 2: using two for-loops 
--
--declare 
--    v_cnt constant number := 6; 
--    v_x number;
--    v_y number; 
--     
--begin 
--    for i in 1..v_cnt loop
--        v_x(i) := trunc((dbms_random.value(1,7)),0);
--        end loop; 
--        
--      for v_y in 1..v_cnt loop
--     v_y(i) := trunc((dbms_random.value(1,7)),0);
--         end loop;
--            
--     dbms_output.put_line(v_x||' , '||v_y);
--   
--end;
--/
--
---- version 3: using basic loops 
--
--declare 
--    v_x number;
--    v_y number
--begin 
--     v_x := trunc((dbms_random.value(1,7)),0); 
--     v_y := trunc((dbms_random.value(1,7)),0);
--    dbms_output.put_line(v_x||' , '||v_y);
--    
--    
--    
--end;
--/
--
--
--
--declare 
--    v_x number;
--    v_y number
--begin 
--     v_x := trunc((dbms_random.value(1,7)),0);
--     v_y := trunc((dbms_random.value(1,7)),0);
--    dbms_output.put_line('('||v_x||' , '||v_y||')');
--end;
--/
--
--
