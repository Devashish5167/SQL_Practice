Create database practice;
use practice;
create table products(
	order_date date,
	sales int);
insert into products(order_date , sales)
values
('2021-01-01',20), ('2021-01-02',32), ('2021-01-08',45), ('2021-02-04',31),
('2021-03-21',33), ('2021-03-06',19), ('2021-04-07',21), ('2021-04-022',10);
select * from products;

-- Find monthly sales and sort it by descending order --
select year(order_date) as years, monthname(order_date) as months, sum(sales) as TotalSales
from products
group by year(order_date), monthname(order_date)
order by TotalSales desc;
-- OR --
select year(order_date) as years, monthname(order_date) as months, sum(sales) as TotalSales
from products
group by years, months
order by TotalSales desc;


-- Find the candidates best suited for an open Data Science job. Find candidates who are proficient in python, SQL and Power BI --

Create table applications(candidate_id int, skills varchar(20));
insert into applications(candidate_id , skills)
values
(101, 'Power BI'),(101, 'Python'),(101, 'SQL'),(102, 'Tableau'),(102, 'SQL'),
(108, 'Python'),(108, 'SQL'),(108, 'Power BI'),(104, 'Python'),(104, 'Excel');

select * from applications;

select candidate_id, count(skills) as SkillCount
from application
where skills in ('Python', 'SQL', 'Power BI')
Group by candidate_id
having count(skills)=3
order by candidate_id;