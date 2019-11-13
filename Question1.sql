declare 
    x number; -- 주사위1의 값을 저장할 변수  
    y number; -- 주사위2의 값을 저장할 변수 
    trials constant number := 100;
begin 
for i in 1..trials loop 
    x := trunc((dbms_random.value(1,7)),0); 
    y := trunc((dbms_random.value(1,7)),0);  
    dbms_output.put_line(x||','||y);
    exit when x = y;  
end loop;  

end;
/ 

