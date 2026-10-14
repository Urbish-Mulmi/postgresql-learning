```sql
-- ```PostgreSQL Part 3 — Assignments
-- Assignment 1 — Relationships and JOINs
-- a)Create a blog database
-- b) then create these tables:
-- - authors — id, name, email
-- - posts — id, title, content, author_id, published
-- - tags — id, name
-- - post_tags — post_id, tag_id
-- Tasks:
-- 1. Create all four tables with appropriate primary keys, foreign keys, and constraints.
-- 2. Insert at least 3 authors, 8 posts, and 4 tags.
-- 3. Assign multiple posts to each author and multiple tags to some posts.
-- 4. Display each post with its author's name.
-- 5. Display every author, including those with zero posts.
-- 6. Display each post with its associated tags.

--a)database creation
--  create database blog_database;

-- -- b)create tables inside created database:

DROP TABLE IF EXISTS post_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS authors;

CREATE TABLE IF NOT EXISTS authors (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    author_id INTEGER REFERENCES authors(id),
    published BOOLEAN
);

CREATE TABLE IF NOT EXISTS tags (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS post_tags (
    post_id INTEGER REFERENCES posts(id),
    tag_id INTEGER REFERENCES tags(id),
    PRIMARY KEY (post_id, tag_id)
);

--   3 authors, 8 posts, and 4 tags.-- Insert authors
INSERT INTO authors (name, email)
VALUES
    ('Ram', 'ram@example.com'),
    ('Sita', 'sita@example.com'),
    ('Hari', 'hari@example.com');

-- Insert posts
INSERT INTO posts (title, content, author_id, published)
VALUES
    ('PostgreSQL Basics', 'Introduction to PostgreSQL', 1, TRUE),
    ('Understanding JOINs', 'How SQL joins work', 2, TRUE),
    ('Database Design', 'Designing relational databases', 3, TRUE),
    ('Learning Indexes', 'How database indexes work', 1, FALSE),
    ('SQL Constraints', 'Using database constraints', 2, TRUE),
    ('Transaction Basics', 'Understanding transactions', 3, FALSE),
    ('Subquery Examples', 'Working with subqueries', 1, TRUE),
    ('Query Optimization', 'Improving query performance', 2, FALSE);

-- Insert tags
INSERT INTO tags (name)
VALUES
    ('database'),
    ('tutorial'),
    ('performance'),
    ('beginner');

-- Assign tags to posts
INSERT INTO post_tags (post_id, tag_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 4),
    (2, 1),
    (2, 2),
    (3, 1),
    (3, 4),
    (4, 3),
    (4, 2),
    (5, 1),
    (5, 4),
    (6, 1),
    (7, 2),
    (7, 4),
    (8, 3),
    (8, 1);

-- Add an author with no posts to test LEFT JOIN
INSERT INTO authors (name, email)
VALUES
    ('Mina', 'mina@example.com');

-- 4. Display each post with its author's name.
SELECT p.title, p.published, a.name
FROM posts AS p
INNER JOIN authors AS a
    ON p.author_id = a.id;

-- 5. Display every author, including those with zero posts.
SELECT *
FROM authors
LEFT JOIN posts
    ON authors.id = posts.author_id;

-- 6. Display each post with its associated tags.
SELECT p.title, p.content, t.name AS posts_tags
FROM posts AS p
INNER JOIN post_tags
    ON p.id = post_tags.post_id
INNER JOIN tags AS t
    ON post_tags.tag_id = t.id;


-- remaining tasks assignment given by gpt
-- Assignment 2 — Aggregate Functions and Filtering

-- Goal: Practise COUNT, GROUP BY, HAVING, FILTER, and DISTINCT.

-- Use the existing blog tables and data.

-- Task 1: Count the total number of authors, posts, and tags.
SELECT COUNT(a.id) AS author_count
FROM authors AS a;

SELECT COUNT(p.id) AS post_count
FROM posts AS p;

SELECT COUNT(t.id) AS tag_count
FROM posts AS t;

-- Task 2: Display each author's name and the number of posts they have written. Include authors with zero posts.
-- select a.name as author_name, count(p.id) as post_count
-- from  posts as p
-- left join authors as a
-- on p.author_id = a.id
-- group by  a.name;

-- Task 3: Display only authors who have written more than one post using GROUP BY and HAVING.
-- select a.name as author_name, count(p.id) as post_count
-- from  posts as p
-- left join authors as a
-- on p.author_id = a.id
-- group by  a.name
-- having count(p.id) > 1;

-- Task 4: Count published and unpublished posts separately.
-- select count(*), published  from posts
-- group by published;

-- Task 5: Count published and unpublished posts per author using aggregate FILTER clauses or conditional aggregation.
-- select
-- a.name,
-- count(*) filter (where p.published = true) as published_count,
-- count(*) filter (where p.published = false) as unpublished_count
-- from posts as p
-- left join authors as a
-- on p.author_id = a.id
-- group by a.name
-- ;

-- Task 6: Display each tag and the number of posts associated with it. Include tags that have no associated posts.
-- confusing!
-- select
-- t.name,
-- count(pt.post_id) as post_count
-- from tags as t
-- left join post_tags as pt
-- on t.id = pt.tag_id
-- group by t.id,t.name;

-- Key takeaway: WHERE filters rows before grouping; HAVING filters groups after aggregation.

-- Assignment 3 — Indexes and Query Performance

-- Goal: Understand indexes and practise reading query execution plans.

-- Tasks

-- Task 1: Insert enough sample posts to create a larger dataset, such as 10,000 posts.

-- use of select...insert
INSERT INTO posts (title, content, author_id, published)
SELECT
    'post ' || gs.n,
    'sample content for post ' || gs.n,
    a.id,
    gs.n % 2 = 0
FROM generate_series(1, 10000) AS gs(n)
CROSS JOIN LATERAL (
    SELECT id
    FROM authors
    ORDER BY RANDOM() * gs.n
    LIMIT 1
) AS a;

-- Task 3a: run query to find specific posts(posts id).
-- select count (*) as post_counts from posts;

-- explain analyze  select count(*) from posts where id = 2;

-- select count(*) from posts where id = 2;

-- Task 3b: run query to find specific posts(posts id) using index
-- create index idx_posts_id
-- on posts (id);

-- explain analyze
-- select count(*) from posts where id = 2;

-- select count(*) from posts where id = 2;

-- Key takeaway: Indexes can speed up reads, but they require storage and maintenance. An index does not guarantee that PostgreSQL will use it.

-- Assignment 4 — Transactions and UPSERT

-- Goal: Practise transactions, rollback, commit, and conflict handling.

-- Task 1: Start a transaction, insert a new author, and commit it.
BEGIN;

INSERT INTO AUTHORS(NAME,EMAIL)
VALUES
    ('JK', 'JK@G.C');
RETURNING *;

COMMIT;

SELECT *
FROM AUTHORS
WHERE NAME = 'JK';

-- Task 2: Start a transaction, insert a post, and roll it back. Verify that the post was not saved.
BEGIN;

INSERT INTO posts (title, content, author_id,published)
VALUES
    ('rollback', 'rollback content 123', 2, true)
RETURNING *;

ROLLBACK;

SELECT *
FROM posts
WHERE title = 'rollback';


-- Task 6: Insert a tag using INSERT ... ON CONFLICT DO NOTHING to handle an existing authors.
INSERT INTO tags (name)
VALUES
    ('database')
ON CONFLICT (name)
DO NOTHING;

-- Task 7: Use INSERT ... ON CONFLICT DO UPDATE to update an existing record instead of inserting a duplicate.
INSERT INTO tags (name)
VALUES
    ('database')
ON CONFLICT (name)
-- do update set name = "database tutorial";
DO UPDATE SET name = EXCLUDED.name;

SELECT COUNT(*) AS posts_total_count FROM posts;
