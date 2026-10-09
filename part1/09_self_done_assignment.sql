-- PostgreSQL Fundamentals Assignment
-- Topics: Table creation, constraints, INSERT, SELECT, NULL, and JSONB
-- Table: basics.assignment_students
-- where schema is basics.

-- ==================================================
-- Task 1: Create a Table
-- ==================================================

-- Create a table named basics.assignment_students with:
-- id       : Auto-generated integer primary key
-- name     : Required text
-- email    : Required text with unique values
-- age      : Integer
-- gpa      : Numeric value with 2 decimal places
-- metadata : JSONB with an empty JSON object as the default
--
-- drop table if exists basics.assignment_students ;

-- create table basics.assignment_students
-- (
--   id serial primary key,
--   name text not null,
--   email text not null unique,
--   age integer,
--   gpa numeric(3,2),
--   metadata jsonb default '{}'::jsonb
-- );


-- ==================================================
-- Task 2: Apply Constraints
-- ==================================================

-- Create the table with these additional rules:
-- - Age must be greater than zero when provided.
-- - GPA must be between 0.00 and 4.00 when provided.
--
-- Learning note: Use CHECK to enforce a range:
-- CHECK (column_name BETWEEN lower_value AND upper_value)

drop table if exists basics.assignment_students ;

create table basics.assignment_students
(
  id serial primary key,
  name text not null,
  email text not null unique,
  age integer check (age>0),
  gpa numeric(3,2) check (gpa  between 0.00 AND 4.00),
  metadata jsonb default '{}'::jsonb
);


-- ==================================================
-- Task 3: Insert Student Records
-- ==================================================

-- Insert student records with different names, emails,
-- ages, GPAs, and JSONB metadata.
-- Let PostgreSQL generate each ID automatically.

Insert into
 basics.assignment_students (name, email,age,gpa,metadata)
VALUES
('Amy', 'amy@g.com', 20, 3.05,'{"department": "engineering"}' ),
('Camy', 'Camy@g.com', 22, 3.00,'{"department":"engineering"}' ),
('Emy', 'Emy@g.com', 20, 1.00,'{"department":"private_equity"}' ),
('Remy', 'Remy@g.com', 22, 2.01,'{"department":"private_equity"}' ),
('Femy', 'Femy@g.com', 20, 3.01,'{"department":"arts"}' ),
('Jake', 'Jake@g.com', 22, 2.01,'{"department":"arts"}' ),
('Jae', 'Jae@g.com', 20, 3.01,'{"department":"philosophy"}' ),
('Yae', 'Yae@g.com', 22, 2.01,'{"department":"philosophy"}' );

-- SELECT * FROM basics.assignment_students;


-- ==================================================
-- Task 4: Query the Data
-- ==================================================

-- 4.1 Display all students.
    -- select * from basics.assignment_students ;

-- 4.2 Find students older than 20.
    -- select * from basics.assignment_students where age >20;

-- 4.3 Find students whose GPA is at least 3.00.
    -- select * from basics.assignment_students  where gpa >= 3;

-- 4.4 Find students whose metadata contains the 'department' key.
--     Key-existence filtering: column ? 'key_name'
    -- select * from basics.assignment_students  where metadata? 'department';

-- 4.5 Find students whose department is 'engineering'.
--     Key-value filtering: column ->> 'key_name' = 'value'
    -- select * from basics.assignment_students  where metadata->>'department'='engineering';


-- ==================================================
-- Task 5: Understand Missing Values
-- ==================================================

-- Insert one additional student with a NULL age
-- and an empty JSON object ({}) as metadata.

-- Find students whose age is NULL.

    -- Insert into basics.assignment_students (name, email,age,gpa,metadata) VALUES ('NullAge', 'Null@g.com', null, 3.05,default );
    -- select * from basics.assignment_students where age is Null;


-- ==================================================
-- Task 6: Test the Constraints
-- ==================================================

-- Attempt to insert students with:
-- - A duplicate email
-- - An invalid age (zero or negative)
-- - A GPA above 4.00
--
-- Test the invalid values and observe how PostgreSQL
-- enforces the constraints.

-- Insert into basics.assignment_students (name, email,age,gpa,metadata)
--  VALUES
--   ('duplicatemail-1', 'dupli@g.com', 4, 5.05,default ),
--   ('duplicatemail-2', 'dupli@g.com', 3, 5.05,default ),
--   ('errorAgw', 'dupli@g.com', -4, 5.05,default );
-- select * from basics.assignment_students;
```
```sql
-- PostgreSQL Fundamentals Assignment
-- Topics: Table creation, constraints, INSERT, SELECT, NULL, and JSONB
-- Table: basics.assignment_students


