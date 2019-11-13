--09.19.2019 
/*
<Procedure vs Function> 
1. Procedure 
    a. 특정 로직을 수행하기만 하고, 명시적으로 반환(return)하지 않는 서브 프로그램 
    b. 실행: 다른 PL/SQL(프로그램) 내부에서 실행됨 (declare - begin - end;/). SQL 문에서는 실행될 수 없음 (select, update...).  
    c. 파라미터: in, out, inout 모드들을 사용할 수 있다 
    d. 반환: 명시적을 return 문을 사용한 반환을 할 수 없음. 
    out/inout 파라미터를 통해서 1개 이상의 값을 반환할 수는 있음 > 여러개 값을 한번에 리턴도 가능 
    
    
2. Function 
    a. 특정한 기능을 수행하고, 수행한 뒤 반드시 결과값을 명시적으로 반환하는 서브 프로그램 
    b. 실행: 다른 PL/SQL (프로그램) 내부 또는 SQL 문장 안에서 실행될 수 있음. 
    c.in 파라미터만 사용: in 모드의 파라미터만 사용. in은 생략 
      (out, in out 도 사용되기는 하지만, sql문장에서 사용 될 수 없다
       >프로시져와 펀션의 경계가 모호하고, 오라클에서도 함수에서 out 파라미터를 사용하지 않기를 권하고 있다)  
    d. 반환: 함수는 반드시 리턴문을 사용해서 한개의 값을 반환해야한다! (2개, 3개 안되구요, 무조건 1개) 

함수를 선언하는 방법 
    create [or replace] function 함수이름 [(
        파라미터 1 데이터 타입,
        파라미터 2 데이터 타입, 
        ... 
    )] return 리턴타입 *** 
    is 
    begin 
    [exception] 
    end;
    /
*/

set serveroutput on;

-- 더하기 가지고 함수 만들기 
    create or replace function my_add(
        p_x number,
        p_y number
    ) return number -- 요기까지가 선언 my_add 는 숫개 2개 (p_x 와 p_y)를 받으면 1개의 값을 number 로 반환하겠다 
    is 
        v_result number; -- 리턴값을 저장하기 위한 변수 
    begin 
        v_result := p_x + p_y;  -- 두 값을 저장을 해서 저장해 주는 것 
        return v_result;        -- 함수를 호출한 곳으로 값을 반환( return)/ 리턴 명시 
    end;
    /

-- 오라클 내장 함수의 결과값을 확일할 때 dual 더미 테이블 이용 

select upper('itwill') la_academia from dual;

-- 우리가 작성하는 함수도 SQL문으로 결과값(return value)을 확인할 수 있다 
select my_add(3,7) from dual; -- p_x = 3, p_y = 7 

--함수는 PL/SQL에서도 사용 가능 
declare 
    v_result number; 
begin 
    v_result := my_add(100,200);
    dbms_output.put_line(v_result);
end;
/

-- 숫자 두개를 파라미터로 전달받아서 뺄셈의 결과를 리턴하는 함수 작성/테스트 
-- 문자열 두개를 파라미터로 전달받아서 두 문자열을 하나로 합친 문자열을 리턴하는 함수 

-- select 'p_x'||' - '||'p_y'
--   from dual; 
-- idea from: https://www.techonthenet.com/oracle/functions/concat2.php

-- 내가 풀었던 것 

create or replace function my_sub(
    p_x number,
    p_y number 
    )return number 
is 
    v_x varchar2;
    v_y varchar2; 
begin 
    select p_x, p_y into v_x,v_y from dual; 
  return 'v_x'||' - '||'v_y';
end;
/

select my_subt(7,3) from dual;
-- I think too complicated: which means I am lack the understanding nor have enough basic language to use the language 


--Teacher's Solution 
create or replace function func_sub(
    p_x number,
    p_y number 
    )return number 
is 
begin
  return p_x - p_y;
end;
/

select func_sub(1,2) from dual;

declare 
    v_result number;
begin 
    v_result := func_sub(123,100);
    dbms_output.put_line(v_result);
end;
/

create or replace function my_concat(
    str1 varchar2, 
    str2 varchar2 --문자열의 크기 쓰지 말아주세요 
)return varchar2 
is 
    v_result varchar2(1234); -- 여기선 varchar2의 크기를 선언해줘야함 
                            -- 선언은 등호가 들어가지 않아요 ㅠㅠㅜ!!!!!!!!!!!
begin 
    v_result := str1 || str2; 
    return v_result;  
--return str1||str2;
end;
/


select my_concat(1,2) from dual;

select my_concat('Hello ','World') from dual;

declare
    v_result varchar2(100);
begin 
    select my_concat(ename ,job) into v_result
    from emp 
    where empno = 7788;
    dbms_output.put_line(v_result); 
end;
/

--파라미터는 몇개가 필요할까 > p_total의 프로시져에서 in의 파라미터들 2개 > 여기선 2개 필요 
-- 사번과 tax rate(세율)을 파라미터로 전달 받아서 
-- 총 급여를 계산해서 리턴하는 함수 작성 
-- SQL, PL/SQL을 사용하여 테스트까지 

