--loading data

--mart.orders
insert into mart.orders (
	order_id,
	order_date,
	customer_id,
	product_id,
	ship_mode,
	ship_date)
select
	order_id,
	order_date,
	customer_id,
	product_id,
	ship_mode,
	ship_date
from core.orders
join core.order_items using (order_id)

--mart.dim_dates
insert into mart.dim_dates (full_date, year, month, quarter)
select
    order_date AS full_date,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(QUARTER FROM order_date) AS quarter
from (
    select distinct order_date
    from core.orders
)

-- mart.dim_products
insert into mart.dim_products (
	product_id,
	category,
	sub_category,
	product_name)
select
	product_id,
	category,
	sub_category,
	product_name
from core.products

--mart.dim_customers
insert into mart.dim_customers (
	customer_id,
	customer_name,
	segment,
	country,
	city,
	state,
	postal_code,
	region)
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

--mart.dim_items
insert into mart.dim_items (
	order_id,
	sales,
	quantity,
	discount,
	profit)
select
	order_id,
	sales,
	quantity,
	discount,
	profit
from core.order_items