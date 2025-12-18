ALTER TABLE stage.dataset RENAME COLUMN "Row ID" TO row_id;

ALTER TABLE stage.dataset RENAME COLUMN "order ID" TO order_id;

ALTER TABLE stage.dataset RENAME COLUMN "Order Date" TO order_date;

ALTER TABLE stage.dataset RENAME COLUMN "Ship Date" TO ship_date;

ALTER TABLE stage.dataset RENAME COLUMN "Ship Mode" TO ship_mode;

ALTER TABLE stage.dataset RENAME COLUMN "Customer ID" TO customer_id;

ALTER TABLE stage.dataset RENAME COLUMN "Customer Name" TO customer_name;

ALTER TABLE stage.dataset RENAME COLUMN "Postal Code" TO postal_code;

ALTER TABLE stage.dataset RENAME COLUMN "Product ID" TO product_id;

ALTER TABLE stage.dataset RENAME COLUMN "Sub-Category" TO sub_category;

ALTER TABLE stage.dataset RENAME COLUMN "Product Name" TO product_name;

ALTER TABLE stage.initial_load
ADD COLUMN valid_from DATE,
ADD COLUMN valid_to DATE,
ADD COLUMN is_current CHAR(1);

UPDATE stage.initial_load
SET valid_from = order_date,
    valid_to   = DATE '9999-12-31',
    is_current = 'Y'
WHERE valid_from IS null;

select * from stage.initial_load
order by order_id