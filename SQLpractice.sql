-- Creating table
CREATE TABLE Employee (
EmpID int NOT NULL,
EmpName Varchar,
Gender Char,
Salary int,
City Char(20) );
INSERT INTO Employee
VALUES (1, 'Arjun', 'M', 75000, 'Pune'),
(2, 'Ekadanta', 'M', 125000, 'Bangalore'),
(3, 'Lalita', 'F', 150000 , 'Mathura'),
(4, 'Madhav', 'M', 250000 , 'Delhi'),
(5, 'Visakha', 'F', 120000 , 'Mathura')

	
CREATE TABLE EmployeeDetail (
EmpID int NOT NULL,
Project Varchar,
EmpPosition Char(20),
DOJ date );

INSERT INTO EmployeeDetail
VALUES (1, 'P1', 'Executive', '2019-01-26'),
       (2, 'P2', 'Executive', '2020-05-04'),
       (3, 'P1', 'Lead', '2021-10-21'),
       (4, 'P3', 'Manager', '2019-11-29'),
       (5, 'P2', 'Manager', '2020-08-01');


-- Find the list of employees whose salary range between 2L to 3L --
Select Empname, salary from employee
Where salary between 200000 and 300000;
-- OR
Select empname, salary from employee
where salary>200000 and salary<300000;


-- Write a query to retrieve the list of employees from the same city --
select * from employee
Select E1.empid, E1.empname, E1.city
From employee E1, employee E2
where E1.city = E2.city and E1.empid != E2.empid;


-- Query to find the null values in EMployee table --
Select * from employee
where empid is NULL;

-- Quer to find the cumulative sum of employee's salary --
Select empid, empname, salary, sum(salary) over (order by empid)
as cumulative_salary
from employee;

-- What's the male and female employees ratio --
select 
	count(*) filter (Where gender = 'M')*100.0/count(*) as male_ratio,
	count(*) filter (Where gender = 'F')*100.0/count(*) as female_ratio
From employee;

-- WRite a query to fetch 50% of records from the Employee table --
Select * from employee
where empid <= (select count(empid)/2 From employee);

-- OR 
Select * from
	(select *, row_number() over (order by empid) as RowNumber
	From employee) as emp
Where emp.RowNumber <= (select count(empid)/2 from employee);


-- Query to fetch the employee's salary but replace the last 2 digite with 'XX'

Select salary, 
concat(substring(salary::text,1,length(salary::text)-2),'XX') as masked_number
from employee;

-- OR
Select salary, concat(left(cast(salary as text),length(cast(salary as text))-2),
	'XX') as masked_number
from employee;


-- Write a query to fetch even and odd rows from employee table
-- For Even rowns using MOD
Select * from employee
where mod(empid,2)=0;

-- For Odd rowns using MOD
select * from employee
where mod(empid,2)=1;

-- Without using mod
Select * from 
	(select *, row_number()over(order by empid) as rowNumber
	from employee) as emp
where emp.rowNumber %2 = 0;

-- Without using mod
Select * from 
	(select *, row_number()over(order by empid) as rowNumber
	from employee) as emp
where emp.rowNumber %2 = 1;

-- Write a query to find  all the employee names whose name:

-- Begin with 'A'
select * from employee where empname like 'A%';

-- Contaions 'A' alphabet at 2nd place
Select * from employee where empname like '_A%';

-- Contains 'Y' alphabet at 2nd last place
Select * from employee where empname like '%Y_';

-- Ends with 'L' and contains 4 aphabet
Select * from employee where empname like '___l';

-- Begins with 'V' and ends with 'A'
Select * from employee where empname like 'V%a';


--n Write a query to find the list of Employee name is:
-- Starting with vovels (a,e,i,o,u), without duplicates
Select distinct empname
from employee
where Lower(empname) similar to '[aeiou]%';

-- Ending with vovels (a,e,i,o,u), without duplicates
Select distinct empname
from employee
where Lower(empname) similar to '%[aeiou]';

-- Starting and ending with vovels (a,e,i,o,u), without duplicates
Select distinct empname
from employee
where Lower(empname) similar to '[aeiou]%[aeiou]';


-- FInd the Nth highest salary from  employee table with and without using
-- Top/Limit keywords
Select E1.salary from employee E1
where 1 =(
	select count(distinct (E2.salary))
	From employee E2
	where E2.salary >E1.salary);


-- Write a query to find and remove duplicate records from a table
Select empid, count(*) as duplicate_count
from employee
group by empid having count(*) > 1;
