-- Note:
-- 5 related things: empty, null, undefine, unknown,zero
-- NULL means contains nothing, value missing
-- We can check in record if theres null using:
                                             --  IS Null
                                              --  IS NOT Null
----------------------------------------------------------------------------------------
-- Task 1. view prodcuts where description is null, then for not null case:
select * from products where description IS Null;                            
select * from products where description IS Not Null;    

