-- 1. 구구단 (2~9단)을 출력 -- 줄 추가 
--2. 구구단을 출력. 2단은 2*2 까지, 3단은 3*3까지, ... 9단은 9*9까지 


set serveroutput on;

--1. 

begin
-- after every loop dbms_output.put_line, put (---) 
for i in 1..9 loop 
    dbms_output.put_line ('2 X '||i||'='||(2*i));
    dbms_output.put_line ('3 X '||i||'='||(3*i));
    dbms_output.put_line ('4 X '||i||'='||(4*i));
    dbms_output.put_line ('5 X '||i||'='||(5*i));
    dbms_output.put_line ('6X '||i||'='||(6*i));
    dbms_output.put_line ('7 X '||i||'='||(7*i));
    dbms_output.put_line ('8 X '||i||'='||(8*i));
    dbms_output.put_line ('9 X '||i||'='||(9*i));
 
    end loop;
end; 
/

-- 위에 것 자체도 틀림 : 처음에 노가다로 한건 맞았었음 

--  if i=9 then 
  --  dbms_output.put_line ('------------------------');
   -- end if; 
-- how to put a dotted line: https://www.w3resource.com/plsql-exercises/cursor/plsql-cursor-exercise-45.php 
loop 
반복할 문장;  
exit when 조건식; 
end loop; 

declare 
v_num number := 1; 
begin 
loop 
    dbms_output.put_line('v_num= '||v_num); 
    -- v_num의 값을 화면에 출력
    v_num := v_num + 1; 
    -- v_num의 값을 1씩 증가 
exit when v_num = 6;
-- or v_num > 5; 
end loop;
end; 
/

-- 아이디어 : i와 x 에 동시에 loop을 걸어준다 
declare
 i number;
 x number; 
begin 
    loop 
    dbms_output.put_line(i||' X '||x||' = '(i*x));
    
 
    for i in 2..9 loop 
    for x in 1..9 loop 
    exit when i,x > = 9 
end loop;
end; 
/

-- 아이디어2 : i에 loop을 걸고, 그걸 맞받아치는 loop을 걸어준다 
