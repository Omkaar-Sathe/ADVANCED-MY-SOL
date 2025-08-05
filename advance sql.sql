 create database advance_sql1;
 
 use advance_sql1;
 
 create table departments(
 dept_id int primary key,
 dept_name varchar(50)
 );
 
 
 create table employees(
 emp_id int primary key,
 emp_name varchar(100),
 salary decimal(10,2),
 dept_id int,
 manager_id int,
 join_date date,
 foreign key (dept_id) references departments(dept_id),
 foreign key (manager_id) references employees(emp_id)
  );
  
  insert into departments values
  (1,'hr'),
  (2,'finance'),
  (3,'it');
  
  insert into employees values
(101,'alice',60000,1,null,'2021-01-10'),
(102,'bob',50000,1,101,'2021-02-15'),
(103,'charlie',55000,2,101,'2021-03-20'),
(104,'david',70000,3,null,'2021-04-01'),
(105,'evw',65000,3,104,'2021-05-10'),
(106,'frank',45000,2,103,'2021-06-18');   

select * from departments;       
select * from employees;
  
-- self join:show employees and their managers
select E.emp_name as employees,M.emp_name as manager from employees E 
left join employees M on E.manager_id = M.emp_id;

-- employees with above avg salary 
   select emp_name,salary from employees
   where salary > (select avg(salary) as avg_salary from employees);
  
  -- window function:
  select emp_name, dept_id, rank () over (partition by dept_id order by salary desc) as salary_rank from employees;
  
  -- cte common table expreastion
  with deptmax as(select dept_id,max(salary)
  as max_salary 
  from employees
  group by dept_id)
  select e.emp_name,e.salary,d.dept_name 
  from employees e
  join deptmax dm on e.salary = dm.max_salary and
  e.dept_id=dm.dept_id
  join departments d on e.dept_id=d.dept_id;
  
  