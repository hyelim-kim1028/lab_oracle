-- 반복문 (refer to the teacher's note) 
/*
--(1) LOOP 
loop 
반복할 문장;  
exit when 조건식; 
end loop; 
- end loop 에서 끝나는게 아니라 > 거기를 치고, 다시 처음으로 > 조건을 주지 않으면 무한루프가 된다 
- 그래서 중간에 조건을 줌으로써 멈춰준다,,, 멈추기 위한 조건 

(2) while loop 
while conditional statement loop 
    반복할 문장 when the condition is TRUE 
    end loop;
- 반복을 위한 조건 

(3)for loop 
for 변수 in 시작값 ... 마지막값 loop 
    반복할 문장; 
end; 
 -- for loop 에서 사용하는 변수는 declare 에서 변수를 선언하지 않고, for 옆에 바로 써줌 
 -- 자동으로 변수는 반복될 때 마다 1씩 증가? 
  
  - exit  은 모든 루프에서 사용 가능 (the basic loop, while loop, for loop...) 
  - exit: used to terminate the loop 
  
*/

set serveroutput on;

-- loop을 이용하여 1부터 5까지 출력 
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

declare 
v_num number := 1;
begin 
loop 
    dbms_output.put_line('2 X '||v_num||' = '||(2*v_num));
    v_num := v_num + 1;
    exit when v_num > 10;
    end loop;
end;
/

--(2) while loop
declare 
    v_num number := 1;
begin 
    while v_num <= 5 loop 
    dbms_output.put_line('v_num= '||v_num); 
    v_num := v_num +1;
    end loop; 
end;
/
                                                                                        
-- 한번도 출력되지 않게 되도록 만들수도 있다
declare 
    v_num number := 1;
begin 
    while v_num > 5 loop 
    dbms_output.put_line('v_num= '||v_num); 
    v_num := v_num +1;
    end loop; 
end;
/

-- loop은 처음에 조건검사하는 라인이 없기 때문에 적어도 한번은 실행된다 
-- 무한히 되도록 만들 수도 있다 (조건이 늘 참) 

-- while loop 을 가지고 구구단 3단 출력 
declare 
    v_num number := 1;
begin 
    while v_num <= 9 loop 
    dbms_output.put_line('3 X '||v_num||' = '||(3*v_num));
    v_num := v_num + 1;
    end loop;
end;
/ 

-- (3) for loop 1~5까지 출력 
begin 
    for i in 1..5 loop 
    dbms_output.put_line('i = '||i);
    end loop; 
end;
/
-- i 가 1부터 5까지 범위 안에 있으면 실행하겠습니다 
-- i는 자동으로 1씩 증가해요 (범위 안에서 증가해요) 
-- i for index (page number..?) 
-- for loop을 이용한 구구단 4단 
begin 
    for i in 1..9 loop 
    dbms_output.put_line('4 X '||i||'='||(4*i));
    end loop; 
end;
/

-- How EXIT is used in while & for loop 
-- EXIT IN WHILE LOOP 
declare 
    v_num number := 1; 
begin 
    while v_num <10 loop 
    dbms_output.put_line('v_num = '||v_num);
    v_num := v_num + 1;
    exit when v_num = 5; -- 4까지만 되고 끝나버러쓰,,, 이거 없으면 9까지 (루프가 끝나는 조건이 걍 2개인거지,,) 
    end loop; 
end; 
/

begin 
    for i in 1..10 loop 
    dbms_output.put_line('i = '||i);
    exit when i = 5;
    end loop;
end;
/

-- while loop 1~5 출력/ 다른 방법들 / exit 이 중간/ 처음에 있어도 된다 / 조건을 만족할 때에 루프를 빠져나가는 것 이니까 

declare 
    v_num number := 1; 
begin 
    while v_num <10 loop 
    dbms_output.put_line('v_num = '||v_num);
    v_num := v_num + 1;
    exit when v_num > 5; 
    end loop; 
end; 
/


declare 
    v_num number := 1; 
begin 
    while v_num <10 loop 
    dbms_output.put_line('v_num = '||v_num);
    exit when v_num = 5;
    v_num := v_num + 1;
    end loop; 
end; 
/

-- for loop 에서 범위의 역순으로 감소시키면서 반복 
begin 
    for i in reverse 1..5 loop
     dbms_output.put_line('i = '||i);
     end loop;
end; 
/

-- 반복문(loop,while,for) 안에서 
-- 1) exit when 조건식: 조건식에 만족하는 경우 반복문을 종료 
-- 2) continue when  조건식: 조건식을 만족하는 경우 반복을 처음부터 다시 시작해라

begin 
    for i in 1..10 loop 
        continue when mod(i,2) = 0;
    dbms_output.put_line(i);
    end loop;
end;
/
-- 홀수만 출력 (1,3,5,7,9) 
--  continue는 밑으로 내려오라는게 아니라, 아랫쪽 문장 무시하고, 그냥 위로 올라가라는 이야기,,, 
-- false가 됐으니까 밑으로 내려온거야,,, 나머지가 있으니까 1이 출력되고, 조건을 만족한 2는 올라가서 사라지고,,, 
-- 조건에 부합하면 위로 올라가고, 부합하지 않으면 내려감 
-- 2씩 증가시키면 같은 아이들로 나옴 

/* 1,3,5,7,9 = 2*0 + 1 , 2*1+1, ..*/ 

begin 
    for i in 0..4 loop 
        dbms_output.put_line(2*i+1);
    end loop; 
end; 
/