-- WHAT I'VE DONE 
create or replace function func_total( 
    p_empno emp.empno%type,
    p_tax   number := 0.05
) return number 
is 
    v_sal emp.sal%type;
    v_comm emp.comm%type;
    v_total number;
begin
    select sal, comm into v_sal, v_comm from emp where empno := p_empno;
    v_total := (v_sal + nvl(v_comm,0)) * (1-p_tax); 
    return v_total;
end;
/

-- TEACHER's SOLUTION 
-- 여기 다시 보기 (the default tax rate doesnt work in the processing part) 
create or replace function func_total( 
    p_empno emp.empno%type,
    p_tax   number := 0.05 
) return number 
is 
    v_total number;
begin
    select (sal + nvl(comm,0)) * (1-p_tax)
    into v_total 
    from emp
    where empno = p_empno;
    
    return v_total; 

end;
/

select empno,ename,sal, comm, func_total(7839) 
from emp 
where empno = 7839;

-- 만약 
--create or replace function func_total( 
--    p_empno emp.empno%type := 7788,
--    p_tax   number 
--여기서 택스는 디폴트가 없고, ,empno 에만 티폴트를 주고 실행 시키면 어떻게 될까? 
--안된다. 순서대로 값을 입력 > 앞이 empty이고, 뒤만에 무얼 줄 수 없다 
-- 아니면 (p_tax=>0.1) 이렇게 써도 됨 



create or replace function func_total2( 
    p_empno emp.empno%type := 7788,
    p_tax   number  
) return number 
is 
    v_total number;
begin
    select (sal + nvl(comm,0)) * (1-p_tax)
    into v_total 
    from emp
    where empno = p_empno;
    
    return v_total; 

end;
/

select empno,ename,sal, comm, func_total2(p_tax => 0.1) 
from emp 
where empno = 7788;

-- 하지만 func_total2(p_tax => 0.1) 은 번거로우니, 가능하면 디폴트를 갖지 않는 변수들을 앞에 쓰고, 뒤에 디폴트를 갖는 변수들을 써주자 
-- 순서바꿀 수도 있음 (p_tax => 0.1,p_empno=>7788)

-- RECORD/LOOP 을 사용한 코드 (좀 이따 쌤 파일에서 베끼끼) 
create or replace function func_total3( 
    p_empno emp.empno%type := 7788,
    p_tax   number  
) return number 
is 
    v_total number;
begin
    select (sal + nvl(comm,0)) * (1-p_tax)
    into v_total 
    from emp
    where empno = p_empno;
    
    return v_total; 

end;
/

select empno,ename,sal, comm, func_total2(p_tax => 0.1) 
from emp 
where empno = 7788;









-- 수학적함수 만들기 factorial 
-- fact(0) = 0! = 1/ fact(1) = 1! = 1*1 = 1/ fact(2) = 2! = 1*2 = 2/ fact(3) = 3! = 1* 2*3 = 6

-- my code > brain fried 
create or replace function f_fact( 
   param_1 number 
) return number 
is 
    v_fact number;
begin
     for r in 1..5 loop 
        v_x := v_x ;
            if r = 0 then 
            dbms_output.put_line(1) 
            end if; 
        r+1 
     end loop; 
     return v_fact;
end;
/

-- Teacher's Solution : 이것도 좀 이따 베끼기 
    create or replace function my_factorial (n number) return number 
    is 
        v_result number := 1; -- 계산 결과를 저장할 변수 
        
    begin
        for i in 1..n loop 
        v_result := v_result * i; 
        end loop; 
        
        return v_result;
    end;
    /

-- 인수, 변수, 매게변수(매게 like a mediating variable)  


begin 
    for n in 0..5 loop 
        dbms_output.put_line(my_factorial(n));
    end loop; 
end;
/

-- for loop을 사용하지 않고 하는 방법 

create or replace function factorial2 (n number) return number 
is  
    v_result number := -1; 
begin
    if n = 0 then -- n refers to the n in the parameter  
        v_result := 1; 
        elsif n>0 then 
            v_result := factorial2(n-1)*n;
    end if; 
        
    return v_result;
end;
/
-- 문제: 1팩토리얼은 계산이 안됨 (1-1) * 1 = 0*1 =0 뒤에서 꼬리를 물고 0 으로 계산 
-- 재귀호출(recursion): 함수가 함수 내부에서 자기 자신을 다시 한번 호출 하는 것 
-- 구연은 간단하지만 이 재귀가 끝날 수 있는 조건을 만들어줘야한다 (여기서는 0!밑으로 내려가면 안된다) 

begin 
    for n in 0..5 loop 
    dbms_output.put_line(factorial2(n));
    end loop;
end;
/

/*
Parameter(매게변수, 인자) vs Argument(인수, 전달인자) 

> Parameter: 함수나 프로시져를 정의할 때 전달받는 값을 저장하기 위해 선언하는 변수  
    create procedure proc_name(pram1 number, param2 varchar2, ... ) 
     create function func_name(pram1 number, param2 varchar2, ... )
> Argument: 함수, 프로시저를 호출할 때 전달하는 값 
    proc_name(123, 'abc');
    func_name(100,'가나다'); 
*/









