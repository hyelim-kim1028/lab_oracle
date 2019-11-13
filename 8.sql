-- 변수(variable): 프로그램(프로시져)에서 필요한 데이터(값)을 저장하는 공간 
-- 상수 (constant): 값이 한번 저장(할당)되면 값을 변경할 수 없는 변수 
-- 리터럴 (literal): 프로그램이나 프로시저에서 정적으로 사용되는 값 

declare 
    --변수 선언&초기화 
    var1 number := 1;   
    -- 여기서 1이라는 숫자 그 자체가 리터럴이라고 부른다 (값 그 자체) 
    var2 varchar2(20) := 'abc'; 
    -- 여기서 'abc'가 리터럴. 우리는 코딩으로 하지 않는 이상 이 값을 바꿀 수 없다 
    -- 상수선언: 
  --변수이름 constant 데이터타입 := 값  
  -- 상수는 선언과 동시에 초기화를 해야 함! 
    const1 constant number := 3.14;
    -- 이렇게 선언한 숫자를 상수라고 한다 
    -- 변수들 중에서 값이 저장되고 나면 바꿀 수 없는 것들을 상수라고 한다 
    -- 이 상수들은 다른 숫자들과 구분하기 위해 (바꿀 수 있는 다른 숫자들을) 우리는 리터럴이라고 부른다 
    const2 constant number;
begin 
    const2 := 100; 
    var1 := 2; -- 변수들은 언제든지 값을 변경(수정, 재할당)할 수 있다.
    var2 := '가나다'; -- 선언만 된 변수에 값을 저장 (할당) 
    const1 := 3.141592;
end;
/

-- PL/SQL 프로시저가 성공적으로 완료되었습니다. = 오류가 없었다 
-- begin 에 const1 := 3.141592 라고 할 경우:  'CONST1' 식은 피할당자로 사용될 수 없습니다/ 
-- PL/SQL: Statement ignored/ Usually a PL/SQL compilation error. 
-- 피: 당하는것, 받는 / 할당을 받는 용도로는 사용을 할 수 없다 
-- constant 라고 붙여주면, 한번만 값을 저장 할 수 있고, 나중엔 변경 불가 

--- 

set serveroutput on;
declare 
    v_num number default 0;
begin 
    dbms_output.put_line('v_num= '||v_num);

end; 
/

declare 
    v_num1 number := 10; --nullable variable 
    v_num2 number not null := 20;
begin 
    v_num1 := null;
    v_num2 := null; --not null 변수에는 null을 할당할 수 없다 
end;
/

-- p for parameter 
declare 
    -- 사원의 급여를 저장할 수 있는 변수를 선언 
    v_sal number; 
begin 
-- emp table 에서 7788번 사원의 급여를 검색 
    select sal into v_sal from emp where empno = 7788;
    -- 우리가 하고 싶은 것은 그 값을 그냥 보는게 아니라, v_sal이라는 변수에다 넣어주고 싶은 것 (into) 
    -- 그럴 때, into 라는 아이를 사용해서 넣어준다 
    dbms_output.put_line('급여: '||v_sal);
end;
/

-- declare   v_sal number; 여기서 데이터타입을 설정 할 때에, the original table has length of (7,2). 
-- If we put v_sal number (4 or other random number), it would have caused a problem. 

-- 사번을 입력 받아서 (accept - prompt) 
-- 입력받은 사번의 사원 이름과 부서 번호를 검색해서 화면에 출력하세요 

accept p_empno prompt '사원번호?';
-- My Answer + Teacher's solution 
declare 
--   v_empno number(4) := &p_empno; 
   v_ename varchar2(10); -- 사원이름을 저장할 변수 
   v_deptno number(2); -- 부서 번호를 저장할 변수 
begin 
--select ename into v_ename from emp where empno = v_empno;  
--select deptno into v_deptno from emp where empno = v_empno; 따로따로 or 같이 
select ename,deptno
into v_ename,v_deptno 
from emp 
where empno = &p_empn0; -- v_empno;  
dbms_output.put_line('사번'||&p_empno);  --v_empno
dbms_output.put_line('이름'||v_ename);  
dbms_output.put_line('부서 번호'||v_deptno);  
end;
/

-- ctrl + /: 현재 커서가 있는 위치의 한줄을 주석 처리/해제 (toggle) 

-- 사번을 입력 받아서 해당 직원의 총급여 (sal+comm)을 화면에 출력 
-- comm이 null인 경우는 0으로 계산 

-- My Answer 
accept p_empno prompt '사원번호?';

declare 
   --v_empno number(4) := &p_empno; 
   --v_sal number(7,2);
   --v_comm number(7,2) null := 0;  
   v_sum number(7,2); -- 총급여(sal+comm)을 저장할 변수 선언 := v_sal + v_comm; -- 이렇게 하면 안나온다,, 
begin 
    select sal+nvl(comm,0)into v_total_sal
    from emp 
    where empno = &p_empno;
    
/*    v_sum := v_sal + v_comm; 
    select sal,comm into v_sal,v_comm from emp where empno = &p_empno;
    dbms_output.put_line('salary'||v_sal);
    dbms_output.put_line('commission'||v_comm);   
    dbms_output.put_line('sum'||v_sum)*/
    
    
/*  Not the above one, but the below one is the correct one (look how different) 
    select sal,comm into v_sal,v_comm from emp where empno = &p_empno;  
    dbms_output.put_line('사번'||&p_empno||'사원의 총 급여는 '||(v_sal + nvl(v_comm,0)))*/
end;
/

--    v_sum := v_sal + v_comm; 

-- teacher's solution 
accept p_empno prompt '사원번호?';
declare 
    v_sum number(7,2);
begin 
    select sal+nvl(comm,0)into v_sum
    from emp 
    where empno = &p_empno;
    dbms_output.put_line('사번 '||&p_empno||'사원의 총급여는 '||v_sum);
end;
/
-- null값!!! 

declare 
v_sal number(7,2);
v_comm number (7,2);
v_total_sal number (7,2);
begin 
select sal, nvl(comm,0) into v_sal,v_comm 
from emp 
where empno = &p_empno;
v_total_sal := v_sal + v_comm; 
dbms_output.put_line('사번 '||&p_empno||'사원의 총급여는 '||v_total_sal);
end;
/
























