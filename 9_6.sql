-- 1. ������ (2~9��)�� ��� -- �� �߰� 
--2. �������� ���. 2���� 2*2 ����, 3���� 3*3����, ... 9���� 9*9���� 


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

-- ���� �� ��ü�� Ʋ�� : ó���� �밡�ٷ� �Ѱ� �¾Ҿ��� 

--  if i=9 then 
  --  dbms_output.put_line ('------------------------');
   -- end if; 
-- how to put a dotted line: https://www.w3resource.com/plsql-exercises/cursor/plsql-cursor-exercise-45.php 
loop 
�ݺ��� ����;  
exit when ���ǽ�; 
end loop; 

declare 
v_num number := 1; 
begin 
loop 
    dbms_output.put_line('v_num= '||v_num); 
    -- v_num�� ���� ȭ�鿡 ���
    v_num := v_num + 1; 
    -- v_num�� ���� 1�� ���� 
exit when v_num = 6;
-- or v_num > 5; 
end loop;
end; 
/

-- ���̵�� : i�� x �� ���ÿ� loop�� �ɾ��ش� 
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

-- ���̵��2 : i�� loop�� �ɰ�, �װ� �¹޾�ġ�� loop�� �ɾ��ش� 
