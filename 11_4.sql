-- 09.18.2019 
-- EX35 in teacher's file 
-- 이름이 있는 procedure 와 function을 만드는 방법 

/* 
1. 익명(무명) 블록 (anonymous block); 
-- 이름을 지정하지 않은 PL/SQL 블록 
-- 이름이 없기 때문에 오라클 서버에 저장 될 수 없다. 그래서, 재사용 할 수 없음 
-- 스크리트 파일 (*.sql) 에는 저장 가능 
-- 실행이 될때마다 새로 컴파일 > 실행속도 느림 

2. 저장 서브 프로그램 (stored sub program):procedure & function 
-- 이름이 있는 PL/SQL block 
-- procedure, function (함수), package, trigger 
-- 오라클 서버에 저장되는 객체 (object) > table, procedure, function.. (scott 을 눌렀을 때 리스트로 나오는 아이들은 다 객체,,,) 
-- 테이블처럼 프로시져, 함수 같은 아이들도 만들어서 저장할 수 있고, 
-- 저장된 아이들은 이름이 있기 때문에 언제든지 불러서 재사용이 가능하다
-- saved in ORACLE, thus can be reused (REUSABLE) 
-- it is compiled only once when it is saved in ORACLE (오라클 서버에 저장될 때 컴파일 됨) -> 실행 속도가 빠름 

3. 프로시져 (Procedure) 
-- The PL/SQL stored procedure or simply a procedure is a PL/SQL block which performs one or more specific tasks. 
    It is just like procedures in other programming languages. The procedure contains a header and a body.
            - Header: The header contains the name of the procedure and the parameters or variables passed to the procedure.
            - Body: The body contains a declaration section, execution section and exception section similar to a general PL/SQL block.

link: https://www.javatpoint.com/pl-sql-procedure

-- create procedure is also DDL (create, delete...) > review the previous lessons 

create [or replace] procedure 프로시져이름 [( 
    파라미터1 [mode] 타입,
    파라미터2 [mode] 타입, 
    ...
    
    [mode]: in,out,inout 
); ]

-- [ ] 이 부분은 생략 가능 (파라미터 생략가능) 
-- [or replace] 도 생략 가능 > create procedure OR create or replace procedure 
-- [or replace] 나중에 이미 저장한 프로시져가 버그가 있어서 수정하거나 같은 이름은 남기고 저장하고 싶을 때 

is 
-- PL/SQL이랑 다른점: declare 대신 is를 쓰고 있다 
-- is 에서 변수,커서 선언 

begin 
-- 실행부: 절차적으로 처리할 코드들; 

* exception 사용 가능 / 생략 가능 
[exception 예외 처리부] 

end;
/ 

-- is, begin, end 는 절대 없으면 안된다 
-- is >  [procedure] is [the rest of the code/ begin + exception..] 

*/


set serveroutput on;

-- 프로시저 생성 
-- parameter 가 없는  procedure 만들기 
create or replace procedure my_proc1  
is 
    v_empno emp.empno%type := 7788;
    v_ename emp.ename%type; 
begin 
    select ename into v_ename from emp where empno = v_empno;
    dbms_output.put_line('이름: '||v_ename);
end;
/

-- create or replace procedure 라고 할 경우, 이름이 없으면 그냥 생성하고, 기존에 무언가가 있으면 자동으로 replace 를 한다 
-- 하지만 기존에 프로시져가 있는지 모르고 리플레이스 할 경우 : 대참사 : 원래 있던 아이가 없어짐,,,^^ 


-- 여기까지는 파일이 만들어진거지 실행을 시키는게 아니다 > 이게 다른 점 (저장 O 실행 X) 
-- 실행은 다른 PL/SQL 에서 한다 

-- 프로시져 실행 
begin 
    my_proc1(); --  is the same as: my_proc1 

    -- 파라미터 없이 프로시져를 생성한 경우, 괄호가 비어도 실행됨 
    -- 파라미터를 갖지 않는 프로시저를 호출할 떄는 () 생략가능 
end;
/
-- 이제 그 우리가 만들어둔 proc1 블럭을 가져다가 쓸 수 있다 

-- 프로시저 확인 
select * from user_source where name = upper('my_proc1');

