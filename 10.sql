-- 09092019 HOMEWORK RESULTS 
-- TEACHER'S SOLUTION 
set serveroutput on;
-- 1. Multiplication from 2~9 
-- A. LOOP

declare 
    v_dan number := 2; 
    v_x number := 1;
begin 
    loop
    v_x := 1; 
        loop 
            dbms_output.put_line(v_dan||' X '||v_x||' = '||(v_dan*v_x)); 
            v_x := v_x +1; 
            exit when v_x = 10; 
       end loop; 
       dbms_output.put_line('-------------------');
      v_dan := v_dan+1; 
        exit when v_dan = 10; 
    end loop; 
end;
/

-- 1. 3단, 4단, 5단... 반복 할 수 있다 
-- 이 때, n * x 의 n의 자리의 반복 > 이렇게 하려면 loop 를 loop시키면 된다 loop(loop()) 
-- without v_x := 1 on the first loop, it does not work because of v_dan
  -- 아래의 루프가 끝나면 계속 10으로 해서 아래의 루프만 무한 반복이 되는거임! 1부터 시작하기 위해서는 말해주자! 1부터 시작하자고 
     --  sin esta frase, no se funciona porq desde de loop dentro> ha hecho 2*1 ... 2*9. Entonces, que hace es empieza del v_x =10.
     -- es la razon que no funciona. Para empieze del 1 en v_dan, tener que indicar que v_x := 1

--B. WHILE LOOP 
declare 
    dan number; 
    n number;
begin 
    dan := 2; 
    while dan < 10 loop 
        dbms_output.put_line(dan||'단');
                -- 해당 단 (2단, 3단,..9단) 출력 
            n := 1;
            while n<10 loop
            dbms_output.put_line(dan||' X '||n||' = '||(dan*n));
            n := n+1; 
            end loop;
        dbms_output.put_line('--------------');
        dan := dan + 1; 
    end loop; 
end;
/

--C. FOR LOOP 
 
begin 
 for dan in 2..9 loop
 dbms_output.put_line(dan||'단'); 
    for n in 1..9 loop 
    dbms_output.put_line(dan||' X '||n||' = '||(dan*n));
    end loop; 
 dbms_output.put_line ('--------------------');
 end loop; 
end;
/

-- 섞어서 사용해도 된다!! :) 
-- 집에가서 연습해보기 :) 


--2.
-- 구구단 (2~9단)을 출력 
-- 2단은 2*2 까지, 3단은 3*3 까지,,, 
-- basic loop + while loop 둘 다 사용해서 스스로 해보기 :-) 

-- for loop 

begin
    for dan in 2..9 loop
    dbms_output.put_line(dan||'단');
    
        for n in 1..9 loop 
        dbms_output.put_line(dan||' X '||n||' = '||(dan*n));
        exit when dan = n;
        -- 자기가 포함되어 있는 루프만 빠져나옴. 그 다음루프는 다시 시작 
        end loop; 
        
         dbms_output.put_line ('--------------------');
    end loop; 
end;
/


-- exit을 사용하지 않고 하는 방법 
begin
    for dan in 2..9 loop
    dbms_output.put_line(dan||'단');
    
        for n in 1..dan loop 
        dbms_output.put_line(dan||' X '||n||' = '||(dan*n));
        end loop; 
        
         dbms_output.put_line ('--------------------');
    end loop; 
end;
/

--3. 무작위로 던진 동전에서 앞면과 뒷면이 나올 확률이 1/2임을 증명하세요 
--(1) dbms_random.value(x,y)함수를 사용해서 0 또는 1을 무작위로 출력하는 
-- x <= r < y 

select dbms_random.value(0,1) from dual;
-- 0 부터 0.999999 의 숫자를 리턴 
select dbms_random.value(0,2) from dual;
-- 0 부터 1.9999999 의 숫자를 준다 
-- 여기서 소숫점을 모두 잘라주면, 0 혹은 1의 값만 나오게 된다 (r = 0 or 1) => trunc 

