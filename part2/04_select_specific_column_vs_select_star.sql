-- Notes:
--  select * from tableName- returns every columns
--  select a,b,c  tableName - returns a,b,c columns
--  As creates an Alias to reference to a specific columns for ease
--  Alias  makes cols name easier to read, work with
---------------------------------------------------------------------
-- select star in action:
  -- select * from products;

-- select specific full column name in action:
  -- select name, category, price, stock from products;

--use of Alias to select specific columns:
  select 
    name as Product_Name,
    price as Mrp,
    stock as Units_Avaliable
  from products;  

