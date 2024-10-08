-- Write a SQL query to count number of rows where the sales iis greater than 70 and order no is less than 500
select count(*) as row_count 
from StoreDetails
where sales_amount>70 and order_no < 500;

-- Write a query to find the Store_name that begins with 'T'
Select * from StoreDetails
where store_name like 'T%';

-- Write a query to retrieve the store_location and city column as a single column --
select store_location, city,
concat(store_location, city) as Addredd
from StoreDetails;


-- Write a query to extract first six characters from a city column name --
select substring(city,1,6)
as Extractstring from StoreDetails;

-- Create a stored procedure to estimate the 10% increase in sales --

DELIMITER $$

CREATE PROCEDURE Prosales()
BEGIN
    SELECT 
        store_name, 
        sales, 
        sales * 1.10 AS estimate_increase
    FROM 
        StoreDetails;
END $$

DELIMITER ;

-- To excure --
execute prosales;

-- Display the order_no in decreasing order --
Select Store_name, order_no
from StoreDetails
order by order_no desc;

-- Display the last record from the StoreDetails table --
Select * from StoreDetails where store = (Select max(store) from storedetails);

-- Combine the table with the following attributes ptoduct_id, product_type,
-- Product, sales, Prodit, State , Area_code.
Select p.product_Id, p.product_type, f.sales, f.profit, l.state,
l.area_code 
	from facttable as f
	inner join location as l
	on f.area_code=l.area_code
	inner join product as p
	on f.product_Id = p.product_id;
    
-- How much spending has been done on marketing for productId 1 --
Select sum(marketing) 
as Marketing
from facttable
where productId = 1;

-- Change the product_type from tea to coffee where product id is 13 --
Update product 
set product_type = 'Coffee'
where product_id = 13;

-- Display the rank without any gap to show the sales wise rank --
Select productId, sales, 
dense_rank() over (order by sales desc) 
as Sales_rank 
from facttable;

-- How many products are of regular type --
Select count(product) as regular_product_count 
from product 
where type = 'Regular';

-- FInd out the total profit generated by Colorado state --
SELECT 
    SUM(f.profit) AS total_profit
FROM 
    facttable AS f
INNER JOIN 
    location AS l ON f.area_code = l.area_code
WHERE 
    l.state = 'Colorado';

-- Display the average intventory for each product id --
select productId, avg(inventory) 
as average_inventory
from facttable
group by productId
order by productId; 

-- Write a query by creating a condition in which if the total expenses is less than 60 then it is profit else loss --
SELECT total_expenses,
       IF(total_expenses < 60, 'profit', 'Loss') AS status
FROM facttable;

-- Write the minimum sales of a product --
select min(sales) as min_sales from facttable;

-- Display max cost of goods sold --
select max(cogs) as max_cogs from facttable;

-- Display the average budget margin of the store where average budget margin should be greater than 100 --
select productID, avg(budget_margin)
as avg_budget_margin
from facttable
group by productId
having avg(budget_margin) > 100;

-- Display th Date, ProductId  and sales where total expenses are between 100 to 200 --
select date, productId, sales, total_expensses
from facttable
where total_expenses between 100 and 200;

-- Delete the records from StoreDetails where sales is less than 100 --
delete from StoreDetails where sales < 100;

-- Drop the existing data from storedetails --
Truncate table storeDetails;
