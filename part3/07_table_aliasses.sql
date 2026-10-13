-- make habit of using aliasses for ease of working
-- alias can be used for {column, tables} simply by 'AS alias name'
-- post.name ~ p.name

-- Task1. Return post title, post status, user name, comment body
select 
p.title, p.status, u.name, c.body
from posts AS p 
inner join users AS u 
on p.user_id = u.id 
inner join comments AS c
on p.id = c.post_id
order by p.views desc;