-- ==================================================
-- Task 1: Create a Table
-- ==================================================

-- Create a table named basics.assignment_students with:
-- id       : Auto-generated integer primary key
-- name     : Required text
-- email    : Required text with unique values
-- age      : Integer
-- gpa      : Numeric value with 2 decimal places
-- metadata : JSONB with an empty JSON object as the default
--
-- drop table if exists basics.assignment_students ;

-- create table basics.assignment_students
-- (
--   id serial primary key,
--   name text not null,
--   email text not null unique,
--   age integer,
--   gpa numeric(3,2),
--   metadata jsonb default '{}'::jsonb
-- );


-- ==================================================
-- Task 2: Apply Constraints
-- ==================================================

-- Create the table with these additional rules:
-- - Age must be greater than zero when provided.
-- - GPA must be between 0.00 and 4.00 when provided.
--
-- Learning note: Use CHECK to enforce a range:
-- CHECK (column_name BETWEEN lower_value AND upper_value)

drop table if exists basics.assignment_students ;

create table basics.assignment_students
(
  id serial primary key,
  name text not null,
  email text not null unique,
  age integer check (age>0),
  gpa numeric(3,2) check (gpa  between 0.00 AND 4.00),
  metadata jsonb default '{}'::jsonb
);


-- ==================================================
-- Task 3: Insert Student Records
-- ==================================================

-- Insert student records with different names, emails,
-- ages, GPAs, and JSONB metadata.
-- Let PostgreSQL generate each ID automatically.

Insert into
 basics.assignment_students (name, email,age,gpa,metadata)
VALUES
('Amy', 'amy@g.com', 20, 3.05,'{"department": "engineering"}' ),
('Camy', 'Camy@g.com', 22, 3.00,'{"department":"engineering"}' ),
('Emy', 'Emy@g.com', 20, 1.00,'{"department":"private_equity"}' ),
('Remy', 'Remy@g.com', 22, 2.01,'{"department":"private_equity"}' ),
('Femy', 'Femy@g.com', 20, 3.01,'{"department":"arts"}' ),
('Jake', 'Jake@g.com', 22, 2.01,'{"department":"arts"}' ),
('Jae', 'Jae@g.com', 20, 3.01,'{"department":"philosophy"}' ),
('Yae', 'Yae@g.com', 22, 2.01,'{"department":"philosophy"}' );

-- SELECT * FROM basics.assignment_students;


-- ==================================================
-- Task 4: Query the Data
-- ==================================================

-- 4.1 Display all students.
    -- select * from basics.assignment_students ;

-- 4.2 Find students older than 20.
    -- select * from basics.assignment_students where age >20;

-- 4.3 Find students whose GPA is at least 3.00.
    -- select * from basics.assignment_students  where gpa >= 3;

-- 4.4 Find students whose metadata contains the 'department' key.
--     Key-based filtering: column ? 'key_name'
    -- select * from basics.assignment_students  where metadata? 'department';

-- 4.5 Find students whose department is 'engineering'.
--     Key&value based filtering: column ->> 'key_name' = 'value'
    -- select * from basics.assignment_students  where metadata->>'department'='engineering';


-- ==================================================
-- Task 5: Understand Missing Values
-- ==================================================

-- Insert one additional student with a NULL age
-- and an empty JSON object ({}) as metadata.

-- Find students whose age is NULL.

    -- Insert into basics.assignment_students (name, email,age,gpa,metadata) VALUES ('NullAge', 'Null@g.com', null, 3.05,default );
    -- select * from basics.assignment_students where age is Null;


-- ==================================================
-- Task 6: Test the Constraints
-- ==================================================

-- Attempt to insert students with:
-- - A duplicate email
-- - An invalid age (zero or negative)
-- - A GPA above 4.00
--
-- Test the invalid values and observe how PostgreSQL
-- enforces the constraints.

-- Insert into basics.assignment_students (name, email,age,gpa,metadata)
--  VALUES
--   ('duplicatemail-1', 'dupli@g.com', 4, 5.05,default ),
--   ('duplicatemail-2', 'dupli@g.com', 3, 5.05,default ),
--   ('errorAge', 'dupli@g.com', -4, 5.05,default );
-- select * from basics.assignment_students;

