-- 09.18.2109 
-- 예외처리 
set serveroutput on; 

declare 
    v_result number; 
    
begin 
    dbms_output.put_line('Before execution'); 
    select * into v_result from emp;
    dbms_output.put_line(v_result); 
    
end;
/

/*
예외/오류(exception/error) 처리 

declare 
-- 선언부: 변수, 타입 (record, collection) 선언, 커서 선언 
begin 
-- 실행부: 절차적으로 진행할 코드들을 작성 
>>>> new! exception 
-- 실행부(begin)의 코드들을 실행하다가 오류가 발생했을 때 처리하는 부분 
-- 그 예외를 처리하는 부분 
디버깅, DB의 정상 처리 같은 부분만 해결 
고쳐 줄 수 있다면 코드를 고치는게 제일 좋다 

exception formula: 
    when 예외 이름 then 
        해당 예외가 발생했을 때 처리할 코드; 
-- when 은 여러개가 올 수도 있다 
-- 예외이름이 없는 경우에는 
    when others then ... 
    위에서 선언한 예외들이 아니거나 또는 예외 이름을 모를 때 

end;
/

*/

-- 예외처리구문 

declare 
    v_result number; 
begin 
    dbms_output.put_line('예외 발생 전'); 
    v_result := 'TENGO_HAMBRE'; 
    dbms_output.put_line(v_result);

exception 
  when value_error then 
        dbms_output.put_line('Not a number'); 
end;
/

-- 에러 발생 > 하지만 코드를 모를 때: others 써주기 
declare 
    v_result number;
    
begin 
    dbms_output.put_line('Before the exception takes place');
    v_result := 123/0;
    dbms_output.put_line(v_result);

exception
    when others then 
        dbms_output.put_line('에러 코드'||sqlcode);
        dbms_output.put_line('에러 코드'||sqlerrm);
    when zero_divide then 
        dbms_output.put_line('0으로 나눌 수 없습니다.');
        
end;
/
-- OTHERS는 블록내의 예외 처리기 중 가장 마지막에 위치하여야 합니다


-- ORA 01476: the divisior is equal to zero 
-- link: https://www.techonthenet.com/oracle/errors/ora01476.php 

-- when 구문은 두개, 에러는 1개 

declare 
    v_result number;
    

begin 
    select * into v_result from emp where empno = 7788; 

exception 
    when value_error then 
        dbms_output.put_line('ValueError');
    when others then 
        dbms_output.put_line(sqlcode||' , '||sqlerrm);

end;
/
-- ERROR:  ORA-00947: 값의 수가 충분하지 않습니다
-- compilation error: 이건 우리가 exception 으로 처리할 수 없는 에러 
-- ORA-00947 not enough values/ 06550. 00000 -  "line %s, column %s:\n%s"
-- *Cause:    Usually a PL/SQL compilation error.
-- Cause: This error occurs when a SQL statement requires two sets of values equal in number, 
--but the second set contains fewer items than the first set. 
--This can occur in a WHERE or HAVING clause in which a nested SELECT returns too few columns as in:
-- can be solved using: WHERE (A,B) IN (SELECT C FROM ...) or INSERT INTO EMP(EMPNO,ENAME) VALUES('JONES')

-- compilation error > the upper code does not show the error but the lower code shows it 
-- different kinds of errors: 
--(1) compilation error -- grammatically wrong; so the process does not start from the beginning.
--                         so we cannot use the exception for the code to work, rather we have to fix it before we start the code 
-- SQL 혹은 PL/SQL 문법에 맞지 않아서 실행 자체가 되지 않는 오류. 문법에 틀린 부분을 찾아서 문법에 맞게끔 수정해야만 함 
-- 문법에 맞게끔 고치지 않으면 실행이 되지 않기 때문에 exception 처리가 되지 않는다. 
-- 우리가 작성한 코드는 컴퓨터 언어로 바꿔주는 과정: compile > compilation error = 번역 오류!! 

--(2) 실행중 에러(runtime error) 
-- grammatically correct, so it can be compiled, but an error occurs (실행 중에 어떤 이유로 발생하는 에러)  
--(so random huhuhuhu) > think this way: sometimes there are things that are grammatically correct but that does not make sense

declare 
  v_result number;
begin 
  select ename into v_result from emp where empno = 7788;  
exception 
    when value_error then 
        dbms_output.put_line('Value Error');
    when others then 
        dbms_output.put_line(sqlcode||' , '||sqlerrm);
end;
/

declare 
    v_result number; 
begin 
    dbms_output.put_line('예외 발생 전'); 
    v_result := 'TENGO_HAMBRE'; 
    dbms_output.put_line(v_result);

exception 
  when value_error then 
        dbms_output.put_line('Not a number'); 
end;
/

declare 
  v_result number;
  v_row emp%rowtype;
begin 
  select * into v_row from emp;  
  dbms_output.put_line('v_row.ename');
exception 
    when value_error then 
        dbms_output.put_line('Value Error');
    when too_many_rows then 
        dbms_output.put_line('too many rows');
    when others then 
        dbms_output.put_line(sqlcode||' , '||sqlerrm);
end;
/
-- too many rows (ORA ...) 
-- 내꺼 문제 메시지가 안뜸 ㅠㅜ 왜지 > 프로시져는 성공적으로 된다 set serveroutput on; 을 안눌러서,,, 됴르륵 





