-- inserting multiple records:
insert into products
(name,category,price,stock,is_active,sku,description)

values
('Standing desk A', 'productive comfort', 32000, 6, true,'Desk A','High comfort, cushioned back equipped with motorized extending legs' ),
('Standing desk B', 'productive comfort', 32000, 6, true,'Desk B','High comfort, cushioned back equipped with motorized extending legs' ),
('Standing desk C', 'productive comfort', 32000, 6, true,'Desk C','High comfort, cushioned back equipped with motorized extending legs' );

-- querying to get multiple records using in constraint:
select name,category,price,stock,sku
from products
where sku in ('Desk A','Desk B','Desk C');

