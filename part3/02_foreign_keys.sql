-- foreign key is a column that points to a primary key of another table

-- users.id - parent key
--  posts.user_id - foreign key
-- every post u will create must belong to an existing users

select 'users table' AS message;
select id, name
from users;

select 'posts table below references to users table for user_id' AS message;
select id, user_id, title
from posts;
