--creating mart layer

-- fact table

create table mart.orders AS
select 
	order_id,
	order_date,
	customer_id,
	product_id,
	ship_mode,
	ship_date
from core.orders
join core.customers using (customer_id)
join core.order_items using (order_id)


--dim tables

create table mart.dim_dates AS
select
    core.orders.order_date AS full_date,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(QUARTER FROM order_date) AS quarter
FROM core.orders

create table mart.dim_products AS
select 
	product_id,
	category,
	sub_category,
	product_name
from core.products

create table mart.dim_customers AS
select 
	customer_id,
	customer_name,
	segment,
	country,
	city,
	state,
	postal_code,
	region
from core.customers

create table mart.dim_items AS
select 
	order_id,
	sales,
	quantity,
	discount,
	profit
from core.order_items