drop table if exists houses;

create table IF NOT EXISTS houses(
  id serial primary key,
  location text unique,
  price  numeric ,
  storeys integer,
  has_swimming_pool boolean
);

-- initial single record insert
Insert into houses
(
  location,price,storeys,has_swimming_pool
)
Values ('lalitpur', 20000, 3, false);

-- upsert for same house with updated deatils {price, swimming pool update}

Insert into houses(
  location,price,storeys,has_swimming_pool
)
Values ('lalitpur',50000, 3, true )
ON CONFLICT (location)
DO UPDATE set 
  price = EXCLUDED.PRICE,
  storeys = EXCLUDED.storeys,
  has_swimming_pool = EXCLUDED.has_swimming_pool
RETURNING *;  

-- multiple records insert
Insert into houses
(
  location,price,storeys,has_swimming_pool
)
Values ('kathmandu', 80000, 3, false),
       ('patan', 50000, 3, false),
       ('bhaktapur', 70000, 3, false),
       ('chandragiri', 40000, 3, false)
RETURNING *;        


select count(location) AS location_count from houses;

-- on conflict clause 2 action{a) upsert aka do update: if conflict occurs do update, else insert new record, b) do nothing: if conflict occurs do nothing else insert new record}
-- using upsert to change swimming_pool boolean to true for records other than chandragiri

insert into houses (location, has_swimming_pool)
values
('kathmandu',true),
('patan',true),
('bhaktapur',true)
on conflict(location)
do update set 
  has_swimming_pool = EXCLUDED.has_swimming_pool

returning *;

-- basis for upsert is heavily relied on conflict target
-- conflict target here is (location)
-- it is mandatory to give value of location to achieve has_swimming_pool value get updated

-- do nothing:
insert into houses (location,storeys, has_swimming_pool)
values
('kathmandu',11,false),
('patan', 11,false),
('nagarkot',11, false)
on conflict(location)
do nothing

returning *;