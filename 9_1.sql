set SERVEROUTPUT ON
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

-- logic (논리) 만들기: 문제를 해결해 나가는 순서 
-- 가지고있는 정보: 사원의 이름 (emp table)
-- 우리가 알 수 있는 정보: 부서번호 (emp>dept table) SQL 문장 1 
-- 우리가 알고 싶은 정보: 부서위치와 부서이름 SQL (deptno) 문장 2

accept p_name prompt '이름 입력하세요...';
declare 
    v_ename varchar2(20) := upper(trim('&p_name'));
    v_dname varchar2(14); 
    v_loc varchar2(20);
    v_deptno number(2); 
    -- We did not indicate the deptno in the previous solution(s), however, following a new logic (under a supposition that we do not rememebr a join sentence)
begin 
    -- 사원 이름으로 그 사원이 근무하는 부서 번호를 검색 
    select deptno into v_deptno from emp where upper(ename) = v_ename; 
    -- 부서 번호를 사용해서 부서의 이름과 위치 검색 
    select dname, loc into v_dname,v_loc from dept where deptno = v_deptno;
    -- 검색한 정보를 화면에 출력 
dbms_output.put_line(v_ename||' 은(는) '||v_loc||' 에 위치한 '||v_dname||' 부서에서 근무합니다'); 
end;
/

-- 변수를 선언 할 때 마다,,, 

