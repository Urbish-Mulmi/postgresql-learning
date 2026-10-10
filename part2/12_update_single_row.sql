-- Notes: Update Existing record 
-- syntax:
  -- Update tableName
  -- set columnName1 = newValue,
  --     columnName2 = newValue    
  -- where constraint (unique enough to target particular record);
------------------------------------------------------------------------------------
-- Pre-Requisite task. See an existing record
select name, price, stock, sku
from products;

-- Task1. Query to update the particular record:
UPDATE PRODUCTS
SET PRICE = 900,
    STOCK =60
WHERE SKU = 'Desk B'  ;

