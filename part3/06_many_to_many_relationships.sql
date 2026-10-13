-- posts.id == post_tags.post_id
-- tags.id == post_tags.tags_id

-- task: find records of tags name belong to which posts title. inner joining 3 tables

select
 posts.title AS post_title,
tags.name AS tag_name
from posts   
inner join post_tags
on posts.id = post_tags.post_id
inner join tags
on post_tags.tag_id = tags.id
order by posts.title, tags.name;
