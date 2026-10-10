-- Notes
--  like - case sensitive pattern match
--  ilike - case insensitive pattern match
--  % means any numbers of characters
--  _ means exactly one character only
--  Pattern matchings via : LIKE, ILIKE, %, _ 
--  % and _ are pattern-matching wildcards used strictly with LIKE or ILIKE
--  %, _ can not be used with =
------------------------------------------------------------------------------------------------

-- Task1: to view all products:
  -- select name, price from products ;

-- Task2: fetch prodcuts whose name starts from Stand with case sensitivity respected (use like and %)
  -- select name, price
  -- from products
  -- where name like 'Stand%';

--Task3: fetch products with no case sensitivity (use ilike)
  -- select name from products
  -- where name ilike 'asus%'

-- Task4: Use `_` with ILIKE/LIKE to find products whose name
  -- Select name, price from products
  -- where name LIKE '___top';