--(2) (1) 에서 작성한 코드를 ㅜ정해서 
select trunc(dbms_random.value(0,2),0) from dual;
-- (2) (1)에서 작성한 코드를 수정해서, 
-- 난수가 0이면 '동전 앞면(head)', 1이면 '동전 뒷면(tail)'이라고 출력하는 PL/SQL을 작성하세요.(if statement, 0= head, 1=tail)

declare 
    v_coin number; -- 0 또는 1(동전의 앞/뒷면)을 저장할 변수 
    v_head number := 0; -- if statement 가 끝나고 -- (v_coin = 0일 때, 카운트를 1씩 증가시킬 변수) 
    v_tail number := 0; --(v_coin = 1일 때, 카운트를 1씩 증가시킬 변수) -- 어디서부터 1을 증가시킬 것인가에 대한 초기값이 필요하다 
    v_trials constant number := 1000
    ; -- 실험(반복)횟수 (하지만 이렇게하면 바꿀 수 없지 켈켈) > 1000 이 있는 곳 모두를 수정해주자...!> 
                                     -- before: 실험횟수를 바꾸기 위해서는 3개의 줄을 수정> 현재: 1개 
                                     -- 가능한 소스코드를 적게 수정할 수 있도록 하라...!! (변수를 선언하면 나중에 코드를 유지, 보수 하기 쉽다) 
    
begin 
for i in 1..v_trials loop
    v_coin := trunc(dbms_random.value(0,2),0); 
   --dbms_output.put_line(v_coin);
    if v_coin = 0 then 
      v_head := v_head + 1;
     --   dbms_output.put_line(HEAD);
    else 
    v_tail := v_tail +1;
      --  dbms_output.put_line(TAIL);
    end if; 
end loop;   
dbms_output.put_line('앞면: '||v_head||'확률: '||(v_head/v_trials));
dbms_output.put_line('뒷면: '||v_tail||'확률: '||(v_tail/v_trials));
end; 
/
-- for loop  을 써서 1000번 반복 
-- (3) 0 또는 1을 랜덤하게 만드는 과정((1) 코드)을 1000번 반복해서, 0과 1의 발생 횟수를 저장하고,
-- 0이 나온 횟수 / 전체 횟수, 1이 나온 횟수 / 전체 횟수 를 계산
-- 횟수/1000 > 0.5,0.5, 0.510,0.487 ... 
-- 실험을 1000 번 했다...!! 실험의 횟수를 다르게하면 > for loop 옆, 확률 옆 ... 바꿔야한다 


--4. 몬테카를로 알고리즘을 이용한 pi의 근사값(3.141592...) 계산
-- (1) dbms_random.value() 함수를 사용해서, 2차원 좌표평면(x-y) 위의 점의 좌표 (x, y)를 무작위로 만듦.
-- 단, 0 <= x < 1, 0 <= y < 1
-- (2) sqrt(x ** 2 + y ** 2 )< 1을 만족하면 v_hit 변수의 값을 1 증가 -- 1)에서 만들어진 x,y의 값을 가지고 거리계산을 해서, ... 
--> x^2 + y^2 < 1
-- (3) (1), (2)의 과정을 1000번 반복
-- (3) (v_hit / 1000) * 4를 계산한 값을 출력

declare 
    x number; -- x좌표의 값을 저장할 변수 
    y number; -- y좌표의 값을 저장할 변수 
    hit number := 0; -- 원점에서의 거리가 1 미만인 경우 1씩 증가시킬 변수 
    trials constant number := 1000;
   pi number;
begin 
for i in 1..trials loop 
    x := dbms_random.value(0,1);
    y := dbms_random.value(0,1); 
    dbms_output.put_line(x||','||y);
   -- 좌표편명상에 점을 찍은 것이다~ 
    if sqrt(x**2 + y**2) < 1 then 
        hit := hit + 1; 
    end if; 
end loop;  
    dbms_output.put_line('hit = '||hit); -- 대락 800번 정도
    pi := (hit/trials)* 4;
    dbms_output.put_line('pi = '||pi);
end;
/ 
-- 3.14와 가까운 값이 나온다 
