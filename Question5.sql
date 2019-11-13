--20190920 QUESTION 5

--ex 5. 
--(1) 이름이 SCOTT 인 사원의 이름과 부서 위치를 출력하는 SQL 작성.
--
--(2) 이름을 prompt로 물어보고, 해당사원의 부서 위치를 출력하는 PL/SQL 작성. 단, 이름은 소문자로 입력해도 수행되게 작성.
--(예)
--이름 입력 ~ scott
--SCOTT은 DALLAS에서 근무합니다

set serveroutput on;

accept p_ename prompt 'What is your name?';

declare 
    v_ename emp.ename%type := '&p_ename'; 
    v_loc   dept.loc%type;
    v_deptno dept.deptno%type;
    
begin 
    select e.ename, d.loc, d.deptno 
    into v_ename, v_loc, v_deptno 
    from emp e join dept d  
    on e.deptno = d.deptno
    where UPPER(e.ename)=UPPER(trim(v_ename));
    
    dbms_output.put_line(v_ename||' works in '||v_loc);

end;
/ 


