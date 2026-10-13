# PostgreSQL Learning — Part 3/3

> This is the README for Part 3 of PostgreSQL learning.

---

## 1. Core Takeaways

* **Normalization:** Reduce unnecessary duplication and prevent data inconsistencies.
* **Relationships:** Use primary keys and foreign keys to connect tables.
* **JOINs:** Retrieve related data from multiple tables.
* **Aggregate Functions:** Calculate values using `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`.
* **GROUP BY / HAVING:** Group rows and filter groups.
* **Subqueries:** Use a query inside another query.
* **Indexes:** Speed up suitable queries at the cost of storage and write overhead.
* **Transactions:** Group database operations into a unit of work.
* **ON CONFLICT:** Handle uniqueness conflicts during insertion.

---

## 2. Files in `part3/`

| File | Topic |
| --- | --- |
| `01_reset_and_seed_relationships.sql` | Reset and seed sample data |
| `02_foreign_keys.sql` | Foreign keys |
| `03_one_to_many_relationship.sql` | One-to-many relationships |
| `04_inner_join.sql` | INNER JOIN |
| `05_left_join.sql` | LEFT JOIN |
| `06_many_to_many_relationships.sql` | Many-to-many relationships |
| `07_table_aliasses.sql` | Table aliases |
| `08_aggregate_functions.sql` | Aggregate functions |
| `09_groupby_havingfilter.sql` | GROUP BY, HAVING, FILTER |
| `10_count_distinct.sql` | COUNT DISTINCT |
| `11_sub_queries.sql` | Subqueries |
| `12_indexes.sql` | Indexes and query plans |
| `13_transactions.sql` | Transactions |
| `14_on_conflict_upsert.sql` | ON CONFLICT and UPSERT |

---

## 3. Normalization — 1NF, 2NF, 3NF

| Normal Form | Core Idea |
| --- | --- |
| 1NF | One value per cell; no lists of values in a column |
| 2NF | No partial dependency on part of a composite candidate key |
| 3NF | No transitive dependency of non-key attributes on a key |

**Remember:** Normalize to reduce redundant data and avoid update, insertion, and deletion anomalies.

---

## 4. Files 01–06 — Relationships and JOINs

* **Foreign key:** Enforces a relationship by requiring referenced values to exist.
* **One-to-many:** One user can have many posts; each post references one user.
* **Many-to-many:** Use a junction table, such as `post_tags`, to connect posts and tags.

| JOIN | What It Returns |
| --- | --- |
| `INNER JOIN` | Only matching rows |
| `LEFT JOIN` | All left-side rows, plus matching right-side rows; unmatched right-side columns are `NULL` |

**Interview point:** A foreign key does not automatically make its column unique.

---

## 5. Files 07–10 — Aliases and Aggregation

* **Aliases:** Use `AS` to give tables, columns shorter  names so that its easier to address them
* **Aggregate functions:** `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`.
* **`COUNT(*)`:** Counts rows.
* **`COUNT(column)`:** Counts non-NULL values.
* **`COUNT(DISTINCT column)`:** Counts distinct, non-NULL values.

| Clause | Purpose |
| --- | --- |
| `WHERE` | Filters rows before grouping |
| `GROUP BY` | Groups rows for aggregation |
| `HAVING` | Filters groups after aggregation |
| `FILTER` | Filters input rows for an individual aggregate |

**Interview point:** Aggregate functions cannot be used directly in `WHERE`; use `HAVING` or a subquery when filtering by aggregate results.

---

## 6. File 11 — Subqueries

A subquery is a query inside another query. The outer query uses its result.

**Interview point:** PostgreSQL's query planner determines the execution strategy; the inner query does not necessarily execute first as a separate operation.

---

## 7. File 12 — Indexes

An index helps PostgreSQL locate matching rows without necessarily scanning the entire table.

* `Seq Scan` → Scans the table.
* `Index Scan` → Uses an index to locate rows.
* `EXPLAIN ANALYZE` → Executes a query and reports its plan and actual timing.

**Interview points**

* Indexes can speed up reads but consume storage and add write overhead.
* Creating an index does not guarantee PostgreSQL will use it.
* `ANALYZE` updates table statistics used by the query planner.

---

## 8. File 13 — Transactions

A transaction groups database operations into a logical unit of work.

* `BEGIN` → Starts a transaction.
* `COMMIT` → Commits its changes.
* `ROLLBACK` → Discards uncommitted changes.
* **Atomicity (ACID):** Changes are committed together or rolled back together.

**Remember:** A statement affecting zero rows does not automatically trigger a rollback.

---

## 9. File 14 — ON CONFLICT and UPSERT

Handles uniqueness conflicts during an `INSERT`.

* `DO UPDATE` → Updates the existing row when a conflict occurs; otherwise, inserts.
* `DO NOTHING` → Skips the conflicting insertion.
* `EXCLUDED.column` → Refers to the proposed value for that column.
* `RETURNING` → Returns affected rows; rows skipped by `DO NOTHING` are not returned.

**Remember:** The inserted or updated data must still satisfy applicable database constraints.

---

## 10. Part 3 — Revision

✓ Normalization: 1NF, 2NF, 3NF.

✓ Relationships: Primary keys, foreign keys, junction tables.

✓ JOINs: `INNER JOIN` vs. `LEFT JOIN`.

✓ Aggregation: `COUNT`, `COUNT DISTINCT`, `GROUP BY`, `HAVING`, `FILTER`.

✓ Subqueries: Nested queries and query-planner behavior.

✓ Indexes: Read performance, write overhead, `EXPLAIN ANALYZE`.

✓ Transactions: `BEGIN`, `COMMIT`, `ROLLBACK`, atomicity.

✓ UPSERT: `ON CONFLICT`, `DO UPDATE`, `DO NOTHING`.

---

`Part 3 ends here.`