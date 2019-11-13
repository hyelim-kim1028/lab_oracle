-- 제약조건 (constraint) 

-- 접속한 사용자 계정의 테이블들에 적용된 제약조건 확인 
select constraint_name, constraint_type, table_name
from user_constraints;

select table_name from user_tables;

-- 제약조건의 종류들 
-- not null : 반드시 값이 있어야하는 column 
-- unique: 저장되는 값들이 중복되어서는 안된다 (no repeated value) 
-- Primary Key (PK)/고유키/P:  테이블에서 유일한 한개의 행(레코드)를 검색할 수 있는 컬럼 
-- Foreign Key (FK)/ 외래키,외부키 / R:관계를 맺고 있는 다른 테이블의 PK 
-- not null, unique > constraint type (C = check?) 
-- check: 조건(condition)을 체크하는 제약조건 
--i.e. If we mae a column titled 'age' which cannot have a minus number (negative number) 
-- so we put a condition like age >= 0
-- default: column의 기본값 (insert하지 않아도 자동으로 저장되는 값) 을 설정 (i.e. 시간에 null, age에 0 등) 

create table ex03(
      col1 number unique, 
      col2 varchar2(20) not null 
);