-- upper을 사용해서 대문자로 맞춰준다 (오라클을 대문자를 4랑한다) > 기본이 대문자인 프로그램임 

-- 프로시저 삭제 
drop procedure my_proc1;

-- DDL이기 때문에 commit이 자동으로 이루어진다 (= DB에서도 사라졌다) 


-- 파라미터를 갖는 프로시저 생성 
create or replace procedure my_proc2(
	p_empno emp.empno%type
) 
is 
 v_ename emp.ename%type; 
begin 
    select ename into v_ename from emp where empno = p_empno;
    dbms_output.put_line('name: '||v_ename);
end; 
/ 

-- 생성된 프로시져 실행 
begin 
    my_proc2;
end;
/
-- 이건 procedure 에 값이 없는 경우에만 가능 
-- ERROR: 'MY_PROC2' 호출 시 인수의 갯수나 유형이 잘못되었습니다 *Cause:    Usually a PL/SQL compilation error.

begin 
    my_proc2(7839);
    -- 7788: 프로시져가 원하는 값을 넣어주기 > 우리는 empno > 'name: '||v_ename 이렇게 출력 
end;
/

-- empno 라는 정보를 가짐으로써 ename 이라는 정보를 출력 > 여기서 주머니: parameter는 empno 
-- for loop 1..9999 > 나머지는 exception 처리 


-- 프로시져 실행 
declare 
    cursor my_cursor is 
        select empno from emp; 
begin 
    for r in my_cursor loop 
        my_proc2(r.empno); -- r: 컬럼 empno: 행 
    end loop; 
end;
/

-- 프로시져 파라미터의 모드(mode) 
-- in/out/inout 
-- in: 프로시져 안쪽으로 들어오는것 : 프로시져를 호출할 때 전달한 값을 저장하는 매게변수(parameter): stored values    
-- out: 프로시져 바깥 쪽으로 나가는 것  : 프로시져를 호출한 곳으로 값을 반환할 때 사용하는 매게변수 
-- inout: 값을 전달 받기도 하고, 값을 반환하기도 하는 매게변수 
-- 파라미터의 기본은 in이라서 생략가능 / out과 inout은 생략불가!!!!!!!! 

create or replace procedure my_proc3(
    -- declare parameter 
    in_empno emp.empno%type, -- in 모드 파라미터 (값을 받아야만 하는) 
    out_ename out emp.ename%type, --out모드 파라미터 (값을 보내주는 용도로 사용)
    out_deptno out emp.deptno%type 
)
-- ; 없습니돠아아아!!!!!!!!!!!
    
is 
-- 선언부에 코드가 없더라도 is는 생략하면 안됨! 
-- 파라미터가 선언되어 있기 때문에, 변수를 새로 선언할 필요가 없다 
-- 주머니에서 변수를 가져오는 건가봐,,, 
begin 
    select ename,deptno into out_ename, out_deptno from emp where empno = in_empno;    
    -- 묵시적 커서 생성? 
end; 
/

declare 
   v_ename emp.ename%type; 
    v_deptno emp.deptno%type;
begin 
    my_proc3(7788,v_ename,v_deptno);
        -- in mode의 파라미터에게는 값을 주고, out mode 의 파라미터에게는 변수를 줘서 변수를 선언   
    dbms_output.put_line(v_ename||' , '||v_deptno);
end; 
/
-- 7788 위의 코드로 들어가고 (in_empno), out 인 변수들은 주머니에서 나온다 
-- procedure 은 return 이 아니라 parameter 을 통해 이런 process 를 수행 

-- in과 out을 동시에 갖는 parameter 

create or replace procedure my_proc4(
    v_number in out number 
)
--     값을 전달도 받고, 값도 나간다고,,,?
is 
    
begin 
    v_number := 2* v_number;
    
end;
/

declare 
    v_test number := 10; 
    
begin 
    dbms_output.put_line('Procedure 호출 전 v_test = '||v_test);
    my_proc4(v_test); -- 프로시저 호출
    dbms_output.put_line('Procedure 호출 후 v_test = '||v_test);
end;
/

