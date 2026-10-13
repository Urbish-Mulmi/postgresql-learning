-- inner join?
-- inner join returns only the matching rows from both tables
-- there has to be some matching condition common in table undergoing inner join

SELECT 
users.name AS author_name,
posts.title AS post_title,
posts.views
From posts
INNER JOIN users
  ON posts.user_id = users.id 
where posts.status = 'published'
order by posts.views DESC;

