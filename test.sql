select * from public.dataset


with replaced_dataset as (select *, 
REPLACE(orderdate, '/', '-') AS replaced_orderdate FROM dataset)
	select * from replaced_dataset
	where replaced_orderdate > '01-01-2015'
	order by replaced_orderdate desc


select * from dataset
where orderdate < '30/01/2016'


select * from dataset


WHERE replaced_orderdate (orderdate, '%d/%m/%Y') < 01/01/2017


-------------------------------------------

select * from dataset d 
where new_orderdate < '01-01-2017'
order by d.new_orderdate desc


alter table public.customers SET SCHEMA core;
alter table public.products SET SCHEMA core;
alter table public.orders SET SCHEMA core;
alter table public.order_items SET SCHEMA core;



select * from duplicates