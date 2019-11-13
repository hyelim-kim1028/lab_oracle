--1.
-- 이름을 입력받아서 사번과 부서번호 검색해서 이름, 사번, 부서번호 출력 
-- 입력된 이름이 대/소문자에 상관없이 결과를 출력할 수 있도록 하라 

set serveroutput on; 

accept p_name prompt 'What is the name?';
-- 이름을 입력하라고는 했지만, 문자나 숫자인지로는 구분하지 못한다. 타입을 선언해줘야한다 

declare     
    v_empno number(4);
    v_deptno number(2); 
    v_ename varchar2(100) := '&p_name';
    -- v_ename varchar2(100) := upper('&p_name'); 이렇게! 
begin 
    select empno,deptno
    into v_empno,v_deptno 
    from emp 
    where upper(ename) = v_ename;  
dbms_output.put_line('Ename '||v_ename||' has empno of '||v_empno||' and works in deptno '||v_deptno); 
end;
/

--- COMMON PROBLEM 
begin 
    dbms_output.put_line('&p_name');
end;
/
-- 이렇게 확인해봤더니:  'SCOTT' 식별자가 정의되어야 합니다/ Statement ignored
-- &p_name의 자리에 111을 대입해봤더니, 성공 
-- prompt does not recognize characters, thus we have to put '' as well to make sure the prompt recognizes the characters as its kind 
-- to solve the probem of unrecognition, we put '' on &p_name





--2. 
-- 이름을 입력 받아서 
-- emp, dept 테이블을 활용하여 (join) 
-- 'Scott'은 '달라스'에 위치한 '리서치'부서에서 근무합니다 와 같은 형식으로 출력하라 

accept p_ename prompt 'What is the name?';

declare 
    v_ename varchar2(20) := '&p_ename';
    v_loc varchar2(13);
    v_dname varchar2(14);
   -- v_deptno number(2); no need to indicate it here 
begin 
    select e.ename, d.loc, d.dname 
    into v_ename,v_loc,v_dname
    from emp e join dept d    
    on e.deptno = d.deptno
    where UPPER(e.ename) = Upper(trim(v_ename));
dbms_output.put_line(v_ename||' 은(는) '||v_loc||' 에 위치한 '||v_dname||' 부서에서 근무합니다'); 

end;
/


    