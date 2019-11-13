/* Case ~ when 구문 
(1)
case 비교대상 
when 값1
then 비교대상 = 그 값1 이 만족할 때 실행할 문장; 
... 
else 비교대상이 위의 모든 값과 일치하지 않을 때 실행할 문장;  
end case; 
-- 같냐 다르냐의 구분 

(2) -- IF 비슷?똑같? 
case
when 조건식1 then 
 조건식1이 참일 때 실행할 문장; 
when 조건식2 then 
 조건식2이 참일 때 실행할 문장;  
 ...
 else 위의 모든 조건이 거짓일 때 실행할 문장 
 end case; 
-- 크다 작다도 구분 가능 
*/


-- (1) sample 
set serveroutput on;

accept p_grade prompt 'ENTER THE GRADE';

declare 
    v_score number := &p_grade;
begin 
    case trunc(v_score,-1)
    -- original thought: case trunc(v_score/10,0) > but here, it should be when 10 then ~ when 9 then ~ when 8 then~ 
        when 100 then 
        dbms_output.put_line('A');
        when 90 then 
        dbms_output.put_line('A');
        when 80 then 
        dbms_output.put_line('B');
        when 70 then 
        dbms_output.put_line('C');
        else 
        dbms_output.put_line('F');
    end case;

end;
/


-- (2) sample 
accept p_grade prompt 'Enter the Grade';

declare
    v_score number := &p_grade; 
begin
    case 
    when v_score >= 90 then
        dbms_output.put_line('A'); 
    when v_score >= 80 then 
        dbms_output.put_line('B');
    when v_score >= 70 then 
         dbms_output.put_line('C'); 
    else 
        dbms_output.put_line('F');
    end case; 
end;
/
    

