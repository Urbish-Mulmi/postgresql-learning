-- PostgreSQL Indexes

-- An index helps PostgreSQL find records without scanning the entire table.

-- Like a book index helps you find a topic without reading every page, a database index helps locate matching rows faster.
-- - Without an index: PostgreSQL may scan the table row by row (`Seq Scan`).
-- - With an index: PostgreSQL can locate matching rows through an index (`Index Scan`).


-- 1. Create a Practice Table
DROP TABLE IF EXISTS power_rangers;

CREATE TABLE power_rangers (
    id SERIAL PRIMARY KEY, ranger_name TEXT NOT NULL,
    series_name TEXT NOT NULL, ranger_color TEXT NOT NULL
);
SELECT 'Table created successfully [OK]' AS success_message;

--  2. Generate 500,000 Records
INSERT INTO power_rangers (
    ranger_name, series_name, ranger_color
)
SELECT
    'Ranger_' || g,
    (ARRAY[
        'Dino Thunder','Mystic Force','RPM','SPD','Jungle Fury','Ninja Storm'
    ])[1 + (g % 6)::INTEGER],
    (ARRAY[
        'Red','Blue','Yellow','Green','Black','Pink'
    ])[1 + (g % 6)::INTEGER]
FROM generate_series(1, 500000) AS g;

SELECT '500,000 records inserted successfully [OK]' AS success_message;

--  3. Verify the Records
SELECT COUNT(*) AS total_records_count
FROM power_rangers;

SELECT * FROM power_rangers LIMIT 5;

SELECT 'Records added and verified [OK]' AS success_message;

--  4. Search Without an Index
DROP INDEX IF EXISTS idx_power_rangers_ranger_name;

SELECT 'Search without index: see query plan and execution time [OK]' AS success_message;

EXPLAIN ANALYZE
SELECT * FROM power_rangers WHERE ranger_name = 'Ranger_400';

SELECT * FROM power_rangers WHERE ranger_name = 'Ranger_400';

-- Observe:
-- - `Parallel Seq Scan` or `Seq Scan` — PostgreSQL scans the table.
-- - `Rows Removed by Filter` — rows that didn't match the condition.
-- - `Execution Time` — time PostgreSQL reports for executing the query.

--  5. Create an Index
CREATE INDEX idx_power_rangers_ranger_name
ON power_rangers (ranger_name);

SELECT 'Index created successfully [OK]' AS success_message;

-- Index naming convention: idx_tableName_columnName
-- - `idx` — index; `power_rangers` — table name;  `ranger_name` — indexed column

--  6. Search using an Index
SELECT 'Search with index: see query plan and execution time [OK]' AS success_message;

EXPLAIN ANALYZE
SELECT * FROM power_rangers WHERE ranger_name = 'Ranger_400';

SELECT * FROM power_rangers WHERE ranger_name = 'Ranger_400';


--  7. Observed Results

-- | Metric | Without Indexes         | With index |                                    
-- |--------|-------------------------|------------|
-- | Scan method | Parallel Seq Scan  | Index Scan |
-- | Execute time| 16.401 ms          | 0.089 ms   |                                    
-- | RowsReturned| 1                  |  1         |


-- --  Key Takeaways

-- - An index is a separate data structure that helps PostgreSQL locate rows.
-- - `EXPLAIN ANALYZE` executes a query and reports its execution plan and actual timing.
-- - PostgreSQL chooses whether to use an index based on estimated cost; creating an index doesn't guarantee it will be used.




