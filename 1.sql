 -- 주석(comment): 실행문장이 아닌 설명 
 select table_name from user_tables;
 
 -- 테이블의 자료 타입 확인 
desc dept;

-- 오라클 자료 타입 (data typle) : 굉장히 많이 있지만, NUMBER, VARCHAR2, DATE을 가장 많이 사용함 
-- number (전체자릿수, 소숫점자릿수) : 숫자 타입 
-- varchar2 (문자열길이): 문자열 (string)/ 가변 길이 문자열 (variable-length characters/string) 타입
-- 문자열의 길이를 주는 이유: 최대 몇 글자 까지~ 정해주기 
-- date: 시간 (yy/bb/dd hh/mm/ss) 정보를 저장하는 타입 
-- 등등 

desc emp;

-- 테이블 전체 데이터 (레코드) 출력
select * from emp;

 