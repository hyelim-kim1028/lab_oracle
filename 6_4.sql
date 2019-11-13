/*UPDATE and DELETE/ 레코드 수정,삭제*/

select * from ex_emp3;
-- emp를 그대로 복사했던 테이블 
-- from ex_emp3 table, please change the salary of an employee whose empno is 7369 to 2000
update ex_emp3 
set sal = 2000 
where empno = 7369;
select * from ex_emp3;

update ex_emp3 
set sal = 2000, comm = 7000 
where empno = 7369;
select * from ex_emp3;

-- update문장에서 where 절을 생략하면 테이블의 모든 행을 수정하게 됨 
-- 그러면 찾을 수 있는 행이 없기 때문에 일일이 변경해야함 

update ex_emp3 
set sal = 1234;
select * from ex_emp3;

-- commit을 안했을 경우, rollback 가능 
rollback;
select * from ex_emp3;
-- rollback은 최종 커밋 상태로 돌려준다 
-- transaction: commit으로 하나의 process가 완료되는 것 (transaction전까지 rollback 가능) 
-- commit해버리면 못 되돌려요,,,^^ 야근쓰,,,^^ 

-- delete 는 셀을 지우는게 아니라 행 전체를 지운다 
-- ex_emp3 테이블에서 부서 번호가 10번인 직원들의 데이터를 삭제하겠다 
delete from ex_emp3 
where deptno = 10;
select * from ex_emp3;

-- 만약 cell 하나만 바꾸겠다 > update > 값이 없다 null > update를 null로 하면 된다 
update ex_emp3 
set deptno=null 
where empno = 7369;
select * from ex_emp3;
-- 무엇인가를 null 로 바꿀 때는 = 을 사용하지만 (i.e. set sth as null > set sth = null), 
-- where 에서 null이다 null이 아니다 를 표기 할 때는 is/is not null 사용 
-- 제약조건이 not null이라고 되어있으면, update 할 때도 null로 못 함 (값이 반드시 있어야한다!) 
-- delete도 where 절 안주면 싹 다 지워벌임,,,^0^ 

commit;

-- delete 구문에서 where절을 사용하지 않으면 테이블의 모든 행이 삭제됨! 

-- 연습문제 ex_emp3 테이블에서 20번 부서에서 일하는 직원들의 수당 (comm)을 100으로 수정 (난 1000 으로 줬당,,,) 
update ex_emp3 
set comm=1000 
where deptno=20;
select * from ex_emp3;


--SUBQUERY 
--ex_emp3 테이블에서 급여가 평균보다 작은 직원들의 급여를 2배로 인상 
update ex_emp3
set sal = sal*2
where sal < (select avg(sal) from ex_emp3);
select * from ex_emp3;

rollback;
select * from ex_emp3;
select avg(sal) from ex_emp3;
--avg = 1843

update ex_emp3
set sal = sal*2
where sal < (select avg(sal) from ex_emp3);
select * from ex_emp3;

commit; 
