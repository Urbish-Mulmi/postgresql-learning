-- hierarchy of components in postgreSQL database: [db->schema->table->row/column]

CREATE SCHEMA IF NOT EXISTS basics;

-- to create uuid we need this extension
CREATE EXTENSION IF NOT EXIsTS pgcrypto;

-- query to get all schema

SELECT schema_name 
FROM information_schema.schemata
ORDER BY schema_name;
