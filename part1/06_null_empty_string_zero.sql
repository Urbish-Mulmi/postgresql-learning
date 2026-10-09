--null - unknown/missing val
--empty string - known string value but no characters
--zero - actual numeric value of 0

Drop table if exists basics.value_examples;

Create table basics.value_examples

 ( id serial primary key,
  nickname text,
  bio text,
  score integer
);

insert into basics.value_examples(nickname, bio, score)
values
(null, 'null nicknam', 10),
('', 'empty nicknam', 10),
('sangam', null, 0),
('john', null,null);

-- view all records
-- Select * from basics.value_examples;

-- view records where nickname is null

-- select * from basicsvalue_examples where nickname is NULL;

-- view records where nickname is empty
-- select * from basics.value_examples where nickname = '';

-- view records where nickname is not null
-- select * from basics.value_examples where nickname IS NOT NULL  ;

-- view records where nickname is not null and not empty
-- select * from basics.value_examples where nickname IS NOT NULL AND nickname <> '';
