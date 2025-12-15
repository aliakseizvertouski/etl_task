--creating core layer

create table core.customers (
    customer_id varchar(50) primary key,
    customer_name varchar(255),
    segment varchar(50),
    country varchar(50),
    city varchar(50),
    state varchar(50),
    postal_code varchar(20),
    region varchar(50)
);

create table core.products (
    product_id varchar(50) primary key,
    product_name varchar(255),
    sub_category varchar(100),
    category varchar(100)
);

create table core.orders (
    order_id varchar(50) primary key,
    order_date date,
    ship_date date,
    ship_mode varchar(50),
    customer_id varchar(50),
    foreign key (customer_id) references customers(customer_id)
);

create table core.order_items (
    order_id varchar(50),
    product_id varchar(50),
    sales numeric(10,2),
    quantity int,
    discount numeric(10,2),
    profit numeric(10,2),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

