/*이 모양 앞에 --을 넣으면, 뒤의 아이가 줄이 바뀌면 더이상 protect? what word should I use duh 하지 않는다 */
set serveroutput on;

-- 레코드 & 컬렉션 
-- RECORD: 데이터 타입이 서로 다른 여러개의 값(데이터)들을 저장할 때 사용하는 변수의 이름. (만든 변수의 이름) 
-- COLLECTION: 같은 타입의 데이터들을 저장할때 
-- ~ with the concept of row and column 

-- 레코드 선언/정의 방법:
-- type 레코드이름 is record(변수 이름, 변수 타입 .. ); 
-- 레코드에 값을 저장: 
-- 레코드. 필드 := 값; (From my understanding, as described by the teacher "it is an element of a record" it is a column in the table, 
            -- but is it more specific or what? 
declare 
    -- define the record 
    type rec_dept is record(
     deptno number, 
     dname varchar2(20),
     loc varchar2(20)
    );
    -- not making it the same as the table itself 
    -- 변수 이름 변수타입; dname varchar2(20);  변수를 선언할 때 사용할 수 있는 데이터 타입을 사용(?) 
    
    
    -- 레코드의 이름은 변수를 선언할 때 사용 
    v_dept_row rec_dept; --v_dept_row라는 변수는 rec_dept 라는 타입입니다 라는 뜻 
    -- 레코드를 만드는 이유는 타입을 정하기위해서  
begin 
    -- 레코드 변수에 값을 저장 
    v_dept_row.deptno := 99; 
    v_dept_row.dname := 'ITWILL';
    v_dept_row.loc := 'GANGNAM, SEOUL';
    
    dbms_output.put_line('번호: '||v_dept_row.deptno||' 부서이름: '||v_dept_row.dname||' 위치: '||v_dept_row.loc);
    
end;
/
-- 인서트나 업데이트를 할 때 이 걸 사용할 수 있다  
-- 레코드 사용해서 인서트 사용 
--

select * from dept2;
-- dept2 테이블에 레코드를 insert 
desc dept2;

declare 
    type rec_dept is record(
    deptno dept2.deptno%type,
    dname dept2.dname%type,
    loc dept2.loc%type
    );
    
    v_row rec_dept; -- 3개의 값을 한꺼번에 갖는 데이터 타입이 v_row 
    
begin 
    v_row.deptno := 11;
    v_row.dname := 'DATABASE';
    v_row.loc := 'SEOUL';
    
-- dept2 테이블에 위의 값 insert  
--insert into dept2
--values(v_row.deptno,v_row.dname,v_row.loc)... -- 어짜피 v_row에 다 저장된 값들 

insert into dept2
values v_row;

-- record type 의 변수를 사용한 dept 2테이블 업데이트 
-- update dept2 set deptno =?,dname = '',loc ='' where deptno = 11;  
 v_row.deptno := 99;
 v_row.dname := 'PL/SQL';
 v_row.loc := 'GANGNAM';
 update dept2 set row = v_row where deptno = 11; -- 이렇게 할 수 있는 건 테이블과 동일한 구조를 가지고 있어야만 가능 
 -- 두개가 있는 이유: 한번 더 실행시키니까 한번 더 insert 된 것 (begin > insert 여기서부터 시작,,,) 그래서 실행 할 때마다 행추가 
 -- PL/SQL은 위에서 부터 쭉 실행됨 > insert가 한번 더 되는 거임 
end; 
/

select * from dept2;

-- dept2.loc%type > 말고 더 쉬운건 없을까? 

declare 
    -- row 타입 참조 변수 선언 
    v_row1 dept%rowtype; --참조형 데이터 타입 
    -- 테이블의 구조(컬럼 이름/타입)와 똑같은 레코드 타입 
    
begin 
    -- 테이블과 똑같이 하려면 굳이 그렇게 따로 부를 필요 없당 
    v_row1.deptno := 22;
    v_row1.dname := 'ABC';
    v_row1.loc := 'KOREA';
    
    insert into dept2 values v_row1;
    -- row 타입을 만든 이유는 셀렉트 할 때 필요해서 그럼 
    
end; 
/ 

-- 레코드를 사용한 select 
-- emp 테이블에서 모든 게 아니라, 3개의 컬럼만 셀렉트 한다 라고 한다면,레코드를 따로 정의해서 사용 

declare 
-- 테이블의 모든 컬럼을 검색하는 경우에는 레코드를 직접 정의하는 것 보다 %rowtype 참조를 사용하는 것이 편리함. 
 v_emp_row1 emp%rowtype;
 
 -- 정의 
 type rec_emp is record(
    empno emp.empno%type,
    ename emp.ename%type,
    job emp.job%type
    );
-- 레코드 값으로 변수를 선언 
    v_emp_row2 rec_emp;
begin 
    select * into v_emp_row1 from emp where empno = 7788; 
    dbms_output.put_line(v_emp_row1.empno||','||v_emp_row1.ename);
    --테이블의 모든 컬럼을 사용할 떄 용이 
    -- 하지만, 만약에 테이블의 모든 컬럼이 아니라, 테이블의 일부 컬럼만 검색하거나 혹은 두개 이상의 테이블에서 조인하는 경우 
    -- 사용자 정의 레코드를 선언하는 것이 편리합니다.  
    
    -- 테이블에서 일부 컬럼만 검색하는 경우 
    select empno, ename, job 
    into v_emp_row2
    from emp 
    where empno = 7839; 
-- 컬럼 3개만 검색하고, into 에서 컬럼이 맞지 않으면 예) row1을 사용, 에러가 남 (ERROR: 값의 수가 너무 많습니다) 
-- 혹은 into 의 아이들을 각각 따로 선언해서 사용 혹은 레코드로 만들어서 사용 > 아니면 컬럼의 수가 맞지 않아서 에러 
dbms_output.put_line(v_emp_row2.empno||' , '|| 
                     v_emp_row2.ename||' , '|| 
                     v_emp_row2.job);
                     
-- insert, update 등에 사용되기도 하고, 

    
end; 
/

--emp 테이블, dept 테이블에서 
-- 사번, 이름, 급여, 부서 이름, 부서 위치 
-- joined by deptno 
-- 변수들을 저장할 수 있는 레코드(emp_dept)를 정의하세요 
-- join 문장을 작성해서 7788번 사원의 정보를 출력하는 PL작성 

declare 
    type emp_dept is record(
    empno emp.empno%type, 
    ename emp.ename%type, 
    sal emp.sal%type, 
    dname dept.dname%type,
    loc dept.loc%type
    );
    v_row emp_dept;
begin
    select e.empno, e.ename, e.sal, d.dname, d.loc 
    into v_row
    from emp e join dept d
    on e.deptno = d.deptno
    where e.ename = 'SCOTT';
    
    dbms_output.put_line(v_row.empno||','||v_row.ename||','||v_row.sal||','||v_row.dname||','||v_row.loc);
end;
/



-- salgrade를 알아보자 ! 나의 월급은 몇 등급,,,! 
declare 
    type emp_sal is record(
    empno emp.empno%type, 
    ename emp.ename%type,  
    sal emp.sal%type,
    grade salgrade.grade%type
    );
    v_row emp_sal;
begin
    select e.empno, e.ename, e.sal, s.grade
    into v_row
    from emp e join salgrade s
    on e.sal between s.losal and s.hisal
    where e.ename = 'SCOTT';
    
    dbms_output.put_line(v_row.empno||','||v_row.ename||','||v_row.sal||','||v_row.grade);
end;
/






























