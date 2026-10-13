--  one parent row can have many child rows
-- eg. one user can have many post(rahul can have n posts)
-- but one post will always belongs to only use user

-- user - parent table
-- posts - child table
-- one to many user

-- users.id is original user id
-- posts.user_id stored the original user id inside posts table

-- task show all posts with their authors using inner join and foreign key concept
SELECT 
 users.name AS author_name,
 posts.title AS post_title, 
 posts.status
FROM users 
INNER JOIN posts
 on users.id = posts.user_id
order by users.name, posts.title; 

