-- uniquely identify each row in table
-- if no primary key then:
-- hard to update, delete, do any reference, connect two rows from tables, 
-- there has to be somehting unique in each rows to identify particular row which primary key does

Drop table if exists basics.sales;

create table basics.sales 
(
  id serial primary key,
  title text not null,
  price numeric(10,2) not null default 0,

  created_at timestamp default now()
);

-- valid inserts:
-- insert into basics.sales(title, price)
-- VALUES
-- ('sale1', 2000),
-- ('sale2', 500);

--also valid inserts:
-- insert into basics.sales(title, price, id)
-- VALUES
-- ('sale1', 2000,4),
-- ('sale2', 500,99);


-- violate primary key explicitly:
-- 'id serial primary key;' here serial means implicitly integer only
-- insert into basics.sales(title, price, id)
-- VALUES
-- ('sale1', 2000,4),
-- ('sale2', 500,2w);

select * from basics.sales;