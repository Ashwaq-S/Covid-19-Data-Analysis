create database Employee

exec sp_renamedb employee , Corporate
use Corporate


drop table if exists location
CREATE TABLE Location (
    Location_ID INT Primary key,
    City VARCHAR(255)
)

INSERT INTO Location (Location_ID, City)
VALUES 
    (122, 'New York'),
    (123, 'Dallas'),
    (124, 'Chicago'),
    (167, 'Boston')

create table Department(Department_ID INT Primary key,Name varchar(250),
			Location_ID INT fOREIGN KEY(Location_ID) REFERENCES LOCATION(LOCATION_ID))

INSERT INTO Department VALUES  
	(10, 'Accounting', 122),
    (20, 'Sales', 124),
    (30, 'Research', 123),
    (40, 'Operations', 167)

   
CREATE TABLE Job (
    Job_ID INT PRIMARY KEY,
    Designation VARCHAR(255)
)

INSERT INTO Job (Job_ID, Designation)
VALUES 
    (667, 'Clerk'),
    (668, 'Staff'),
    (669, 'Analyst'),
    (670, 'Sales Person'),
    (671, 'Manager'),
    (672, 'President')

	CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Last_Name VARCHAR(255),
    First_Name VARCHAR(255),
    Middle_Name VARCHAR(255),
    Job_ID INT,
    Hire_Date DATE,
    Salary DECIMAL(10, 2),
    Commission DECIMAL(10, 2),
    Department_ID INT,
    FOREIGN KEY (Job_ID) REFERENCES Job(Job_ID),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
)

INSERT INTO Employee (Employee_ID, Last_Name, First_Name, Middle_Name, Job_ID, Hire_Date, Salary, Commission, Department_ID)
VALUES 
    (7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800, NULL, 20),
    (7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600, 300, 30),
    (755, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850, NULL, 30),
    (756, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750, NULL, 30),
    (757, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200, NULL, 40),
    (7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250, 50, 30)

--Simple Queries:

---1. List all the employee details. 

Select * from Employee


---2. List all the department details.

Select * from Department


---3. List all job details. 

Select * from job


---4. List all the locations.

select City from location


---5. List out the First Name, Last Name, Salary, Commission for all Employees.

select First_Name, Last_Name, Salary, Commission from Employee


/*6. List out the Employee ID, Last Name, Department ID for all employees and
alias
Employee ID as "ID of the Employee", Last Name as "Name of the
Employee", Department ID as "Dep_id".*/

select  Employee_ID 'ID of the Employee', Last_Name 'Name of the Employee', Department_ID 'Dep_id' from Employee


---7. List out the annual salary of the employees with their names only.

select concat(first_name,' ',middle_name,' ',Last_Name ) Full_name,(salary*12) Annual_salary from employee

--WHERE Condition:

--1. List the details about "Smith"

select * from job J
  JOIN EMPLOYEE E  ON J.Job_ID=E.Job_ID
  JOIN DEPARTMENT D ON D.Department_ID=E.Department_ID
  JOIN LOCATION L ON L.Location_ID=D.Location_ID
  WHERE E.Last_Name='SMITH'

--2. List out the employees who are working in department 20.

SELECT * FROM Employee WHERE Department_ID=20



--3. List out the employees who are earning salaries between 3000and4500.

SELECT * FROM Employee WHERE SALARY BETWEEN 3000 AND 4500
          /*no employee salary is between 3000 AND 4500 in employee table*/



--4. List out the employees who are working in department 10 or 20

SELECT * FROM Employee WHERE Department_ID IN (10,20)



--5. Find out the employees who are not working in department 10 or 30.

SELECT * FROM Employee WHERE Department_ID NOT IN (10,30)



--6. List out the employees whose name starts with 'S'.

SELECT * FROM Employee WHERE Last_Name LIKE 'S%' 
		
--7. List out the employees whose name starts with 'S' and ends with'H'.

