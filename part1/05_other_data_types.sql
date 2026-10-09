Drop table if exists basics.app_events;

CREATE TABLE basics.app_events(
  --UUID-
  -- use of generate random uuid
  id UUID primary key default gen_random_uuid(),

  event_name TEXT NOT NULL,

  --JSONB:store data in binary format, used when we need to store metadata
  metadata JSONB DEFAULT '{}'::jsonb,

  created_at TIMESTAMP DEFAULT NOW()
);

insert into basics.app_events (event_name, metadata)
VALUES
(
 'sign_up',
 '{"browser":"chrome"}'
),
(
 'log_in',
 DEFAULT
),
(
 'sign_in',
 '{"user":"urban"}'
);

-- to view all 
-- SELECT * FROM basics.app_events;

-- to filter jsonb/json data type column based on key, keys value
-- Select event_name, metadata ->>'browser' AS browser from basics.app_events WHere metadata? 'browser';