-- group by:
-- where clause -> filters normal rows before grouping
-- group by creates groups of rows
-- having filters can further filter with aggregate functions after grouping has been done



-- find authors who have written atleast 2 posts
-- Algorithm:
-- so final result is displayed with author name and posts count
-- this means use of group by users name
-- atleast 2 posts written means count records i.e use of aggregates
-- this means where clause is not needed
  -- core algo:
    -- combine posts, users table by joins
    -- group by users name
    -- use having and aggregate to filter such that posts count is > 2

select 
 u.name AS author_name, 
 count(p.id) AS total_posts_count,
 sum(p.views) AS total_views
 from users AS u
 left join posts as p
 on u.id = p.user_id
 group by u.id, u.name
--  having filter and aggregate usage after grouped by groups records based on users(here i.e its grouped between anayna and rahul)
 having count(p.id) >= 2
 order by total_posts_count desc;
