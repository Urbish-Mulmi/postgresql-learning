Drop table if exists basics.products_basic;

create table basics.products_basic(
  id serial primary key,
  
  name varchar (100) not null,
  
  description text,
  
  stock integer default 0,
  
  -- store larger whole number
  total_views BIGINT Default 0,
  
  -- numeric means exact decimal value
  -- 10 means total digits
  -- 2 means, 2 digits after decimal
  -- eg. 99999999.34
  price Numeric (10,2),

  is_active BOOLEAN default true
);

insert into basics.products_basic(name, description, stock, total_views, price, is_active)
VALUES 
( 'product1', 'product1 descirption', 100, 1200,123.45 ,true),
( 'product2', 'product2 descirption', 10, 1200,123.4 ,true);

-- to view all records without filtering:
-- select * from basics.products_basic ;

-- apply filter to view only is_active records:
select id, name, price, is_active 
from basics.products_basic 
where is_active = true;