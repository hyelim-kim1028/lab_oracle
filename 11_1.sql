--09.17.2019.Martes 
-- ex33 in teacher's file 
/* 커서(cursor): PL/SQL 내부에서 SQL 문장을 처리하는 정보를 저장한 메모리 공간  
When an SQL statement is processed, Oracle creates a memory area known as context area. 
A cursor is a pointer to this context area. 
It contains all information needed for processing the statement. 
In PL/SQL, the context area is controlled by Cursor. 
A cursor contains information on a select statement and the rows of data accessed by it.

A cursor is used to referred to a program to fetch and process the rows returned by the SQL statement, one at a time. 
There are two types of cursors:
Implicit Cursors (묵시적 커서)
-- 별다른 선언없이 SQL문장을 사용했을 때 자동으로 만들어지는 커서 
-- 별다르게 할게 없다,, 
Explicit Cursors (명시적 커서) 
-- 개발자가 직접 이름을 선언하고 사용하는 커서 
LINK: https://www.javatpoint.com/pl-sql-cursor


명시적 커서: 선언 -> open -> fetch -> close 

*/

set serveroutput on;

select * from dept;

begin 
 select * from dept;
 end;
 /
 -- ERROR: 해당 SELECT 문에 INTO 절이 필요합니다.
 
 declare 
    v_dept dept%rowtype; 
 begin 
    select * into v_dept from dept where deptno = 10; 
-- 오라클 DB내부에서 묵시적 커서가 자동으로 생성됨. (select라는 처리 결과를 가지고 있는 커서가 자동으로 있었던 것 > 그래서 v_dept.deptno 했을 때 결과값이 나온것?)     
    dbms_output.put_line(v_dept.deptno);
end;
/
-- 이 코드에서도 프로시저가 성공적으로 완료되었다고 말해줄 뿐, 실행된 결과는 화면에 나오지 않는다 
-- dbms... 하고 출력문을 따로 적어줘야만 나옴 
-- 묵시적인 커서는 행을 여러개를 저장할 수 없다 (위에서 row 타입이니까, deptnot, dname 등 여러가지 데이터 타입을 가지고 있지만, no se cabe) 
-- 이럴 땐 명시적 커서를 사용해 주어야함 


-- select into 구문은 1개 이상의 행(row)가 select 되는 경우는 사용할 수 없다. 
-- 이런 경우 명시적 커서를 사용해줘야한다 
-- 명시적 커서는 select의 결과가 행의 갯수에 상관없이 사용할 수 있다. 
-- 커서 사용 방법: cursor 커서이름 is (SQL 문장); 
declare 
-- explicit cursor declaration: 
    cursor my_cursor is(
        select * from dept where deptno = 10 
    ); 
-- when using cursor, no need to use 'into' 
-- in this case, there will be one or no row/ without the where clause, there will be multiple rows returned 
    v_row dept%rowtype; -- 커서의 데이터 저장(fetch) 할 때 사용할 변수 
begin 
    -- open the cursor (커서 열기, 접근, SQL문장 실행 )
    open my_cursor;
    -- deptno = 10 의 해당하는 메모리가 생김 
    
    -- fetch the cursor (데이터 분석/읽기) 실행된 결과값을 읽어오는 과정 
    fetch my_cursor into v_row;
    -- 실행된 결과 읽기 > 정보를 읽어온다 deptno 10 에 해당하는 
    dbms_output.put_line(v_row.deptno||' , '||v_row.dname||' , '||v_row.loc);
    -- close the cursor (닫기)
    close my_cursor;
end;
/


-- close 하지 않으면 계속 해서 이 아이가 메모리에 남아있다가 나중엔 DB가 느려질 수도 있다 


-- 결과 행이 1개인 명시적 커서 
declare 
--(1) 커서 선언 
 cursor sel_emp is (
    select * from emp where empno = 7788
    ); 
    
    v_row emp%rowtype; 
begin 
    open sel_emp;
    fetch sel_emp into v_row; 
    dbms_output.put_line(v_row.empno||' , '||
                         v_row.ename);
    close sel_emp;
end;
/

-- 결과 행이 여러개가 될 수 있는 명시적 커서 
declare 
-- 명시적 커서 선언 
    cursor sel_dept is (
    select * from dept
    );
-- 위의 SQL 문장을 실행 했을 때 변수가 dept 테이블에서 나오고, 한꺼번에 저장할 수 있어야하기 때문에 저장하는 값은 
-- dept테이블의 row 타입 > 즉, v_rows dept%rowtype;  

-- 커서 실행 결과를 fetch할 때 사용할 변수 
  v_row dept%rowtype;   
  
