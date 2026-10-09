DROP table IF EXISTS basics.students;

create table basics.students(
  id serial primary key,
  name text not null,
  email text not null unique,
  age integer check (age >= 18),

  created_at TIMESTAMP DEFAULT NOW()

);

INSERT into basics.students (name, email, age)
VALUES
 ('RAMA', 'RAMA@g.com', 33),
 ('Nais', 'Nais@g.com', 20);
 
-- view records
SELECT * from basics.students; 