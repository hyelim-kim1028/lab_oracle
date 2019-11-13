-- 09.17.2019 MARTES 
-- ex32 in teacher's file 

/*
컬랙션 - 같은 타입의 데이터 여러개를 저장 
* 3가지 컬랙션 - 3가지 컬렉션이 갖는 특징들이 각각 있다  
1) 연관 배열 (associative array or index-by table) 
    > 인덱스는 정수, 양의 정수, 문자열을 사용할 수 있음. 
    > type 연관 배열 이름 is table of 데이터 타입 index by 인덱스 타입; 
    > 저장할 수 있는 값들의 갯수에 제한이 없다 
    > 생성자 사용 안함 
    
2) 중첩테이블(nested table) 
    > 인덱스는 양의 정수만 가능하기 때문에 인덱스 타입(index-by)을 명시하지 않음 
    > type 중첩테이블 이름 is table of 데이터 타입 ; 
    > 저장할 수 있는 값들의 갯수에 제한이 없다 
    > 생성자 반드시 사용 
    
3) varray 
    > 가변 길이 배열 (variable-size array) 
    > 인덱스는 양의 정수만 가능하기 때문에 인덱스 타입(index-by)을 명시하지 않음  
    > type 테이블이름 is varray(limit) of ...(i.e. number,varchar2,date); 
    > varray가 선언할 때 저장할 수 있는 값의 범위/갯수를 지정함 (저장할 수 있는 값들의 갯수를 제한) 
    > 생성자 반드시 사용 
    

-- 생성자란 무엇인가! 

*/


set serveroutput on;

declare 
    -- 중첩 테이블 선언 
    type NumberArray is table of number; 
    -- number의 제한 없음 > 그래서 varray와 다르게 무한대로 확장 가능 
    -- 중첩 테이블 타입의 변수 선언 
    v_numbers NumberArray;    
begin 
    v_numbers(1) := 100;
end;
/
-- ERROR: "Reference to uninitialized collection"
-- 중첩 테이블은 반드시 생성자를 호출해서 초기화(initialize)를 해야함 
-- 초기화: 최소에 어떤 것에 값을 주는 것 

set serveroutput on;

declare 
    -- 중첩 테이블 선언 
    type NumberArray is table of number; 
    -- 중첩 테이블 타입의 변수 선언 
     v_numbers NumberArray;
begin 
  -- NewArray is the 생성자 here / 생성자의 이름은 타입의 이름과 같다 
    -- 괄호 안의 값들 (매개변수) > 생성자의 매개변수로 중첩 테이블/ varray 에 저장할 값들을 저장함 (띠용,,,@@??) 
    -- 배열을 만들어 주는 것> 생성자 
    -- 안에 배열에 저장할 값들을 넣어준다 (매개변수) 
 v_numbers := NumberArray(100,200,300); 
    
    -- 중첩 테이블에 저장된 값들을 출력 
    for i in 1..v_numbers.count loop 
        dbms_output.put_line(i||' : '||v_numbers(i));
        end loop;
        
        -- 중첩 테이블에 값을 추가 
        -- extend(갯수)를 호출해서 배열이 저장할 수 있는 원소의 갯수를 늘려준 후 
        -- 값을 추가해야 함. 
        v_numbers.extend(2);
        -- 2는 기존에 가지고 있는 갯수에 2개를 추가 (현: 3개 > 변화 후: 5개) 
        v_numbers(4) := 400;
        v_numbers(5) := 500;
        -- ERROR: subscript beyond count 
        -- 배열이 가지고 있는 원소의 갯수 > count > 4번은 안들어감 
        -- 함수(extend)를 쓰면 들어간다 (무한히 늘어나는 성질!) 
        
         for i in 1..v_numbers.count loop 
        dbms_output.put_line(i||' : '||v_numbers(i));
        end loop;
end;
/

-- varray 

declare 
    -- 선언 방식이 많이 다르다 
    -- varray 타입 선언 
    type NumberArray is varray(5) of number;    
    -- varray 타입의 변수를 선언 
    v_numbers NumberArray; 
begin 
    v_numbers(1) := 11; 
end;
/
-- varray 타입을 이렇게 실행하면 > 에러발생 (생성자 호출을 해야함) (ERROR:  "Reference to uninitialized collection")


declare 
    -- 선언 방식이 많이 다르다 
    -- varray 타입 선언 
    type NumberArray is varray(5) of number;    
    -- varray 타입의 변수를 선언 
    v_numbers NumberArray; 
begin 
    --v_numbers(1) := 11; 
    -- 생성자 호출 전에 varray를 사용할 수는 없다. 
    
    v_numbers := NumberArray(11,22,33); 
    dbms_output.put_line('count: '||v_numbers.count);
    dbms_output.put_line('limit: '||v_numbers.limit);
    -- limit의 설명은 노트북에 있다 
    
    for i in 1..v_numbers.count loop 
        dbms_output.put_line(i||' : '||v_numbers(i));
    end loop;
    
    -- v_numbers(4) := 44; 
    -- ERROR: subscript beyound count 
    -- 선언할 때 이미  5를 했지만, 아직 점선 상태 
    -- varray에 원소를 추가하고 싶다면, extend를 사용해서 원소 추가 
     v_numbers.extend(2);
     v_numbers(4) := 44;
     v_numbers(5) := 55; 
     
     for i in 1..v_numbers.count loop 
        dbms_output.put_line(i||' : '||v_numbers(i));
    end loop;
    
     dbms_output.put_line('count: '||v_numbers.count);
    dbms_output.put_line('limit: '||v_numbers.limit);
    
    --v_numbers.extend(5);
    -- ERROR: substript outside of limit 
    -- 5이상 extend 못 함 
end;
/

-- 연습문제 
-- 문자열 5개를 저장할 수 있는 varray를 StringArray라는 이름으로 선언 
-- StringArray 타입의 변수(v_names)를 선언 
-- 실행부분 안에서 v_names 를 원소가 없는 varray로 초기화 (생성자 호출) 
-- v_names가 저장하는 원소 5개의 갯수 5개를 확장 (extend) 그 후에 원하는 값들을 저장 

declare 
    type StringArray is varray(5) of varchar2(20); 
    
    v_names StringArray; 
begin 
    v_names := StringArray(); 
    -- 뒤에 () 안하면 에러남 
    
    dbms_output.put_line('count: '||v_names.count);
    dbms_output.put_line('limit: '||v_names.limit);
    
   v_names.extend(5);

    v_names(1) := 'Helena';
    v_names(2) := 'Hellena';
    v_names(3) := 'Elena';
    v_names(4) := 'Herena';
    v_names(5) := 'Herrena';
    
    for i in 1..v_names.count loop 
        dbms_output.put_line(i||' : '||v_names(i));
    end loop;
    
end;
/ 

-- 대부분 연관배열을 가지고 일할 수 있다 



