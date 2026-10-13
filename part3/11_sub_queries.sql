-- Sub queries: means one query inside another query
-- postgres runs inner query first then outer query runs
-- using of SELECT in inner query returns value to outer query
-- Task1: Find which posts are performing better than average
  -- inner query calculates some average value
  -- then based on returned value of inner query, outer query can reuse the value and do comparision to pin point posts that has view higher than average

select title, status, views 
from posts 
where views>(
  select AVG(views) from posts
)
order by views desc;