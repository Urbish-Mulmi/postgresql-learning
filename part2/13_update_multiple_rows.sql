-- Update multiple records:

-- View existing records:
select name, category, price, is_active
from products
where category = 'productive comfort' ;

-- Task1. Update products price by 10% specifically for category 'productive comfort' :
Update products
set price = ROUND(PRICE*1.10,2)
where category = 'productive comfort';

select name, category, price, is_active
from products
where category = 'productive comfort' ;
