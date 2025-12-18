
create temp table temp_load as (
select * from stage.initial_load)

-- loading without duplicates

create temp table without_duplicates as (
select s.*
   from stage.secondary_load_extd s
    left join stage.initial_load i
      on s.order_id = i.order_id
     and s.order_date = i.order_date
     and s.ship_date = i.ship_date
     and s.ship_mode = i.ship_mode
     and s.customer_id = i.customer_id
     and s.customer_name = i.customer_name
     and s.segment = i.segment
     and s.country = i.country
     and s.city = i.city
     and s.state = i.state
     and s.postal_code = i.postal_code
     and s.region = i.region
     and s.product_id = i.product_id
     and s.category = i.category
     and s.sub_category = i.sub_category
     and s.product_name = i.product_name
     and s.sales = i.sales
     and s.quantity = i.quantity
     and s.discount = i.discount
     and s.profit = i.profit
     and i.is_current = 'y'
where i.order_id is null)


-- adding new records

insert into temp_load (
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
	profit,
	valid_from,
	valid_to,
	is_current)
select
	s.order_id,
	s.order_date,
	s.ship_date,
	s.ship_mode,
	s.customer_id,
	s.customer_name,
	s.segment,
	s.country,
	s.city,
	s.state,
	s.postal_code,
	s.region,
	s.product_id,
	s.category,
	s.sub_category,
	s.product_name,
	s.sales,
	s.quantity,
	s.discount,
	s.profit,
	current_date,
	date '9999-12-31',
	'y'
from without_duplicates s
left join temp_load i
	on s.order_id = i.order_id
	and s.product_id = i.product_id
where i.order_id is null;
    

-- scd 1 updating 


update temp_load i
set customer_name = s.customer_name
from without_duplicates s
where i.order_id = s.order_id
  and i.product_id = s.product_id
  and i.is_current = 'y'
  and i.customer_name <> s.customer_name;
    










