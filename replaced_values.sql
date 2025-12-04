select * from dataset d 

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

