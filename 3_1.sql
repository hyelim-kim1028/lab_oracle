desc employees;

select EMPLOYEE_ID, FIRST_NAME,LAST_NAME 
from EMPLOYEES 
where FIRST_NAME like 'J%';

-- what if we do '%J%'? FAIL. There are J and js in the middle of the name
-- a. where FIRST_NAME like '%J%' or FIRST_NAME like '%j%';
-- b. 함수사용  

select employee_id, first_name, phone_number 
from employees 
where phone_number like '011%';

select employee_id, first_name, manager_id, department_id 
from employees 
where manager_id=120;

select * 
from employees 
where employee_id = 120;

select employee_id, first_name, salary 
from employees 
where salary >=3000 and salary <=5000;

select employee_id, first_name, salary 
from employees 
where salary between 3000 and 5000;


select employee_id, first_name, salary, commission_PCT,
    (salary * 12) * (1+commission_pct) as annual_salary 
from employees 
where commission_pct is not null;





