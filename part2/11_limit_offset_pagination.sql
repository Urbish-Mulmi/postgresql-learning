--  limit  -> how many rows u wanna return
--  offset -> how many rows u wanna skip

-- 11.A) LIMIT based stuffs:
-- Task 1: 5 cheapest products
  -- SELECT name, price
  -- FROM products
  -- ORDER BY price ASC
  -- LIMIT 5;

-- Task 2: First 5 products alphabetically
  -- SELECT name, price
  -- FROM products
  -- ORDER BY name ASC
  -- LIMIT 5;

-- 11.B) LIMIT and OFFSET (Pagination)
-- OFFSET -> Number of rows skipped
-- LIMIT -> Number of rows returned per page
-- OFFSET = (page - 1) * limit

-- Examples: LIMIT 5
-- (LIMIT, OFFSET) -> Rows returned
-- (5, 0) -> 1-5
-- (5, 1) -> 2-6
-- (5, 2) -> 3-7

-- Offset formula examples:
-- Page 2: (2 - 1) * 5 = 5
-- Page 3: (3 - 1) * 5 = 10
-- Page 4: (4 - 1) * 5 = 15


-- Page 1
SELECT name, price
FROM products
ORDER BY name ASC
LIMIT 5 OFFSET 0;

-- Page 2
SELECT name, price
FROM products
ORDER BY name ASC
LIMIT 5 OFFSET 5;

-- Page 3
SELECT name, price
FROM products
ORDER BY name ASC
LIMIT 5 OFFSET 10;

