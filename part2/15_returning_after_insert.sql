--  RETURNING clause  returns backs the rows immediately after insert, update, delete
-- syntax :
  -- DB query[insert, update, delete...]
  --  (at end ) RETURNING *   
  --         or
  --  (at end ) RETURNING colName1, colName2, colName3
-----------------------------------------------------------------------------------------------

-- Task 1. Insert record and use RETURNING clause to view name, category, price, stock, created_at:
  -- Insert into products(name, category, price, stock, sku, description)
  -- Values
  -- ('Webcamera', 'Electronics', 454.33, 56, 'elec-webcam', 'webcam camera support extensible sd card')
  -- RETURNING  name, category, price, stock, created_at;

-- Task2. Use RETURNING for delete action to view DB post delete action:
  delete from products
  where sku = 'elec-webcam'
  returning *; --returns all columns
  -- returning name, sku; -- returns specific columns as defined