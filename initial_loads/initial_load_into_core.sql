-- loading data from stage layer

-- core.customers
insert into core.customers (
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region
)
select
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region
from stage.initial_load
ON CONFLICT (customer_id) DO NOTHING;

--core.products
insert into core.products (
    product_id,
    product_name,
    sub_category,
    category
)
select
    product_id,
    product_name,
    sub_category,
    category
from stage.initial_load
ON CONFLICT (product_id) DO NOTHING;

--core.orders
insert into core.orders (
	order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id)
select
	order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id
from stage.initial_load

--core.order_items
insert into core.order_items (
	order_id,
    product_id,
    sales,
    quantity,
    discount,
    profit)
select
	order_id,
    product_id,
    sales,
    quantity,
    discount,
    profit
from stage.initial_load


--test
with test as (
	select distinct customer_id from stage.initial_load
	order by customer_id)
select count(customer_id) from test

select count(customer_id) from core.customers
