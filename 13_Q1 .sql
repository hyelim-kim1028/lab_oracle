--20190920 QUESTION 1 

/*
1. 
dbms_random.value() �Լ� �̿��ؼ�, �ֻ��� 2���� ������ �� ������ ���� (x, y) �������� ����ϴ� PL/SQL�� �ۼ��ϼ���. �ֻ��� 2���� ���� �������� �� ����� ���߼���.
-- �ݺ�, ���ǹ��� ���� / ���ǹ����� <�ֻ��� 2���� ���� �������� �� ����� ���߼���.> x = y;  
(��� ����)
1��: (1, 4)
2��: (5, 2)
3��: (6, 6)

Initial thoughts:  
loop - loop 
exit when  x = y

result sale como: 
dbms_output.put_line(v_n||'��: '||'('||v_x||' , '||v_y);
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
---- �׷��� �̰ɷ� �ϸ� ���� 1���� 1���� ���� �����ϴ� ���ݾ�,,, 
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
