-- inserting a single record:
-- insert into products
-- (name,category,price,stock,is_active,sku,description)
-- values
-- ('Laptop', 'gaming', 199999, 2, false,'AG','High performance, tactial keyboard equipped with Nvidia rtx 50 series gpu' );


-- querying to fetch a single record:
select name,category,price,stock,is_active,sku,description from products
-- where sku = 'AG'
where sku in ('AG');

