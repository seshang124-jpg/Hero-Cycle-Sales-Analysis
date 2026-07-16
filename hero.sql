Create database hero;
-- 1.Create Tables Based on ERD
-- 2. Import CSVs into SQL
select  * from hero.brands;
select * from hero.categories;
select * from hero.customers;
select * from hero.order_items;
select * from hero.orders;
select * from hero.products;
select * from hero.staffs;
select * from hero.stocks;
select * from hero.stores;

-- 3. Inner Join for Order Details
select o.*,ot.*,p.* from  hero.orders as o
join hero.order_items as ot
on o.OrderId=ot.OrderId
join hero.products as p
on ot.ProductId=p.ProductId;


-- 4. Total Sales by Store
select o.StoreId,sum(ot.TotalSales) as Total_Sales from hero.order_items as ot
join hero.orders as o
on o.OrderId=ot.OrderId
group by o.StoreId;


-- 5. Top 5 Selling Products
select p.ProductId,p.ProductName,count(ot.Quantity) as total_products from hero.order_items as ot
join hero.products as p
on p.ProductId=ot.ProductId
group by p.ProductId,p.ProductName
order by total_products desc
limit 5;


-- 6. Customer Purchase Summary
select o.CustomerId,c.Name,count(ot.OrderId)as total_orders_placed,count(ot.ItemId) as total_items_purchased,sum(ot.TotalSales) as total_revenue from hero.order_items as ot
join hero.orders as o
on o.OrderId=ot.OrderId
join hero.customers as c
on c.CustomerId=o.CustomerId
group by o.CustomerId;


-- 7. Segment Customers by Total Spend
select  *,case
 when ot.TotalSales>4000 then "High"
when ot.TotalSales>=2000 then "Medium"
when  ot.TotalSales<2000 then "Low"
end as spending_brackets from hero.order_items as ot
left join hero.orders as o
on o.OrderId = ot.OrderId
left join hero.customers as c 
on o.CustomerId = c.CustomerId;



-- 8. Staff Performance Analysis
select o.StaffId,count(ot.OrderId) as total_orders,sum(ot.TotalSales) as total_revenue from hero.order_items as ot
join hero.orders as o
on o.OrderId=ot.OrderId
group by O.StaffId
order by total_revenue desc;


-- 9. Stock Alert Query
select p.ProductId,p.ProductName,sum(s.Quantity) as total_quantity from hero.stocks as s
join hero.products as p
on s.ProductId=p.ProductId
group by p.ProductId,p.ProductName
having total_quantity>10
order by total_quantity asc;


-- 10.Create Final Segmentation Table 
create table hero.customer_segments(Recency varchar(100),Frequency varchar(100),Monetay varchar(100));

select * from hero.customer_segments;