-- 기본값을 갖는 프로시저의 파라미터 > 주머니가 기본값을 가질 수 있다! (우쮸쮸) 
create or replace procedure my_proc5(
    param1 number,  --기본값이 지정되지 않은 파라미터 
    param2 number := 123 --파라미터에 기본값(I guess it's the default number) 123 을 준것 
)
is  
        
begin
    dbms_output.put_line(param1||' , '||param2); 
    
end;
/

begin 
   my_proc5(1,2);
   my_proc5(100);
end;
/

drop procedure my_proc7;
drop procedure my_procA;

-- 두번째 아이는 아무것도 안써도 그냥 디폴트가 출력된다 

--프로시져: get_total_sal 
-- 파라미터를 갖는다: 1) p_empno - in 모드, 숫자 타입 2) p_total   out모드 숫자타입 3) p_tax in 모드 숫자타입 기본값 = 0.05 
-- 기능: 전달받은 사번으로 salary와 com을 검색 
-- out total = (sal + com) * (1-0.05)   => 를 반환 (파라미터를 통해 반환) 
-- com > null인 경우엔 0 


create or replace procedure get_total_sal (
    p_empno in     emp.empno%type,
    p_total out  number,
    p_tax   in    number := 0.05
)
is 
  -- emp 테이블에서 해당 사번의 급여(sal)와 상여금을 저장할 변수 
    v_sal emp.sal%type;
    v_comm emp.comm%type;
begin  
    select sal, comm 
    into v_sal, v_comm 
    from emp 
    where empno = p_empno;

    p_total := (v_sal + nvl(v_comm,0)) * (1-p_tax); 
    
        --    dbms_output.put_line('Employee Number'||' , '||p_empno||
        --                         'Tax'||' , '||p_tax||' , '||
        --                         'Salary: '||v_sal||' , '||
        --                         'Comm: '||v_comm||' , '||
        --                         'Total Salary: '||p_total);

end;
/

declare 
-- give variable name to p_total, v_sal & v_comm? 
    v_empno emp.empno%type := 7788;
    v_total number; 
    v_tax number := 0; 
begin 
  get_total_sal(v_empno, v_total, v_tax);
        dbms_output.put_line(v_total);
end;
/



-- 사번으로 찾는것 
-- 그걸 이용해서 proc 을 만들어서 total을 나오게 하는 것 
-- a. 전달받은 사번으로 salary와 com을 검색 > 토탈이 나오게 하기 










/*
create or replace procedure my_procA(
    -- declare parameter 
    p_empno      emp.empno%type, 
    p_sal   out  emp.sal%type, 
    p_comm  out  emp.comm%type := nvl(comm,0) 
    p_tax   out  number := 0.05 
    p_total out  number := (v_sal + v_com) * (1-p_tax)
)
is 

begin 
    select sal, comm into p_sal,p_comm from emp where empno = p_empno;  
    p_total := (v_sal + v_com) * (1-p_tax); 
    dbms_output.put_line my_procA('empno '||' , '||7788||' total salary'||' , '||p_total||'tax'||' , '||p_tax);
    
end; 
/

begin 
    my_procA(7788,p_total,p_tax); 
end;
/
*/



create or replace procedure get_total_sal2 (
    p_empno in     emp.empno%type,
    p_total out  number,
    p_tax   in    number := 0.05
)
is 
  -- emp 테이블에서 해당 사번의 급여(sal)와 상여금을 저장할 변수 
--    v_sal emp.sal%type;
--    v_comm emp.comm%type;
    
begin 
       select (sal + nvl(comm,0)) * (1-p_tax) 
        into p_total 
        from emp 
        where empno = p_empno; 
        
exception 
    when no_data_found then 
        dbms_output.put_line(p_empno||' : '||'No Data Found');
        p_total := 0; 
end;
/

declare 
-- give variable name to p_total, v_sal & v_comm? 
    v_empno emp.empno%type := 7788;
    v_total number; 
    v_tax number := 0; 
    
--    cursor my_cursor is 
--    select empno from emp; 
begin 
  get_total_sal2(v_empno, v_total, v_tax);
        dbms_output.put_line(v_total);
        
--    for r in my_cursor loop 
--        get_total_sal(r.empno,v_total); 
--        dbms_output.put_line(r.empno||' : '||v_total);
--        end loop; 
       
end;
/
