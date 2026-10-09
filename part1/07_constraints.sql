--  Database Constraints:
-- rules enforced by the database to maintain data integrity.
  -- Backend validation exists, but database constraints are still needed to protect data if application validation is bypassed or data is inserted through another script or client.
-- Why is backend validation still needed?
  -- Backend validation handles more complex business logic, checks input before database operations, and provides clear, user-friendly error messages.
-- NOT NULL, UNIQUE, CHECK, PRIMARY KEY

Drop table if exists basics.accounts;

create table basics.accounts 
(
 id serial primary key,
 full_name text not null,
 email text not null unique,
 is_active boolean default true,
 age integer check (age>= 18),
 created_at timestamp default now()
);

-- Valid inserts
-- insert into basics.accounts(full_name, email, age) VALUES('Urb', 'u@g', 21);

-- Duplicate email violation
-- insert into basics.accounts(full_name, email, age) VALUES('Urb', 'u@g', 21),('Amy', 'u@g', 23);

-- Age (>=18) constraint violation
insert into basics.accounts(full_name, email, age)
VALUES  ('Urb', 'u@g', 21),
        ('Amy', 'amy@g', 23),
        ('Am', 'am@g', 90);

select * from basics.accounts;

