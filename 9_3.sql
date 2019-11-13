-- 조건문 (Conditional Statement) 
-- 어떤 조건에 맞는 경우에만 실행하는 문장을 만들어 준다. 
-- 지금까지는 문장을 만들 때 > 무조건 출력 ㅎㅎ... > 실행도 순서대로 (순서 바뀌지 않음) 
-- 이젠 문장들이 실행이 될 수도 있고, 안될 수도 있고, 아랫쪽을 실행했다가 위에로 올라가서 다시 실행 될 수도 있는 구조 

-- IF 
-- 만약에 ~ 을 만족하면 실행을 하겠습니다 
-- IF 조건식 then 
--    조건식이 참일 때 실행할 문장; 
--    end if;

-- IF statement example 1 
set serveroutput on;

declare 
    v_num number := 123;
begin 
-- if statement도 실행문이라 begin 과 end 사이에 들어감 
if mod(v_num,2) =1  then 
    dbms_output.put_line('홀수');
end if;
dbms_output.put_line('END PL/SQL');

end;
/
-- 코드가 같지만, 넣은 값에 따라서 출력문이 다르게 된다. 위에서도 v_num number := 123 하면 홀수, END PL/SQL 두 문장 출력, 124는 END PL/SQL 한 문장 출력 (끝) 

-- IF statement example 2 
-- 홀수 일 때는 홀수라고 말하고, 짝수 일 때는 짝수라고 말하는 코드를 만들어 보자,,,! 
-- if - then - else 
/* if 조건식 then 
    조건식이 참일 때 실행할 문장; 
    else 
    조건식이 거짓일 때 실행할 문장; 
    end if; */

accept p_num prompt 'ENTER THE NUMBER';

declare 
    v_test number := &p_num;
begin 
-- if statement도 실행문이라 begin 과 end 사이에 들어감 
if mod(v_test,2) =1  then 
    dbms_output.put_line('Odd Number');
else
    dbms_output.put_line('Even Number');
end if;
    dbms_output.put_line('END PL/SQL');
end;
/

declare 
    v_score number := 68;
begin 
    if v_score >= 90 then 
    dbms_output.put_line('A');
    elsif v_score >= 80 then 
    dbms_output.put_line('B');
    elsif v_score >= 70 then 
    dbms_output.put_line('c');
    else 
    dbms_output.put_line('F');
    end if; 
end;
/ 

-- 이거 안됨: 'V_GADE' 식별자가 정의되어야 합니다/ PL/SQL: Statement ignored (line 71) 
-- 이건 안됨: 왜 안되는지 모르겠음 (line 31 had a wrong spelling > learn to do it yourself,,,) 
-- the line said: 'V_GADE' 식별자가 정의되어야 합니다 > but it said 명령의 75 행에서 시작하는 중 오류 발생 -
-- what I thought: I cannot find anything wrong from line 24 (because it says which block is wrong not which line) 
-- what I could have done > since there are only few sentences which has 'V_GADE'; I could have checked those lines

accept p_grade prompt 'ENTER THE GRADE';

declare 
   v_grade number := &p_grade;
begin 
if v_grade >= 90 then 
    dbms_output.put_line('Congratulations! '||'Your hardwork deserves an '||'A');
elsif v_grade >= 80 then 
    dbms_output.put_line('Congratulations! '||'Your GRADE is '||'B');
elsif v_gade >= 70 then 
    dbms_output.put_line('You should put more effort! '||'Your GRADE is '||'C');
else
    dbms_output.put_line('You failed the subject :('||'Your GRADE is '||'F');
end if; 
    dbms_output.put_line('Enjoy your vacation!');
end;
/

-- The correct one: 
accept p_grade prompt 'ENTER THE GRADE';

declare 
   v_grade number := &p_grade;
begin 
if v_grade >= 90 then 
    dbms_output.put_line('Congratulations! '||'Your hardwork deserves an '||'A');
elsif v_grade >= 80 then 
    dbms_output.put_line('Congratulations! '||'Your GRADE is '||'B');
elsif v_grade >= 70 then 
    dbms_output.put_line('You should put more effort! '||'Your GRADE is '||'C');
else
    dbms_output.put_line('You failed the subject:( '||'Your GRADE is '||'F');
end if; 
    dbms_output.put_line('Enjoy your vacation!');
end;
/
-- 오답노트: line 82/ gade > grade 




-- 입력받은 숫자가 짝수인지 홀수인지 구분 
--1) if the number is a even number, print it as 'even number' 
-------- If it is an even number and a multiplier of 4, print it as 'MULTIPLIER OF 4' 
--------- If not, print it as 'NO, it is not' 
--2) if the number is an odd one, print it as 'odd number' 

accept p_number prompt 'ENTER THE NUMBER'; 

declare 
    v_number number := &p_number;
begin 
    if mod(v_number, 2)=0 then 
        dbms_output.put_line('EVEN NUMBER');  
        if mod(v_number, 4)=0 then 
            dbms_output.put_line('MULTIPLIER OF 4'); 
        else 
            dbms_output.put_line('NOT A MULTIPLIER OF 4');
        end if;
    else
        dbms_output.put_line('ODD NUMBER'); 
    end if;  
end;
/

select power(5,2) from dual;

-- Pythagoras Theorem (a^2 + b^2 = c^2) 
-- 숫자 3세 입력 (3각형의 3변의 길이) 
-- 피타고라스 정리를 이용해서 삼각형이 직각 삼각형인지 아닌지를 출력하세요 
-- 이것도 안됨,,^^ 
accept linea_A prompt 'Entre la linea A';
accept linea_B prompt 'Entre la linea B';
accept linea_C prompt 'Entre la linea C'; 

declare 
    v_A number := &linea_A;
    v_B number := &linea_B;
    v_C number := &linea_C;
begin 
If power(v_A,2) + power(v_B,2) = power(v_C,2) then 
    dbms_output.put_line('RIGHT TRIANGLE');
    else 
    dbms_output.put_line('NOT A RIGHT TRINGALE);
end if;
end;
/

-- 에러: 윗쪽이 실행이 되서 그렇다 (드래그해서 할 부분만 골라서 실행하니까 실행이 되었다) 

accept a prompt '삼각형 밑변의 길이?';
accept b prompt '삼각형 높이?';
accept c prompt '삼각형 빗변의 길이?';

begin 
    if power(&a,2) + power(&b,2) = power(&c,2) then 
        dbms_output.put_line('직각삼각형');
    else 
        dbms_output.put_line('Not 직각삼각형');
    end if; 
end;
/