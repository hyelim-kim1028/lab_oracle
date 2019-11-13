--09.19.2019 ex_pkg
/*
연습문제 -- specification 작성 (쌤) 
-- 패키지 본문 (body) 작성 (과제) 

*/

set serveroutput on; 

create or replace package my_stat 
is
    -- index by table 만들기 (숫자 타입을 저장하고, index는 양의 정수인 index-by 테이블을 선언)  
-- 
--table_name type_name;
--   함수만들기 
--   * 함수 이름: sum 파라미터에 전달 받은 배열에 있는 모든 원소들의 합을 리턴하는 합수 
--   * 기능: @param arr NumberArray 
--    
--    * 함수 2: avg 파라미터에 전달받은 배열에 있는 모든 원소들의 편균을 계산해서 리턴 
--    * @param arr NumberArray 
--    *@param digit number  리턴 값(평균)의 소숫점 이하 자릿수, 기본값 3 (소숫점 이하 3자리 까지 표시) 
--    
--    *함수 3: var 원소들의 분산을 계산해서 리턴 
--          * @param arr NumberArray 
--    *@param digit number  리턴 값(평균)의 소숫점 이하 자릿수, 기본값 3 (소숫점 이하 3자리 까지 표시)0

--    *함수 4: std 원소들의 분산을 계산해서 리턴 
--          * @param arr NumberArray 
--    *@param digit number  리턴 값(평균)의 소숫점 이하 자릿수, 기본값 3 (소숫점 이하 3자리 까지 표시)

--    *함수 6: max 원소들의 표준편차을 계산해서 리턴 
--          * @param arr NumberArray 


--    *함수 8: min 원소들의 표준편차을 계산해서 리턴 
--          * @param arr NumberArray 

end; 
/


create or replace package my_stat 
is
    -- 타입 선언
     type NumberArray is table of number index by pls_integer; 
    
    -- 함수 프로토타입 선언
    function sum (arr NumberArray) return number;
    function avg (arr NumberArray, digit number) return number; 
    function var (arr NumberArray, digit number) return number; 
    function std (arr NumberArray, digit number) return number; 
    function max (arr NumberArray) return number;
    function min (arr NumberArray) return number;
    
end;
/

