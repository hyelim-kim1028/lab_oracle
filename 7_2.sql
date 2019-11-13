-- Session, Transaction, Lock 
/*SQL 종류 
- DML (Data Manipulation Language): 데이터 조작 언어 
- insert, update, delete (can be converted or changed) 
- a change in a row is what oracle calls 'manipulation'
-DDL (Data Definition Language): 데이터 정의 언어 
 - 테이블을 어떻게 만들꺼냐 에 대한 언어 
 - 실제 데이터/정보를 추가, 정보, 삭제 는 DML,  하지만 그것의 포맷을 만들고, 삭제하고 수정하는 것은 DDL 
 - 테이블 자체를 생성(create), 변경(alter), 삭제(truncate/to cut & drop/to remove)
 - select is under DQL (Data Query Language) : 데이터 쿼리(질의) 언어
 - commit & rollback : transaction control language: 트랜젝션 관리 언어 
*/

select * from dept2;
-- the data has been committed, thus if it were commanded properly, it must be seen from cmd as well 

update dept2
set loc='서울Seoul'
where deptno=50;

-- it hasn't been committed, but i can be seen from sqldeveloper. However, it cannot be seen from cmd (sqlplus)
-- it is only stored in memory not db 

-- 이렇게 sqlplus 와 sqldeveloper 에 대한 정보의 차이가 있고, 무언가를 변경하려고 하려면 > lock 이 걸리는 것 
-- SQL> update dept2
 -- 2  set dname ' '오라클'
  --3  where deptno = 50;
-- ERROR:
-- ORA-01756: 단일 인용부를 지정해 주십시오
-- 이게 row lock (행 락걸린것) 
-- how to solve: do commit 

commit;
-- 반대로, developer 에서 락이 걸리게됨 (we have changed dname from Oracle to 오라클 from sqlplus) 

-- developer에서는 50번에 락 , plus에서는 60번을 락 > 그래서, 50번은 plus 는 access 안되고, 60번은 developer 에서 access 안됨 

commit;

-- 둘 다 커밋을 하면 이제는 둘 다 같은 데이터를 본다 

select * from dept2;

insert into dept2 values (90,'ITWILL','GANGNAM');
select * from dept2;
commit;
-- 커밋을 하지 않으면  developer 와 plus 가 동상이몽,,, ^^ 

-- table 단위의 lock은 언제 걸리나요? 
-- 데이터 정의어 사용 불가 (무슨 뜻이죠) 
-- 예) 10 - accounting - new york 을 변경하고 있다가, 새로운 컬럼을 수정한다거나, 아니면 컬럼의 데이터 타입을 바꾼다거나 한다면 전체 컬럼에 대한 변경 
-- 그런 명령어가 테이블 단위의 락이 걸린다 

update dept2 
set loc = '뉴욕' 
where deptno = 10;
-- has been updated > and locked > 
select * from dept2;

--it's been changed and now go to cmd 
-- SQL> truncate table dept2;
-- truncate table dept2
--               *
--1행에 오류:
--ORA-00054: 리소스가 사용 중이어서 NOWAIT가 지정되었거나 시간 초과가 만료된
-- 상태로 획득합니다.
 
 -- 행도 락이 걸려있지만, 테이블도 락이 걸려있는것. plus 에서는 에러를 발생시켜서 truncate 을 못 하게함 
 -- 행이 하나 바뀌고 있는 중이라서 (커밋 아직 안함) 
 
 
 