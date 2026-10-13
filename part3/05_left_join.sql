-- left join keeps all rows from the left table
-- if right side table has matching data, postgreSQL includes that
-- if, no matching data it returns null

-- posts-> left table
-- comments-> right table
-- because not every post is going to have comments
-- some posts will have 100 comments, some will have 0 comments
select 
posts.title AS post_title,
comments.body AS comment_body

from posts
left join comments
on posts.id = comments.post_id
ORDER BY posts.title;