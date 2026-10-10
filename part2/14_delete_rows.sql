-- Deleting record:
 -- synatax:
  -- Delete from tableName
  -- where constraint (unique enough to identify specific record);
-- ----------------------------------------------------------------------------------------

-- Pre requisite task: Inssert a record intended to delete:
    -- Insert into products
    -- (name, category, price, stock,sku, description)
    -- Values
    -- ('productdelete', 'electronics', 122.2,33, 'delete-122', 'delete this gang');

-- Verify record is added:
  Select name, category, sku
  from products
  where sku ='delete-122';

-- Task1. Delete sku named: 'delete-122':
  Delete from products
  where sku = 'delete-122';

-- Verify delete is success:
Select name, category, sku
from products
where sku ='delete-122';

-- DELETE FROM products; 
  --This Deletes every row so it is important to run a precheck and be sure of where contraint to target a specific record