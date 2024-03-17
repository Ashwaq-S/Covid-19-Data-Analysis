use assignments_1_6

--Tasks To Be Performed:

--1. Arrange the ‘Orders’ dataset in decreasing order of amount

select * from orders order by amount desc

--2. Create a table with the name ‘Employee_details1’ consisting of these
----columns: ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. Create another table with
----the name ‘Employee_details2’ consisting of the same columns as the first table.

create table employee_details1( Emp_id int, Emp_name varchar(100), Emp_salary money)

create table employee_details2( Emp_id int, Emp_name varchar(100), Emp_salary money)

insert into employee_details1 values (1, 'John Doe', 50000),
									(2, 'Jane Smith', 60000),
									(3, 'Alice Johnson', 70000),
									(4, 'Michael Scott', 75000)

insert into employee_details2 values(1, 'John Doe', 50000),
									(2, 'Jane Smith', 60000),
									(3, 'Michael Scott', 75000),
									(4, 'Dwight Schrute', 70000)
									


--3. Apply the UNION operator on these two tables

select * from employee_details1
union
select * from employee_details2

--4. Apply the INTERSECT operator on these two tables

select * from employee_details1
intersect
select * from employee_details2



--5. Apply the EXCEPT operator on these two table

select * from employee_details1
except
select * from employee_details2