--PL/SQL (Procedural Language Extension to SQL )
-- SQL에 대한 절차적 언어 확장 기능 
-- PL/SQL 의 필요성 
-- EX.직원(emp)테이블에서 부서별 직원들의 정보를 출력하고싶다 
select * from emp where deptno = ?; 
-- 부서번호를 모르니까 부서테이블에서 부서번호를 가지고와야한다 
-- 어떤 부서번호들이 있는지를 확인하기 위해서 dept테이블을 확인 
select deptno from dept;
-- 알아낸 부서 번호를 가지고 select문을 부서 갯수만큼 실행 
select * from emp where deptno = 10;
select * from emp where deptno = 20;
select * from emp where deptno = 30;
select * from emp where deptno = 40;
-- 이건 어떠한 한 절차 (procedure)을 따른 것, 하지만 반복의 연속 > 비효율적 
-- 하나의 업무를 완수하기 위해서 작업을 절차적으로 진행해야 할 필요가 있다 

/*PL/SQL의 블록의 기존 구조 
declare 선언하다, 선택사항 
    기능을 수행하기 위한 변수를 선언; (i.e. deptno from the above)  
begin   시작하다, 실행부, 필수사항   
    실행문 작성; (insert, select..) 
exception 예외/오류, 예외처리, 선택사항 
    예외처리문; (실행하다가 생긴 예외들) 
end; 끝냄 

0(주의사항). delare, begin, exception 에는 세미콜론(;)을 사용하지 않음, end에만 사용 
0. end와 각 문장들 (변수선언문장, 실행문, 예외처리문,...) 끝에는 semi colon사용 (반드시이이이)
0. PL/SQL 블록 내부 에서도 여러가지 주석들 을 사용할 수 있음.
0. sqlplus 명령창에서는 PL/SQL 블록이 끝났음을 명시하기 위해서 
end; 다음 줄에 슬래쉬(/)를 꼭 써야 함. 
*/
-- BEGIN & END 는 다른건 없어도 꼭 있어야함!!!!!!!!! 

set serveroutput on;
declare 
    v_num number := 999; 
begin 
    dbms_output.put_line('v_num 값 ='|| v_num);
end; 
-- PL/SQL 프로시저가 성공적으로 완료되었습니다. - 결과값은 보여주지 않는다 (b4: sin set serveroutput on;) 
-- despues: v_num 값 =123>PL/SQL 프로시저가 성공적으로 완료되었습니다.
-- || = 이어주겠다, 문자열과 문자열/숫자열을 이어서 출력해주겠다 
-- 절차의 하나의 단위/블럭은 프로시져라고 부른다 

-- cmd 에서는 end;/ 해야 실행된다 '/' 중요합니드아아아아 
-- '/'는 무조건 옆이 아니라 아래에다가 써주세요 


declare 
    /*
    변수 선언 부분 (이렇게 주석 만들어 줄 수 있다) 
    내 이름은 block 주석 
    */
    v_num number := 999; 
begin 
    -- 내 이름은 인 라인 주석 
    -- 화면 (콘솔) 출력 
    dbms_output.put_line('v_num 값 ='|| v_num);
    -- 이렇게 
    -- 요렇게 주석사용 가능 
end; 
/

/* PL/SQL 변수
변수(variable)이란? 프로그램(프로시져)에서 사용되는 데이터를 저장하는 공간 
PL/SQL에서 변수는 declare블록 안에서 아래와 같은 형식으로 선언/초기화를 함 
(declare, begin, exeption,end 중에서 declare 에서 변수 선언) 
1) 변수를 선언하면서 동시에 값을 할당(초기화)하는 경우 
형식: 변수이름 변수타입 := 값;
변수타입: 숫자, 문자, 날짜 ... 토끼이빨은 떨어지면 안되요 (:=) 
:= se llama assignment (할당)/ in Korean, 대입연산자 which is an equivalent of =
assignment not of distribution (할당) but more of designating a title 
2)변수를 선언만 하고; 값을 할당(초기화)하지 않는 경우 
  변수이름 데이터타입; 
  - 반드시 해당 문장전에는 저장된 값이 있어야한다 (선 값 저장 후 출력) 
  - 초기화 되지 않은 변수는 begin블록 안에서 반드시 초기화를 해야한다 
  - 초기화한다: 값을 저장한다 (적어도 한번은 저장해야한다) 
PL/SQL의 변수 이름은 대/소문자를 구분하지 않음
하지만 변수에 저장된 값은 구분합니다!! 
a := 'abc'
b := 'ABC'
> 이럴땐 a나 b나 인거지 
*/

-- || 왼쪽과 오른쪽을 붙여서 하나의 문자열을 만든다 by. pipeline

declare -- 변수 선언부
    -- 변수 선언과 동시에 초기화 
    v_age number(3) := 16;  
    -- = 는 비교할 때, := 저장할 때 
    
    --변수 선언만 하는 경우 
    v_name varchar2(20);
    -- 값을 저장하지 않음, 이름만 붙여주는 것> 선언한다라고 표현 
begin -- 실행부 
    -- 화면/콘솔 출력 
    dbms_output.put_line('나이: ' ||v_age); 
    -- 이거슨 함수여/ 줄 단위로 출력?  
    -- v_name 은 초기화되지 않은 변수, v_namedms null
    -- 선언부에서 초기화되지 않은 변수는 실행부에서 초기화(값을 저장)함 
    v_name := '오쌤';
    dbms_output.put_line('이름: '|| v_name); 
end; 
/

-- 용어정리 
-- declare, declaration (선언): 변수의 이름과 변수의 데이터 타입을 말하는 것 
-- assign, assignment(할당): 선언된 변수에 값을 저장/변경 하는 것 (:=) 
--initialize, initialization(초기화): 변수에 최초로 값을 저장(할당)하는 것 


accept p_age prompt '나이가 어떻게 되세요~?';
-- prompt 창 이 열린다,,,! 
-- 숫자 입력하면 p_age변수에 저장된다 
declare 
    v_age number := &p_age;
    --&연산자: 프롬프트 창에서 입력받은 값을 저장하는 변수를 참조 ( reference) 
    -- 참조한다 ~ 찾아간다 
    -- prompt 창의 value를 찾아가려면 variable 앞에 & 붙여준다 
begin
    dbms_output.put_line('당신의 나이는 '||v_age);
end;
/
 
-- 프롬프트 창에서 직사각형의 가로와 세로 길이를 입력받아서, 
-- 직사각형의 넒이를 계산하고, 그 결과를 화면(콘솔)에 출력 
accept t_area prompt '가로와 세로의 길이를 입력하시오';

-- length * width 

accept t_width prompt '가로의 길이를 입력하시오';
accept t_height prompt '세로의 길이를 입력하시오';

declare 
    t_area number := &t_width * &t_height;
begin 
    dbms_output.put_line('직사각형의 넓이는'||t_area);
end;
/
accept t_width prompt '가로의 길이를 입력하시오';
accept t_height prompt '세로의 길이를 입력하시오';
begin 
  dbms_output.put_line('직사각형의 넓이는'||(&t_width * &t_height));
  end;
/

accept p_width prompt '가로의 길이를 입력하시오';
accept p_height prompt '세로의 길이를 입력하시오';
declare 
    v_width number := &p_width;
    v_height number := &p_height;
    v_area number;
begin 
    v_area := v_width * v_height;
    dbms_output.put_line('가로 = '||v_width);
    dbms_output.put_line('세로 = '||v_height);
    dbms_output.put_line('넒이 = '||v_area);
end;
/
    