begin
    open sel_dept;
    loop 
    fetch sel_dept into v_row;
    exit when sel_dept%notfound;
    dbms_output.put_line(v_row.deptno||' , '||v_row.dname||' , '||v_row.loc);
    end loop; 
        -- 결과 행이 하나가 아니라, 여러개 > 행 바이 행으로 읽어오는 것을 fetch 한다 라고 표현 
        -- (행이 1개가 아니라 여러개가 나올 수도 있다) 반복문을 돌려야한다 
        -- 하지만 fetch 는 행 1개만 읽어오는 것 > 반복문 안에서 페치한다 
        -- not found" there is no more data in the db 
        -- select ino 는 여러개를 감당 ㄴㄴ 
         
    
    close sel_dept;

end;
/

-- emp table 에서 deptno = 30 인 직원들의 사번, 이름, 급요를 출력 

declare 
    cursor emp_cursor is (
    select * from emp where deptno = 30
    ); 
    
    v_emp emp%rowtype;
begin 
    open emp_cursor; 
    loop 
     fetch emp_cursor into v_emp;
    exit when emp_cursor%notfound;
    dbms_output.put_line(v_emp.empno||' , '||v_emp.ename||' , '||v_emp.sal); 
    end loop; 
    close emp_cursor; 

end; 
/ 

-- exit 과 dbms clause 의 자리를 바꾸면 마지막 사람이 두번 출력되고 끝난다 > 왜지 
-- fetch 의 과정은 DB 에서 테이블에 있는 정보를 가지고 오는 것 
-- not found 데이터를 읽은 이 후에 더 데이터가 있는지 없는지 알아보는 것 
-- 그래서 출력을 하다가 not found이 발생 했음에도 불구하고, 마지막 변수가 하나 더 출력된다 (마지막에 남아있던 변수 하나가 출력되는 것) 

-- 위에 코드를 가지고 놀아 보쟈! 
declare 
    --cursor emp_cursor is (
    --select * from emp where deptno = 30
    --); 
    
    cursor my_cursor is (
        select empno, ename, sal from emp where deptno = 10
    );
    -- 필요한 요소만 검색해 보쟈! 
    
    type my_record is record(
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type
        );
        v_row my_record;
    
    -- rowtype  에는 필요한 요소 (empno, ename, sal) 보다 더 다양한 요소들이 있다 (sal,com등...) 그래서 짝이 안 맞음 
    --v_row emp%rowtype;
    -- ERROR: FETCH 문의 INTO 항목에 값의 수가 잘못됐습니다 
begin 
    open my_cursor; 
    loop 
     fetch my_cursor into v_row;
          exit when my_cursor%notfound;
    dbms_output.put_line(v_row.empno||' , '||v_row.ename||' , '||v_row.sal); 
    end loop; 
    close my_cursor; 
    -- cursor 이 닫히면 더 이상 메모리는 fetch 할 수 없다 : 메모리에서 지워진거니까,,,! 
end; 
/ 

-- 만약 loop 이 아니라 while 을 쓴다면? 
declare 
 
    cursor my_cursor is (
        select empno, ename, sal from emp where deptno = 10
    );
    
    type my_record is record(
        empno  emp.empno%type,
        ename  emp.ename%type,
        sal    emp.sal%type
        );
        v_row my_record;
    
begin 
    open my_cursor;
    
    fetch my_cursor into v_row; 
        while my_cursor%found loop 
            dbms_output.put_line(v_row.empno||' , '||
                                 v_row.ename||' , '||
                                 v_row.sal); 
            fetch my_cursor into v_row;
    end loop; 
    -- %found 에서의 위험성: fetch의 결과는 fetch를 해봐야 할 수 있다 (found or not found) 
    -- fetching is a process of draw data from oracle db 
    
    close my_cursor; 

end; 
/ 

-- 명시적 커서를 FOR LOOP에서 사용
-- open, fetch, close가 자동으로 수행됨 
-- for 변수 in 커서 loop ... end loop; 

declare 
    cursor my_cursor is ( 
    select * from dept 
    );
    
begin 
    for row in my_cursor loop 
        dbms_output.put_line(row.deptno||' , '||row.dname||' , '||row.loc);
    end loop; 

end;
/
-- 노트정리 해주세요 (open, close, fetch 의 과정이 for 문 하나에 들어있음) 
-- 전에 사용했던 for clause 와는 format 이 좀 다르다 


-- EJERCICIO 
-- 명시적인 커서와 for loop을 사용해서 
-- 20번 부서의 직원들의 사번, 이름, 급여를 출력 

declare 
    cursor my_cursor is(
        select * from emp where deptno = 20
    );
    -- 만약 여기 SQL 문장에서 원소에 별명을 줄 경우: select empno, ename name, sal from emp... 
begin 
    for row in my_cursor loop 
        dbms_output.put_line(row.empno||' , '||
                             row.ename||' , '||
                             row.sal);
    -- 여기서도 row.ename 이 아니라 row.name 으로 별명을 따라간다    
    end loop; 
end; 
/

