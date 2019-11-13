--09.19.2019 PACKAGE 
-- 프로시져가 들어있는 곳 (package: where the procedure is stored) 

-- 콘솔창에 입력해야하는 것들을 / 연관된 것들을 / 모아둔 것 (모듈화) 
-- 비슷하고 관련된 기능들을 하나로 모아서 사용할 수 있게끔 해둔것이 패키지 
-- PL/SQL 만드는 것과 비슷하지만, function, procedure 을 만드는 것과는 조금 다르다 
-- i.e. dbms_output.putline, dbms_random 
-- 스펙이 specification 줄임말 이였어???? ㅋㅋㅋㅋ(spec) 


/*
Package 
- 기능 안에서 연관성이 높은 프로시저, 함수, 타입 (레코드, 컬렉션), 커서 등을 모아둔 서브 프로그램 
- When creating a package: 패키지의 명세 (specification)와 본문(body)를 따로 만들어야한다/ 선언해야한다 
-- 주 사용처: 자주, 반복적으로쓰는 레코드를 저장 

    패키지 명세 
        create [or replace] package 패키지이름 
        is 
            -- 타입 혹은 프로시저/함수 프로토타입 등은 선언
            ...
        end;
        /

    패키지 본문(본체):
        create [or replace] package body 패키지 이름 
        is 
            패키지 명세(스펙)에서 선언된 프로시저/함수 등을 구현 
            -- 패키지 명세에서 디테일들을 가져와서 구현 
*/

-- 패키지 명세(스펙) 작성 
create or replace package my_PKG 
is 
    -- type 선언 
    type rec_emp_sal is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal   emp.sal%type
    ); 
    
    --변수 선언 
    num1 number := 0;
    
    -- 프로시저 프로토타입 (prototype) 선언 
    -- 본문을 만들지 않는 것..?? 만드는게 아니구?? 
    procedure my_proc (p_empno number); 
    -- 원래의 프로시져는 비긴과 엔드 사이에서 무엇을 해야할지 적어준다 하지만 이건 이즈 비긴 엔드가 없음 > 그런걸 프로토타입이라고 부름 
    -- 이름은 있으니까 부를 순 있지만 뒤에가 없음 > 진짜 자주 사용하는 것의 프로토타입을 만들어 두는 것 
    
    -- 함수 프로토타입 선언 
    function my_add(p_x number,p_y number) return number;
end;
/

-- 바디를 컴파일 하지 않아도 아무런 문제가 되지 않는다 
-- my_add 를 사용해보자 

select my_add(1,2) from dual;
-- 이렇게 쓰면 우리가 만들어둔 함수를 찾아 간다 
-- 하지만 우리는 패키지가 가지고 있는 마이 어드를 사용하고 싶은 것 

select my_PKG.my_add(1,2) from dual;
-- dbms_output.put_line과 매우 흡사하게 생김 
-- my_pkg.my_add => my_pkg > 패키지 따라감 / . > 패키지 안에 함수 있다 (앞 안에 뒤 있다)/my_add > 함수

-- 아직 실행 불가 
-- ERROR:  package body "SCOTT.MY_PKG"이(가) 존재하지 않습니다. 
-- 4067. 00000 -  "not executed, %s does not exist"
--*Cause:    Attempt to execute a non-existent stored procedure.
--*Action:   Make sure that a correct name is given.

-- 패키지 바디 작성 
create or replace package body my_PKG
is 
    -- 패키지 명세에 선언된 프로시저 구현 
    procedure my_proc(p_empno number)  --- pkg 안에서는 create 같은 것 쓰지 않음 
    is 
        v_result my_PKG.rec_emp_sal; 
    begin 
        select empno, ename, sal  -- rec_emp_sal 의 변수들 
        into v_result 
        from emp 
        where empno = p_empno; 
        
        dbms_output.put_line(v_result.empno||' , '
                             ||v_result.ename||' , '
                             ||v_result.sal);
    end my_proc;
    
    -- 패키지 명세에 선언된 함수를 구현 
    function my_add(p_x number, p_y number) return number 
    is
    begin
        return p_x + p_y;
        end my_add;
    end; 
    
    
end;
/
select my_PKG.my_add(1,2) from dual;

select my_PKG.num1 from dual;
-- 변수는 이러게 쓸 수 없어요

declare 
    v_result my_pkg.rec_emp_sal; -- package 안의 어떤 레코드 타입으로 변수의 데이터 타입 설정 
begin 
    dbms_output.put_line(my_pkg.num1);
    my_PKG.my_proc(); 
end; 
/ 




















