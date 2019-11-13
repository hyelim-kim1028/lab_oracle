--hr ����
-- �μ��� �޿� �ּڰ� 
select min(salary) from employees 
group by department_id;

select employee_id,first_name, salary, department_id 
from employees
where salary in (
      select min(salary) from employees 
      group by department_id
);  
-- �̷��� ã���� min salary�� ���� ����. Salary �� ��� ã�� ������ > �� department �� minimum�� �ٸ� department �� �̴ϸ� ���� ������, �ߺ��Ǵ� dept���� �̴ϸ��� �������� ���� ���� �ִ� ��  


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

-- �μ��� �������� ���ÿ� ��� ���ϸ� �μ����� �ּڰ��� ��ġ�ϴ� ����� ������ �ȴ� 
-- �� ǥ���� department_id  �� null �� ��� �� ������ �ȴ� (dept_id = null �� ����, �׷��� dept_id is null�� ������Ѵ�) 