SELECT * FROM Employee WHERE Last_Name LIKE 'S%' and Last_Name LIKE '%H' 


--8. List out the employees whose name length is 4 and start with 'S'.

SELECT * FROM Employee WHERE LEN(LAST_NAME)=4 AND Last_Name LIKE 'S%' 
           

--9. List out employees who are working in department 10 and drawsalariesmorethan 3500. 

SELECT * FROM Employee WHERE Department_ID=10 AND SALARY>3500


--10. List out the employees who are not receiving commission.

SELECT * FROM Employee WHERE Commission IS NULL

--ORDER BY Clause:

--1. List out the Employee ID and Last Name in ascending order based on the
--Employee ID.

select Employee_id,last_name from employee order by Employee_ID


--2. List out the Employee ID and Name in descending order based onsalary.

select Employee_id,concat(first_name,' ',middle_name,' ',last_name) full_Name
            from Employee order by salary desc


--3. List out the employee details according to their Last Name in ascending-order.

select * from employee order by last_name



--4. List out the employee details according to their Last Name in ascending
--order and then Department ID in descending orde     

select * from employee order by last_name,Department_ID desc


--GROUP BY and HAVING Clause:

--1. How many employees are in different departments in the organization?

select e.Department_id,name,count(*) count_of_employees
        from employee e 
        join department d on e.department_id=d.Department_ID
		group by e.Department_id,d.name
		 

--2. List out the department wise maximum salary, minimumsalary andaverage salary of the employees.

select max(e.salary) max_salary,min(e.salary) min_salary,avg(e.salary) avg_salary,e.department_id,d.name 
           from employee e join department d on e.Department_ID=d.Department_ID
           group by e.Department_ID,d.name


--3. List out the job wise maximum salary, minimum salary and averagesalary of the employees.

select max(e.salary) max_salary,min(e.salary) min_salary,avg(e.salary) avg_salary,e.job_id,j.designation
          from employee e join job j on e.job_ID=j.job_ID
		  group by e.Job_ID,j.designation

--4. List out the number of employees who joined each month in ascendingorder

select month(hire_date) hire_month,datename(month,hire_date) hire_month,count(*) count_of_employees_hired from employee
            group by month(hire_date),datename(month,hire_date)
			order by month(hire_date)


--5. List out the number of employees for each month and year in
---ascending order based on the year and month. 

select year(hire_date) hire_year,month(hire_date) hire_month,datename(month,hire_date) hire_month,
       count(*) count_of_employees_hired
          from Employee
		  group by year(hire_date),month(hire_date),datename(month,hire_date)
		  order by year(hire_date),month(hire_date)



--6. List out the Department ID having at least four employees.

select department_id from employee 
       group by department_id
       having count(*)>=4


--7. How many employees joined in the month of January?

select month(hire_date) hire_month,datename(month,hire_date) hire_month,
       count(*) count_of_employees_hired from Employee
      group by month(hire_date),datename(month,hire_date)
	  having datename(month,hire_date)='January'


--8. How many employees joined in the month of January or September?

select month(hire_date) hire_month,datename(month,hire_date) hire_month,
       count(*) count_of_employees_hired from Employee
      group by month(hire_date),datename(month,hire_date)
	  having datename(month,hire_date)='January'OR datename(month,hire_date)='September'


--9. How many employees joined in 1985?

select YEAR(hire_date) hire_Year,count(*) count_of_employees_hired 
       from Employee
	   group by YEAR(hire_date)
	   having YEAR(hire_date)=1985


--10. How many employees joined each month in 1985?

select YEAR(hire_date) hire_Year,month(hire_date) hire_month,
       datename(month,hire_date) hire_month,count(*) count_of_employees_hired 
       from Employee
	   group by YEAR(hire_date),month(hire_date),datename(month,hire_date)
	   having YEAR(hire_date)=1985

