--SUBQUERY
-- select  문에 들어가는 또다른 subquery : 조건문 뿐만 아니라 다른 곳에도 들어간다 

--BEFORE to find out the manager's name
--사번이 7369번 사원의 매니저의 사번 
select mgr
from emp 
where empno=7369;
--매니저 이름 알아내기 
select ename 
from emp
where empno=7902;

-- Using the subquery
select ename from emp 
where emp=??;

select ename from emp 
where empno =(
      select mgr from emp where empno = 7369
);

--단일행 Sub Query 
-- 결과값이 1개 

--다중행 서브 쿼리 
-- 결과값이 여러가지 행으로 돌아오는 것 

-- 사원 테이블에서 평균 급여보다 더 많은 급여를 받는 직원들만 출력 

--My Answer 
select empno, avg(sal) 
from emp 
where empo > (
      select avg(sal) from emp where empno > avg(sal));

-- Teacher's Answer 
select 
from emp
where sal>??? ;

select 
from emp
where sal> () ;

select *
from emp
where sal> (
      select avg(sal) from emp 
);
-- subquery 에서 나온 값과 emp에서 나온 값과 비교하여 출력 
-- 단일행: 중간에 있는 subquery 가 답 1개만 던져주는 그런 모습 

-- primary key: 절대 중복되지 않는 값, 선두에 있는 컬럼 (i.e. empno) 

--Allen 보다 커미션을 더 많이 받는 직원 정보 출력 
select *
from emp 
where comm > (
    select comm from emp where ename = 'ALLEN') ; 
-- subquery: Allen 이라는 사람이 받는 커미션을 찾았다 
-- 우리는 직원 테이블에서 엘런의 커미션과 비교 (null은 비교하지 않는다) 
-- 위는 조금 위험한 코드, 엘런이 두명이라면? (아래) 조금 더 확실한 코드 /empno사용 
select *
from emp 
where comm > (
    select comm from emp where empno = 7499) ; 

--다중행 서브 쿼리 
-- 서브쿼리의 결과가 여러게가 나온다. 같으 쓰는 연산자: ALL, ANY...등등 

-- 부서 번호가 20번 또는 30번인 직원들의 정보를 출력한다 
select * 
from emp 
where deptno = 20 or deptno = 30;
-- 윗쪽에 있는 코드를 같은 의미로 새로이 쓸 수 있는게 in이라는 연산자 이다 
select * 
from emp 
where deptno in (20,30);
-- 이제는 두개 이상의 것과 비교한다 > 서브쿼리도 행이 여러개 오는 것이 와야한다 
-- 저 in (20,30) 자리에 서브 쿼리를 넣는다 in 대신 all,any 도 쓸 수 있다 

-- 각 부서에서 급여가 가장 낮은 직원의 정보를 출력 
select min(sal) from emp group by deptno;
-- 각 부서의 미니멈 값을 대입하여 
select * from emp where sal in (950,800,1300);

-- 위와 아래는 같은 결과를 준다 (pero del abajo es inefficiente)  

select * 
from emp 
where sal in (
      select min(sal) from emp group by deptno
      );
      
--다중 컬럼 서브 쿼리 
-- in 앞으로 select문장을 또 만듦으로써 두 컬럼을 비교 

-- 각 비교에서 급여 최솟값을 받는 직원 정보를 출력하고 싶다 
select deptno, min(sal)
from emp 
group by deptno; 
-- 컬럼을 두개 출력할 수 있게끔 쿼리문을 만들어 보았따, 이 쌍들의 집합을 비교하도록 만들자 

select * from emp where (deptno,sal) in (
    select deptno, min(sal)
    from emp 
    group by deptno
    ); 
-- 두개를 동시에 비교하는 것/ 이유: 정확성을 더 높이기 위해서 
-- 왜냐하면, 최소값만 구하면, 한 부서의 최속값만이 아니라 다른 중복된 값이 나올 수도 있따 
-- 하지만, 둘을 동시에 비교한다면, (comparing in pair) 다른 값들은 누락 되고 진짜 dept 마다 가장 낮은 값만 남는다 

-- all, any (이 안에 하나라도 맞는게 있으면), in (이 안에 하나라도 맞는게 있으면) 


-- 서브 쿼리와 올 / 애니 

select * from emp where (deptno,sal) in (
    select deptno, min(sal)
    from emp 
    group by deptno
    ); 

-- or / any 비교 혹은 같냐 =/>
-- in  은 > 이거에서는 사용 불가 

select min(sal) from emp group by deptno; 
--3개의 값 from three different departments 
-- then find the employees correspond to these min salaries 
select * from emp 
where sal = any ( 
     select min(sal) from emp group by deptno
); 
-- in에서는 등호 (=)가 없었다, 거기서는 인이 등호 역할을 하는 것, 동등비교 
-- any 는, 이 아이 자체에는 같다라고 하는 의미는 없다, 여기 있는 것들 중에 하나 라는 의미만 있다 

-- 아래 문장을 A라고 할 때 
select min(sal) from emp group by deptno; 
-- Para conseguir following Phrases en la forma de subquery que lleva la misma meaning: anadir A en (950,800,1300) 
select*from emp where sal in (950,800,1300);
select * from emp where sal = any (950,800,1300);
-- in = =any > 그럼 왜 any를 쓰죠? in은 크다, 작다의 등호를 쓸 수 없다 (<,>) 
select * from emp where sal > any (950,800,1300);
-- 950,800,1300 중 아무거나 크면 > 800 보다 크면 된다 > 800 은 전체 population 중에 가장 minimum 이라 800 빼고 나머지 다 
select * from emp where sal = all (950,800,1300);
--False: 문법적인 오류가 아니라 에러는 안뜨지만, 데이터가 나오지 않는다 
-- 뜻: 950,800,1300 모두와 같은 데이터를 찾아주세요 > 존재할 수 없다 
select * from emp where sal > all (950,800,1300);
-- 뜻: 이 모두 보다 큰 데이터 > 1300 보다 큰 수를 찾아야한다 

-- El ejemplo de la combinacion (El subquery) 
select * from emp where sal > all (
         select min(sal) from emp group by deptno
);











