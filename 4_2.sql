--hr 계정
-- 부서별 급여 최솟값 
select min(salary) from employees 
group by department_id;

select employee_id,first_name, salary, department_id 
from employees
where salary in (
      select min(salary) from employees 
      group by department_id
);  
-- 이렇게 찾으면 min salary가 많이 나옴. Salary 만 잡고 찾기 때문에 > 한 department 의 minimum이 다른 department 의 미니멈 보다 낮으면, 중복되는 dept에서 미니멈이 여러개가 나올 수도 있는 것  


select department_id,min(salary)
from employees 
group by department_id;

select employee_id,first_name, salary, department_id 
from employees
where (department_id, salary) in (select department_id,min(salary)
from employees 
group by department_id
)
order by department_id;

-- 부서와 셀러리를 동시에 잡고 비교하면 부서별로 최솟값과 일치하는 사람만 나오게 된다 
-- 이 표에서 department_id  가 null 인 사람 은 빠지게 된다 (dept_id = null 은 누락, 그래서 dept_id is null을 해줘야한다) 


