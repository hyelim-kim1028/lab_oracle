-- PL/SQL data type 정리 
-- 1) Scalar(스칼라) 타입: number, varchar2, date,... 
-- 2) Reference (참조) 타입: 어떤 특정 테이블의 열(column)이나 행(row)을 참조하는 테이블 
-- column 은 쉽다 (한가지 타입): dept table > deptno, dname, loc ... 
-- 행을 참조하는 타입을 만들수도 있다. However, in a row, there are different types of data in a row.(복합데이터타입) /compound type 
-- 3) composite type: a. collection: collection of rows in one column b. record: collection of rows (다음주 월요일에,,,^^ 커밍 쑨~) 
-- https://docs.oracle.com/database/121/TTPLS/dtypesfunc.htm#TTPLS163

-- 컬럼 참조 타입 변수 선언: 변수이름(or 식별자/identifier) 테이블이름.컬럼이름 %type := 값;  '
-- 컬럼이름%type 하면 해당 컬럼과 같은 타입이 된다 
-- 행 참조 타입 변수 선언: 변수이름 테이블이름%rowtype := 값 
-- rowtype 과 같다구? how? 

set serveroutput on;

-- 컬럼 참조 타입 변수 선언
declare 
 -- dept 테이블의 각 컬럼의 값들을 저장할 수 있는 변수 선언 
 /*v_deptno number(2); =  v_deptno dept.deptno%type := 10; */
 v_deptno dept.deptno%type := 10;
 -- 타입을 모를 때, 편리를 위해서만이 아니라, 변경과 같은 나중을 위해서도 사용하는 코드 
 v_dname dept.dname%type; 
 v_loc dept.loc%type; 
begin 
 select dname, loc 
 into v_dname, v_loc 
 from dept 
 where deptno = v_deptno; 
 DBMS_OUTPUT.put_line(v_deptno||' : '||v_dname||' : '||v_loc);
end;
/

-- 행 참조 타입 변수 선언
declare 
    -- emp table에 row의 모든 정보를 저장할 수 있는 정보를 선언한다. row에 있는 8개의 값들 
    v_emp7788 emp%rowtype; 
    -- 변수이름은 not over 30 bytes
begin 
    select * into v_emp7788 from emp where empno = 7788; 
    dbms_output.put_line('NAME: '||v_emp7788.ename);
    dbms_output.put_line('SALARY: '||v_emp7788.sal);
    dbms_output.put_line('DEPARTMENT NUMBER: '||v_emp7788.deptno);
    dbms_output.put_line('HIRE DATE: '||v_emp7788.hiredate);
end;
/

-- record data type: emp 라고 하는 이름 하나에 (넘버 같으면 n number(2)이렇게 변수 선언 > 하나 밖에 저장 안됨 > 이런게 scalar) 
-- row type data 이 안에 여러가지 타입들을 저장 가능 (emp > number number > sal number > ename varchar2) 
-- 데이터 타입에 대한 이름은 하나인데, 그 안에 여러가지 데이터와 다양한 타입들을 저장 가능 (레코드 타입) 





