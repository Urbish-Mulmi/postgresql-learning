--personal notes:
  -- postgreSQL uses not null ~equivalent~ required in mongoDB
  -- order by criterions are separated by comma
      -- ORDER BY name ASC, id ASC
----------------------------------------------------------------------              
-- TASK are setups
-- Create schema, table, and sample data

-- CHALLENGES are Practice SQL queries using the sample data
-------------------------------------------------------------------------
-- TASK 1
    -- Create schema if not exists assessment;

-- TASK 2
-- Drop table if exists assessment.products;
-- Create table  assessment.products
-- (
--   id serial primary key,
--   name text not null,
--   category text,
--   price numeric(10,2) not null  check (price >= 0),
--   stock integer  check (stock >= 0) ,
--   sku  text not null  unique,
--   description text ,
--   is_active boolean default true
-- );


-- TASK 3
    -- Insert into assessment.products
    --   (name,category,price,stock,sku,
    --   description,is_active)
    -- Values
    --     ('ASUS Vivobook', 'Electronics', 85000, 5, 'ASM-001', 'Laptop', TRUE),
    --     ('Gaming Mouse', 'Gaming', 2500, 12, 'ASM-002', 'Wireless mouse', TRUE),
    --     ('Office Monitor', 'Electronics', 22000, 0, 'ASM-003', '27-inch monitor', TRUE),
    --     ('Gaming Keyboard', 'Gaming', 4500, 8, 'ASM-004', 'Mechanical keyboard', TRUE),
    --     ('USB Cable', 'Electronics', 500, 30, 'ASM-005', NULL, TRUE),
    --     ('Desk Lamp', 'Furniture', 1500, 0, 'ASM-006', '', TRUE),
    --     ('Laptop Stand', 'Furniture', 1800, 10, 'ASM-007', 'Aluminium stand', FALSE),
    --     ('Wireless Headphones', 'Electronics', 5000, 6, 'ASM-008', 'Noise cancelling', TRUE),
    --     ('Gaming Chair', 'Gaming', 25000, 3, 'ASM-009', NULL, FALSE),
    --     ('Notebook', 'Stationery', 200, 50, 'ASM-010', 'Paper notebook', TRUE),
    --     ('Laptop Sleeve', 'Accessories', 1200, 15, 'ASM-011', 'Protective sleeve', TRUE),
    --     ('USB Hub', 'Electronics', 1800, 7, 'ASM-012', 'Multi-port USB hub', TRUE),
    --     ('asus Zenbook', 'Electronics', 95000, 4, 'ASM-013', '', TRUE),
    --     ('ASUS ROG Mouse', 'Gaming', 2500, 0, 'ASM-014', NULL, TRUE),
    --     ('Office Desk', 'Furniture', 30000, 2, 'ASM-015', 'Wooden desk', FALSE)
    --     -- RETURNING *;

-- 6 SQL PRACTICE CHALLENGES

-- Challenge 1 — Combine filtering conditions
-- Return name, category, price, stock Sort by price from highest to lowest.find products that:
  --1a. Are active:
    -- select name, category, price, stock, is_active as active_status
    -- from assessment.products
    -- where is_active = true
    -- order by price desc;


  --1b. Belong to either Electronics or Gaming.
    -- Select name, category, price, stock, is_active as active_status
    -- from assessment.products
    -- where category in( 'Electronics' ,'gaming')
    -- order by price desc;

  --1c. Cost between 500 and 25,000, inclusive.
    -- select name, price as cost, category
    -- from assessment.products
    -- where price between 500 and 25000
    -- order by price desc;

  --1d. Have stock greater than zero.
    -- select name, price, stock
    -- from assessment.products
    -- where stock >0
    -- order by stock desc;

-- Challenge 2 — Search products

-- Build a product-search query that:

-- Finds names containing asus, regardless of capitalization.
    -- select name from assessment.products where name ilike '%asus%';

-- Includes active products with available stock only.
    -- select name, stock, is_active from assessment.products 
    -- where (stock>0)
    -- AND is_active = true;

-- Sorts by price ascending, then name alphabetically.
    -- select * from assessment.products
    -- order by price asc, 
    --         name asc;

-- Returns at most 10 records.
    -- select * from assessment.products
    -- order by price asc, 
    --         name asc
    -- limit 10;


-- Then modify the search so that names must start with asus rather than contain it anywhere.
    -- select name from assessment.products 
    -- where name ilike 'asus%';


-- Challenge 3 — Handle missing descriptions

-- Write separate queries to find:
-- Products whose descriptions are NULL.
    -- select name, description as null_desc from assessment.products
    -- where description IS NULL ;
-- Products whose descriptions are empty strings.
    -- select name, description as empty_desc from assessment.products
    -- where description = '';
-- Products whose descriptions are neither NULL nor empty.
    -- select name, description as neither_null_nor_empty_desc from assessment.products
    -- where description is not null AND description <> '';
-- Return each product's name and SKU.
    -- select  name, sku from assessment.products;

-- Challenge 4 — Implement pagination
-- An API displays five products per page, sorted alphabetically by name.
    -- select name, price from assessment.products order by name limit 5;
-- Retrieve page 1., offset = (page-1)* limit => (pg-1)*5;
    -- select name, price from assessment.products order by name limit 5 offset 0;
-- Retrieve page 2.
    -- select name, price from assessment.products order by name limit 5 offset 5;
-- Retrieve page 3.
    -- select name, price from assessment.products order by name limit 5 offset 10;

-- Improve the sorting order to handle duplicate product names consistently. what it mean/how to do such duplicate handling??
---
-- Challenge 5 — Update prices safely
-- view products for electronics category
    -- select name, price from assessment.products where category ilike 'Electronics';
-- The business increases the price of every Electronics product by 10%. Update the qualifying prices.
    -- update assessment.products
    -- set price = round(price*1.1)
    -- returning name, price;
-- Return the updated product names, SKUs, and prices.
    -- select name, price as updated_price, sku from assessment.products where category ilike 'Electronics';

-- Challenge 6 — Delete a specific product

-- view all product names alphabetical order:
    -- select name from assessment.products order by name asc;

-- An administrator needs to remove one test product, return name, sku of deleted item.
    -- delete from assessment.products where name = 'Desk Lamp'
    -- returning name as Deleted_product;

-- Challenge 7 — Build a complete query

-- An e-commerce API needs to recommend the three cheapest products that customers can purchase immediately.

-- Requirements:

-- Active products only. Stock greater than zero.Exclude Stationery. Return name, category, price, and stock.
-- Sort by price ascending, then name alphabetically.
-- Return the first three qualifying products, or fewer if fewer than three qualify.
    -- select name, category, price, stock from assessment.products 
    -- where is_active = TRUE
    -- AND stock > 0
    -- AND CATEGORY <> 'STATIONERY'
    -- order by price asc, name asc    
    -- limit 3;         

-- END