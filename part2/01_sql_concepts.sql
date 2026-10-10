-- Here we create a table without mentioning user defined schema
-- this products table is thus made inside public(default) schema in postgres

Create extension if not exists pgcrypto;

drop table if exists products;

create table products(
  id UUID primary key default gen_random_uuid(),
  name text not null,
  category text not null,
  price numeric (10,2) not null check (price>=0),
  stock integer not null default 0 check (stock>=0),
  is_active boolean not null default true,
  sku text unique,
  description text,
  created_at timestamp default now()
);


Insert into products (name, category,price, stock, is_active, sku, description)
values 
  ('Mechanical Keyboard', 'Electronics', 4500.00, 25, TRUE, 'ELEC-001', 'Mechanical keyboard with blue switches'),
  ('Wireless Mouse', 'Electronics', 1800.00, 40, TRUE, 'ELEC-002', 'Wireless mouse with adjustable DPI'),
  ('Office Chair', 'Furniture', 8500.00, 10, TRUE, 'FURN-001', 'Ergonomic office chair with adjustable height'),
  ('USB-C Hub', 'Accessories', 2500.00, 0, FALSE, 'ACC-001', 'USB-C hub with HDMI and USB ports');

select * from products;

