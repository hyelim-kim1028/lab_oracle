--20190909 14.1 EXERCISE 1 - LOOP/CONDITIONAL 

set serveroutput on;

-- 옆으로 출력하는 경우 
begin 
    dbms_output.put_line('hello'); 
    dbms_output.put_line('world'); 
    -- 이 경우, 화면에는 한줄, 한줄 출력이 된다. 
    dbms_output.put('Tiger');
    dbms_output.put(' is a cat');
    -- 윗쪽 두개는 출력이 되지만, 이건 되지 않는; output 에는 들어가 있지만 마지막 엔터가 없어서 화면에 출력되지 않음 
    dbms_output.new_line;
    -- 출력이 된다 : 옆으로 된다 (줄 바꿈기호가 들어가줘야 출력이된다) 
end;
/

--화면에 ***** 출력 
begin 
    dbms_output.put_line('*****');
end;
/

begin 
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.new_line;
end;
/

begin 
    for i in 1..5 loop 
    dbms_output.put('*');
    end loop;
    dbms_output.new_line;
end;
/

begin 
    dbms_output.put_line('*');
    dbms_output.put_line('**');
     dbms_output.put_line('***');
    dbms_output.put_line('****');
    dbms_output.put_line('******');
    
end;
/

--아래와 같이 출력하는 PL/SQL 을 작성하시오 
/* *
   **
   ***
   ****
   ***** */
   
begin 
    for dan in 1..5 loop 
        dbms_output.put('*');
        for i in 1..5 loop 
            dbms_output.put('*');
        end loop; 
    end loop;
    dbms_output.new_line;
end;
/
-- 위) 내가 시도해 본 것: 틀림 
-- ***** 개 짜리를 5번 반복해둔거라고 생각해보자 

begin 
    for i in 1..5 loop 
    dbms_output.put_line('*****');
    end loop;
end;
/

-- 그리고,, 

begin 
    for i in 1..5 loop 
        for j in 1..5 loop
            dbms_output.put('*');
            exit when i = j; 
        end loop;
        dbms_output.new_line;
    end loop;
end;
/
-- 그럼 결과는 똑같은 결과를 가져온다 > 이제 조건을 붙인다 exit when i = j; 
-- 안쪽 루프만 빠져나오게된다 (바깥쪽 루프는 다시 있으니까,,?) 괜찮아짐 


begin 
    for i in 1..5 loop 
        for j in 1..i loop
            dbms_output.put('*'); 
        end loop;
        dbms_output.new_line;
    end loop;
end;
/
-- exit을 안 쓸 때 


-- using the while clause 
declare 
    n number 
begin 

end;
/ 



--아래와 같이 출력하는 PL/SQL 을 작성하시오 
-- reverse loop 
begin 
    for i in 1..5 loop -- 이건 행번호라 안바뀜 
        for j in reverse 1..5 loop
            dbms_output.put('*');
            exit when i = j; 
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

-- or 
-- reverse 안쓰고 하는 법!
begin 
    for i in 1..5 loop -- 이건 행번호라 안바뀜 
        for j in i..5 loop
            dbms_output.put('*');
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

/*-- 다음과 같이 출력하는 문장을 만들어라 
12345678910
11 12 13 14 ... 20 
21 22 23 24 25 ... 30 
...
91 92 93 94 ... 100
*/

-- 이 세개 살려보기 
begin 
    for i in 1..10 loop 
         for j in 1..i loop 
            dbms_output.put(number);
        end loop; 
    end loop; 
    dbms_output.new_line; 
end loop;
end;
/

declare 
    n number; 
begin 
for in 1..10 loop 
    loop n = n + 1;
    dbms_output.put(n) 
    end loop; 
    dbms_output.new_line;
end loop; 
end;
/

-- 으엉 
declare 
    n number := 1;
    i number := 1; 
begin 
loop 
    n := 1; 
    for i in 1..9 loop 
     dbms_output.put_line((10 * n ) - i); 
    end loop; 
    
end loop; 
end;
/


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


