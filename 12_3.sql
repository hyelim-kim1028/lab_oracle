--09.19.2019 ex_pkg_test
-- ex_pkg.spl 에서 작성한 패키지의 함수들을 테스트 

---- 패키지의 본문(본체, body)를 작성
--create or replace package body my_pkg
--is
--    -- 패키지 명세에 선언된 함수를 구현
--    function my_add(p_x number, p_y number) return number
--    is
--    begin
--        return p_x + p_y;
--    end my_add;
--end;
--/
--
--
--select my_pkg.my_add(1, 2) from dual;
--
--declare
--    v_result my_pkg.rec_emp_sal;
--begin
--    dbms_output.put_line(my_pkg.num1);
--    my_pkg.my_proc(7788);
--end;
--/
--    
    
create or replace package my_stat 
is
    -- 타입 선언
     type NumberArray is table of number index by pls_integer; 
    
    -- 함수 프로토타입 선언
    function sum (arr NumberArray) return number;
    function avg (arr NumberArray, trunc(digit number,3)) return number; 
    function var (arr NumberArray, trunc(digit number,3)) return number; 
    function std (arr NumberArray, trunc(digit number,3)) return number; 
    function max (arr NumberArray) return number;
    function min (arr NumberArray) return number;
    -- trunc 를 쓰는 것과 같은 함수를 만들기 
end;
/    

create or replace package body my_stat
is
-- create or replace function my_add(
--        p_x number,
--        p_y number
--    ) return number -- 요기까지가 선언 my_add 는 숫개 2개 (p_x 와 p_y)를 받으면 1개의 값을 number 로 반환하겠다 
--    is 
--        v_result number; -- 리턴값을 저장하기 위한 변수 
--    begin 
--        v_result := p_x + p_y;  -- 두 값을 저장을 해서 저장해 주는 것 
--        return v_result;        -- 함수를 호출한 곳으로 값을 반환( return)/ 리턴 명시 
--    end;
--    /

create or replace function my_sum(
     v_sum number 
    )return number 
    is 
begin 
    v_sum := 0;
for i in 1..arr.count loop
    v_sum := v_sum + v_arr(i); 
    end loop;0
        return v_sum
end;


create or replace function my_avg(
     v_avg number 
    )return number 
    is 
begin 
    v_sum := 0;
    v_avg := v_sum / v_scores.count;
        return 
end; 

create or replace function my_var(
     v_var number 
    )return number 
    is 
begin 
   v_ss := 0;
    for i in 1 .. v_scores.count loop
        v_ss := v_ss + (v_avg - v_scores(i)) ** 2;
    end loop;
    v_var := v_ss / (v_scores.count - 1);
        return trunc(,3) 
end; 

create or replace function my_std(
     v_std number 
    )return number 
    is 
begin 
    v_std := sqrt(v_var);
        return trunc(,3) 
end; 

create or replace function my_max(
     v_max number 
    )return number 
    is 
begin 
    for i in 2..v_scores.count loop 
    v_max := v_scores(i); 
        if v_max >= v_scores(i) then 
        v_max := v_scores(i); 
         end if; 
     end loop; 
        return 
end; 



create or replace function my_min(
     v_avg number 
    )return number 
    is 
begin 
    for i in 2..v_scores.count loop 
      v_min := v_scores(i); 
        if v_min >= v_scores(i) then 
        v_min := v_scores(i); 
         end if; 
    end loop; 
        return 
end; 

        
        
        
        
        
        
        
        
end;
/

    
    
    
    
    
    