--11. How many employees joined in March 1985?

select YEAR(hire_date) hire_Year,month(hire_date) hire_month,
       datename(month,hire_date) hire_month,count(*) count_of_employees_hired 
       from Employee
	   group by YEAR(hire_date),month(hire_date),datename(month,hire_date)
	   having YEAR(hire_date)=1985 and datename(month,hire_date)='March'


--12. Which is the Department ID having greater than or equal to 3 employeesjoining in April 1985?

select department_id,YEAR(hire_date) hire_Year,month(hire_date) hire_month,
       datename(month,hire_date) hire_month,count(*) count_of_employees_hired 
	   from Employee
	   where YEAR(hire_date)=1985 and datename(month,hire_date)='April'
	   group by department_id,YEAR(hire_date),month(hire_date),datename(month,hire_date)
	   having count(*)>=3

--Joins:

--1. List out employees with their department names.

select e.employee_id,e.last_name,e.First_Name,e.Middle_Name,d.Name
from Employee e join  Department d on e.Department_ID=d.Department_ID



--2. Display employees with their designations.

select e.employee_id,e.last_name,e.First_Name,e.Middle_Name,j.Designation
       from Employee e join  JOB J on e.JOB_ID=J.JOB_ID


--3. Display the employees with their department names and regional groups.

select e.employee_id,e.last_name,e.First_Name,e.Middle_Name,d.Name,l.City from Employee e join 
		Department d on e.Department_ID=d.Department_ID
		join location l on l.Location_ID=d.Location_ID

--4. How many employees are working in different departments? Display with
--department names.

select d.Name,count(*) count_of_employees from Employee 
       e join  Department d on e.Department_ID=d.Department_ID
	   group by d.Name



--5. How many employees are working in the sales department?

select d.Name,count(*) count_of_employees from Employee 
       e join  Department d on e.Department_ID=d.Department_ID
	   where d.name='sales'
	   group by d.Name


--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.

select d.Name,count(*) count_of_employees from Employee 
       e join  Department d on e.Department_ID=d.Department_ID
	   group by d.Name
	   having count(*)>=5


--7. How many jobs are there in the organization? Display with designations.

select j.Designation,count(*) count_of_employees
       from Employee e join  JOB J on e.JOB_ID=J.JOB_ID
	   group by j.Designation

--8. How many employees are working in "New York"?

select l.City,count(*) count_of_employees 
        from Employee e
		join Department d on e.Department_ID=d.Department_ID
		join location l on l.Location_ID=d.Location_ID
		 where l.city='new york'
		group by l.City

--9. Display the employee details with salary grades. Use conditional statement to create a grade column.

SELECT *,
Case
     when salary>2500 then 'grade A'
	 when salary>2000 then 'grade B'
	 when salary>1500 then 'grade C'
	 ELSE 'grade D'
	 END Salary_grades
FROM Employee


--10. List out the number of employees grade wise. Use conditional statement to create a grade column. 

SELECT count(*) count_of_employees,
Case
     when salary>2500 then 'grade A'
	 when salary>2000 then 'grade B'
	 when salary>1500 then 'grade C'
	 ELSE 'grade D'
	 END Salary_grades
FROM Employee
group by 
Case
     when salary>2500 then 'grade A'
	 when salary>2000 then 'grade B'
	 when salary>1500 then 'grade C'
	 ELSE 'grade D'
	 END


--11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.

SELECT count(*) count_of_employees,
Case
     when salary>2500 then 'grade A'
	 when salary>2000 then 'grade B'
	 when salary>1500 then 'grade C'
	 ELSE 'grade D'
	 END Salary_grades
FROM Employee
where salary between 2000 and 5000 
group by 
Case
     when salary>2500 then 'grade A'
	 when salary>2000 then 'grade B'
	 when salary>1500 then 'grade C'
	 ELSE 'grade D'
	 END

--12. Display all employees in sales or operation departments

