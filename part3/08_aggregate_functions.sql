-- Aggregate function always calculates one result from many grouped rows
--  it can not be used with WHERE clause, it can be used with having filter.
-- COUNT()->RETURNS NUMBER OF ROWS
-- SUM()->RETURNS TOTAL VALUE
-- AVG()->RETURNS AVERAGE VALUE
-- MIN()->RETURNS MIN VALUE
-- MAX()->RETURNS MAX VALUE

--  aggreagte function further  FILTERs (rows obtained after WHERE condition)
-- commonly used in ADMIN dashboard, reports, analytics, admin panel

-- Task 1 : count total records, status published  count and draft post count
SELECT 
  count(*) AS total_posts,
  count(*) FILTER( where status ='published') AS published_posts,
  count(*) FILTER( where status ='draft') AS draft_posts
from posts;

-- Task 2: Find  sum of views
SELECT 
  count(*) AS total_posts,
  SUM(views) filter (where status = 'published') AS total_view_count,
  AVG(views) AS average_views,
  MIN (views) AS lowest_views,
  MAX (views) AS highest_views
from posts;


