-- transaction:allows multiple sql statement run as one safe unit
-- simply, either all run and success or all cancels if failed
-- atomicity (ALL OR NONE APPROACH IMPLEMENTATION)

-- Example: placing an e-commerce order may involve:
-- checking product stock, reserving stock, creating an order,
-- and recording payment status.
-- Related database changes should be committed together when appropriate.
-- External payment processing requires separate failure-handling logic.

-- how we do this?
-- start of trasnaction is marked by BEGIN keyword
-- UNLESS COMMIT IS FOUND POSTGRES DONT SAVE CHANGES

--  SELECT title, status, views from posts where title = 'Indexes for begineers';
 SELECT title, status, views from posts;
 
BEGIN;


UPDATE posts
set status = 'published'
where title = 'Indexes for beginners'
 AND status = 'draft'
 returning status, title, views;

UPDATE posts
set views = views+50
where title = 'Indexes for beginners' 
 returning status, title, views;

 SELECT title, status, views from posts where title = 'Indexes for beginners';

COMMIT;
--  COMMIT IS FOUND POSTGRES THUS SAVE CHANGES