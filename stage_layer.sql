--Splitting dataset--

select * 
into stage.secondary_load
from stage.dataset
where order_date >= '01-01-2017'
order by order_date desc

select * 
into stage.initial_load
from stage.dataset
where order_date < '01-01-2017'
order by order_date desc

-- Row_id was removed from stage.initial_load --

-- New records --

insert into stage.secondary_load (
order_id,
order_date,
ship_date,
ship_mode,
customer_id,
customer_name,
segment,
country,
city,
state,
postal_code,
region,
product_id,
category,
sub_category,
product_name,
sales,
quantity,
discount,
profit)
values (
'CA-2017-119999',
'2017-12-31',
'2018-02-02',
'Standard class',
'AA-10480', 
'Andrew Allen',
'Consumer',
'United States',
'Concord',
'North Carolina',
'28027',
'South',
'FUR-CH-10002774',
'Furniture',
'Chairs',
'Global Deluxe Stacking Chair, Gray',
'71.372',
'2',
'0.3',
'-1.0196')

select * from stage.secondary_load
where order_id = 'CA-2017-119999'

-- SCD Type 1 --

select
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    case when customer_name = 'Erica Bern' then 'Eric Bern'
         else customer_name
    end as customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit
into stage.scd1
from stage.dataset
where customer_name = 'Erica Bern'

-- SCD Type 2 --

select order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
	CAST('Los Angeles' AS VARCHAR(50)) AS city,
	CAST('California' AS VARCHAR(50)) AS state,
	CAST('90032' AS INT4) AS postal_code,
	CAST('West' AS VARCHAR(50)) AS region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit
into stage.scd2
from stage.secondary_load
where customer_name = 'Chuck Clark'

-- Exact duplicates --

select * 
into stage.duplicates
from stage.initial_load
order by random()
limit 5

--Extended secondary load--

create table stage.secondary_load_extd as
	select * from stage.secondary_load
		union all
	select * from scd1
		union all
	select * from scd2
		union all
	select * from duplicates