-- filters:
-- {and, or, not}

-- Task1: products where it is electronics but price > 1000
  -- select name, category
  -- from products
  -- where category = 'Electronics'
  -- And price > 1000;

-- Task2: products where category Electronics or productive comfort
-- select name, category from products
-- where category = 'Electronics' or category ='productive comfort';

-- Task3: products which are not stationary
  -- select name, category from products
  -- where NOT category = 'stationary';

--  Task4: products where category is Electronics or gaming and stock > 0
select name, category, stock
from products
where
(category ='Electronics' or category =  'gaming')
AND stock > 0;

