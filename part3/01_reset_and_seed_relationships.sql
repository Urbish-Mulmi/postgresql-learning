--  timestamp of part3 begins: 2:37:24

--  CURENT DB: postgres db,  DEFAULT schema named public, 

-- here stuffs done are:
  -- tables are created
  -- referencing another table column (foreign key)  
  -- post and tags can have many to many relation as well in this setup.
  -- important:
      --  table droping is easy when used ORM, else we need to figure out which table is referencing and which table is being referenced so that,
      -- referencing table is dropped first only then referenced table is dropped



select '------------------ 1.Manual Correction-> RESET: Drop dependent tables first------------------'  AS Message;  
-- Drop the referencing (child) tables first, then the referenced (parent) tables.

DROP TABLE IF EXISTS post_tags;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS users;

create table users(
  id uuid primary key default gen_random_uuid(),
  name text not null
);

create table posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null REFERENCES users(id),
  title text not null,
  status text not null default 'draft'
   check (status in ('draft', 'published')),
  views integer not null default 0 check (views >= 0) 
);

create table comments(
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null REFERENCES posts (id),
  body text not null
);

create table tags(
  id uuid primary key default gen_random_uuid(),
  name text not null unique
);

create table post_tags(
  post_id uuid not null references posts(id),
  tag_id uuid not null references tags(id),
  primary key(post_id, tag_id)
);

-- schema making done
-- 
-- inserting datas(simple insert, inserting for a referencing columns)
  -- insert into users table

insert into users(name)
values ('Ananya'),
        ('Rahul');


-- How to add value for a referencing field?
  --here user_id is a referencing field, to pass value into it we use: {select id-from tablename-define constraint}
insert into  posts (user_id, title, status, views)
select id, 'PostgreSQL joins explained', 'published', 100
from users 
where name = 'Ananya';

insert into  posts (user_id, title, status, views)
select id, 'Indexes for beginners', 'draft', 40
from users 
where name = 'Ananya';

insert into  posts (user_id, title, status, views)
select id, 'Backend APIs with postgreSQL', 'published', 180
from users 
where name = 'Rahul';

  -- insert into comments table
insert into comments (post_id, body)
select id, 'very clear explanation'
from posts
where title='PostgreSQL joins explained';

insert into comments (post_id, body)
select id, 'Please add more examples'
from posts
where title='Backend APIs with postgreSQL';

-- insert into tags table
insert into tags (name)
values ('sql'), ('backend');

-- insert into post_tags table
Insert into post_tags (post_id, tag_id)
select p.id, t.id
from posts p, tags t
where p.title = 'PostgreSQL joins explained'
  And t.name = 'sql'    ;

Insert into post_tags (post_id, tag_id)
select p.id, t.id
from posts p, tags t
where p.title = 'Indexes for beginners'
  And t.name = 'sql'    ;

Insert into post_tags (post_id, tag_id)
select p.id, t.id
from posts p, tags t
where p.title = 'Backend APIs with postgreSQL'
  And t.name = 'backend'    ;

select 'part 3 reduced database reset and sample data inserted success'  AS Message;



