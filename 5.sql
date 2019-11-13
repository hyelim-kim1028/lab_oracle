--2. hr 계정
--1) employees, job_history, jobs 테이블을 사용해서
--사번, 이름, 성, job_id, job_title, job 시작일, job 종료일을 출력.

-- ORACLE METHOD 
select e.employee_id, e.first_name,e.last_name, e.job_id,j.job_title, jh.start_date, jh.end_date
from employees e,jobs j, job_history jh
where e.job_id = j.job_id;

--ANSI Method 
select e.employee_id, e.first_name,e.last_name, e.job_id,j.job_title, jh.start_date, jh.end_date
from employees e join jobs j
on e.job_id = j.job_id
     join job_history jh
     on e.employee_id = jh.employee_id;
-- PROBLEM: the oracle method works but the ANSI method doesnt 
-- there was a missing sequel: on e.employee_id = jh.employee_id;;


-- teacher's solution 
-- ORACLE METHOD 
select e.employee_id, e.first_name, e.last_name, 
       e.job_id, j.job_title,jh.job_id,j2.job_title,jh.start_date, jh.end_date
from employees e,jobs j,job_history jh, jobs j2
where e.job_id = j.job_id 
      and
      e.employee_id = jh.employee_id
      and
      jh.job_id = j2.job_id
order by e.employee_id, jh.start_date;

--ANSI METHOD 
select e.employee_id, e.first_name, e.last_name, 
       e.job_id, j.job_title,jh.job_id,j2.job_title,jh.start_date, jh.end_date
from employees e join jobs j
     on e.job_id = j.job_id 
     join job_history jh
      on e.employee_id = jh.employee_id
      join jobs j2
      on jh.job_id = j2.job_id
order by e.employee_id, jh.start_date;
      
-- THESE PROGRAMS ARE SUPER SPELLING CONSCOUS TO THE VERY GROUND LIKE COMMA OR DOT 
-- BE CAREFUL ALWAYS * 10000 
    
--2) employees, departments 테이블을 사용해서
--부서번호, 부서이름, 매니저 아이디, 매니저 이름/성을 출력.
--단, 부서 테이블의 모든 부서 이름이 출력되도록.


--ORACLE METHOD 
select e1.department_id, d.department_name, e1.manager_id, e2.first_name, e2.last_name
from employees e1, employees e2, departments d
where e1.department_id(+)= d.department_id and e1.manager_id=e2.manager_id;

--ANSI METHOD 
select e1.department_id, d.department_name, e1.manager_id, e2.first_name, e2.last_name
from employees e1 right join employees e2
on e1.manager_id=e2.manager_id
join departments d
on e1.department_id= d.department_id;

-- Teacher's solution 
select d.department_id, d.department_name, d.manager_id, 
       e.first_name, e.last_name 
from departments d, employees e 
where d.manager_id = e.employee_id (+)
order by department_id;

-- manager_id 를 가지고, 그 사람을 찾아내야한다 > 그래서 employees table을 join해줌 > equijoin (내부join) 
-- left join ( 왼쪽에 있는건 다 무조건 출력하겠다) > 그래서 데이터 없는 부분은 null로 추가 
-- 그 후에 outer join 을 이용해서 (단, 부서 테이블의 모든 부서 이름이 출력되도록) 실행 


-- ANSI METHOD 
select d.department_id, d.department_name, d.manager_id, 
       e.first_name, e.last_name 
from departments d left join employees e 
on d.manager_id = e.employee_id
order by department_id;

--여기까지 복사 

-- EX 03 사번, 이름, 지역 이름 
select e.employee_id, e.last_name, 
       d.department_id, d.location_id, 
       l.location_id,l.country_id,
       c.country_id, c.region_id,
       r.region_id, r.region_name 
from employees e, departments d, locations l, countries c, regions r 
where e.department_id = d.department_id (+)
      and
      d.location_id = l.location_id(+)
      and 
      l.country_id = c.country_id (+)
      and
      c.region_id = r.region_id (+)
order by e.employee_id;

   
select e.employee_id, e.last_name, 
       d.department_id, d.location_id, 
       l.location_id,l.country_id,
       c.country_id, c.region_id,
       r.region_id, r.region_name 
from employees e left join departments d
on e.department_id = d.department_id 
      left join locations l
      on d.location_id = l.location_id
      left join countries c 
      on l.country_id = c.country_id 
      left join regions r 
      on c.region_id = r.region_id
order by e.employee_id;



