select * from Employee 
       e join  Department d on e.Department_ID=d.Department_ID
	   where d.name='sales'or d.name='operations'

--SET Operators:

--1. List out the distinct jobs in sales and accounting departments.

SELECT j.designation
FROM job j
JOIN employee e ON j.job_id = e.job_id
JOIN department d ON e.department_id = d.department_id
WHERE d.name =  'Sales'

UNION

SELECT j.designation
FROM job j
JOIN employee e ON j.job_id = e.job_id
JOIN department d ON e.department_id = d.department_id
WHERE d.name = 'Accounting'


--2. List out all the jobs in sales and accounting departments.

SELECT j.designation
FROM job j
JOIN employee e ON j.job_id = e.job_id
JOIN department d ON e.department_id = d.department_id
WHERE d.name =  'Sales'

UNION all

SELECT j.designation
FROM job j
JOIN employee e ON j.job_id = e.job_id
JOIN department d ON e.department_id = d.department_id
WHERE d.name = 'Accounting'


--3. List out the common jobs in research and accounting
--departments in ascending order

SELECT j.designation
FROM job j
JOIN employee e ON j.job_id = e.job_id
JOIN department d ON e.department_id = d.department_id
WHERE d.name =  'Research'

intersect

SELECT j.designation
FROM job j
JOIN employee e ON j.job_id = e.job_id
JOIN department d ON e.department_id = d.department_id
WHERE d.name = 'Accounting'
order by j.designation 

--Subqueries:

--1. Display the employees list who got the maximum salary.

select  * from employee where salary=(select max(salary) from employee)

--2. Display the employees who are working in the sales department.

select  * from employee where Department_ID=(select Department_ID from Department where name='sales')


--3. Display the employees who are working as 'Clerk'.

select  * from employee where job_ID=(select job_ID from job where Designation='clerk')


--4. Display the list of employees who are living in "New York".

select  * from employee 
         where Department_ID=(select Department_ID from Department
         where location_id=(select location_id from location where city='New York'))

--5. Find out the number of employees working in the sales department.

select  Department_ID,count(*) number_of_employees  from employee 
        where Department_ID=(select Department_ID from Department where name='sales')
		group by Department_ID

--6. Update the salaries of employees who are working as clerks on the basis of 10%.

begin transaction
update employee set salary=salary*1.10 where job_id=(select job_id from job where designation='clerk')
select * from Employee
order by salary

rollback


--7. Delete the employees who are working in the accounting department.

begin transaction
delete employee where Department_ID=(select Department_ID from Department where name='accounting')
select * from Employee

rollback


--8. Display the second highest salary drawing employee details. 

select * from employee where salary=(select max(salary) second_highest_salary from Employee
          where salary<(select max(Salary) from Employee))


--9. Display the nth highest salary drawing employee details.

with cte as(
select *,row_number()over( order by salary desc) as salary_rank from Employee
)
select * from cte where salary_rank=1


--10. List out the employees who earn more than every employee in department 30. 

select * from employee where Salary > (select max(salary) from employee where Department_ID=30 )



--11. List out the employees who earn more than the lowest salary in
--department.Find out whose department has no employees.

SELECT e.*
FROM employee e
JOIN (SELECT Department_ID, MIN(salary) AS min_salary
      FROM employee
      GROUP BY Department_ID) AS dept_min_salary 
	  ON e.Department_ID = dept_min_salary.Department_ID
WHERE e.salary > dept_min_salary.min_salary


select name from department 
          where department_id not in (select Department_ID from Employee)


--12. Find out which department has no employees. 

select name from department 
          where department_id not in (select Department_ID from Employee)


--13. Find out the employees who earn greater than the average salary for their department

select e.* from employee e
       join(select department_id,avg(salary) avgsalay from Employee
			group by department_id) as sub
			on e.Department_ID=sub.Department_ID
where e.salary>sub.avgsalay