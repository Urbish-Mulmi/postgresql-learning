-- IN means value must match with one item from list
-- NOT IN means value must not match with any item from list
-- BETWEEN means value must be inside a range such that the range value is also inclusive

--  Task1: find products whose category is electronics or gaming
  -- select name, category, price 
  -- from products
  -- where category in ('Electronics', 'gaming' );

--  Task2: find products whose category can be anything but not gaming
  -- select name, category, price 
  -- from products
  -- where category NOT in ('gaming' );

--  Task3: find products whose price is between range of 100 and 20000
  -- select name, category, price As filtered_price
  -- from products
  -- where price BETWEEN 100 ANd 20000;




