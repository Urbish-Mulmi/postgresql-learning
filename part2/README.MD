# PostgreSQL Learning — Part 2/3

> This is the README for Part 2 of PostgreSQL learning.

---

### Core Takeaways

* **RETURNING:** Shows affected records after an operation.
* **Pattern Matching via `LIKE, ILIKE, %, _`:** Match text patterns using wildcards.
* **IN / NOT IN / BETWEEN:** Filter records using lists and ranges.
* **IS NULL / IS NOT NULL:** Filter records based on NULL values.
* **LIMIT / OFFSET:** Controls how many records are returned and skipped, enabling pagination.
* **ORDER BY:** Sorts records.
* **UPDATE:** Changes existing records.
* **DELETE:** Removes records.
---
## 4. Files in `part2/`

| File                                           | Topic                         |
| ---------------------------------------------- | ----------------------------- |
| `01_sql_concepts.sql`                          | Basic SQL concepts            |
| `02_insert_single_record.sql`                  | Insert a single record        |
| `03_insert_multiple_records.sql`               | Insert multiple records       |
| `04_select_specific_column_vs_select_star.sql` | Selecting columns and aliases |
| `05_where_basic_filter.sql`                    | Basic filtering               |
| `06_and_or_not_filters.sql`                    | AND, OR, NOT                  |
| `07_like_ilike_patterns.sql`                   | Pattern matching              |
| `08_in_notin_between.sql`                      | IN, NOT IN, BETWEEN           |
| `09_Null_and_IsNotNull.sql`                    | NULL filtering                |
| `10_order_by.sql`                              | Sorting records               |
| `11_limit_offset_pagination.sql`               | LIMIT, OFFSET, pagination     |
| `12_update_single_row.sql`                     | Updating a single record      |
| `13_update_multiple_rows.sql`                  | Updating multiple records     |
| `14_delete_rows.sql`                           | Deleting records              |
| `15_returning_after_insert.sql`                | RETURNING clause              |

---

## 5. File 01 — Basic SQL Concepts

SQL is used to create, read, update, and delete data in relational databases.

```sql
SELECT *
FROM table_name;
```

* `SELECT` → Specifies the columns to retrieve.
* `FROM` → Specifies the table.
* `*` → Selects all columns.

---

## 6. Files 02–03 — Inserting Records

---

## 7. File 04 — Selecting Columns and Aliases

### Select Specific Columns

```sql
SELECT name, age
FROM students;
```

### Use Aliases

```sql
SELECT name AS product_name, product_price AS price
FROM products
WHERE product_price > 25000;
```

* `SELECT *` returns all columns.
* Selecting specific columns avoids retrieving unnecessary data.
* `AS` gives a column or expression an output name.

---

## 8. Files 05–06 — Filtering Records

### WHERE

```sql
SELECT *
FROM students
WHERE age > 20;
```

### AND, OR, NOT

```sql
SELECT *
FROM students
WHERE age >= 20 AND age <= 25;
```

* `AND` → All conditions must be true.
* `OR` → At least one condition must be true.
* `NOT` → Negates a condition.

Use parentheses when combining conditions to make the evaluation order clear.

---

## 9. File 07 — Pattern Matching

### Important

`%` and `_` are pattern-matching wildcards. **Use them with `LIKE` or `ILIKE`, not with `=`.**

| Operator / Pattern | Meaning                           |
| ------------------ | --------------------------------- |
| `LIKE`             | Case-sensitive pattern matching   |
| `ILIKE`            | Case-insensitive pattern matching |
| `%`                | Zero or more characters           |
| `_`                | Exactly one character             |

### Examples

```sql
-- Names starting with "Lap"
SELECT * FROM products
WHERE name LIKE 'Lap%';

-- Names containing "asus", regardless of case
SELECT * FROM products
WHERE name ILIKE '%asus%';

-- Any three characters followed by "top"
SELECT * FROM products
WHERE name LIKE '___top';
```

**Remember**
* `'Lap%'` → Starts with `Lap`, followed by zero or more characters.  
  Example: `Lap`, `Laptop`, `Lap123`

* `'%asus%'` → Contains `asus`, with any characters before or after it.  
  Example: `asus`, `myasus`, `asus laptop`

* `'___top'` → Exactly six characters: any three followed by `top`.  
  Example: `LapTop`, `DeskTop`

---

## 10. File 08 — IN, NOT IN, BETWEEN

### IN

Matches any value in a specified list.

```sql
SELECT *
FROM products
WHERE category IN ('Electronics', 'Furniture');
```

### NOT IN

Excludes values in a specified list.

```sql
SELECT *
FROM products
WHERE category NOT IN ('Electronics', 'Furniture');
```

### BETWEEN

Matches a range, including both endpoints.

```sql
SELECT *
FROM products
WHERE price BETWEEN 100 AND 20000;
```

**Remember:** Be careful when using `NOT IN` with a list containing `NULL`, because it can prevent rows from matching as expected.

---

## 11. File 09 — NULL Filtering

### Check for NULL

```sql
SELECT *
FROM products
WHERE description IS NULL;
```

### Check for NOT NULL

```sql
SELECT *
FROM products
WHERE description IS NOT NULL;
```

### Check for an Empty String

```sql
SELECT *
FROM products
WHERE description = '';
```

**Remember**

* `NULL` → No stored value.
* `''` → An empty string.
* `0` → A valid numeric value.
* Use `IS NULL` or `IS NOT NULL`, not `= NULL`.

---

## 12. File 10 — Sorting Records Using ORDER BY

### Descending Order

```sql
SELECT *
FROM products
ORDER BY price DESC;
```

* `ASC` → Ascending order; default if omitted.
* `DESC` → Descending order.

---

## 13. File 11 — LIMIT, OFFSET, Pagination

* `LIMIT` → Maximum number of rows returned.
* `OFFSET` → Number of rows skipped.
* Pagination displays records in smaller groups called pages.

### Example

```sql
SELECT *
FROM products
ORDER BY id
LIMIT 5 OFFSET 5;
```

This skips the first five rows and returns the next five.

### Pagination Formula

`OFFSET = (page - 1) * limit`

| Page | LIMIT | OFFSET |
| ---- | ----: | -----: |
| 1    |     5 |      0 |
| 2    |     5 |      5 |
| 3    |     5 |     10 |

**Remember:** Use a consistent `ORDER BY` so pagination returns records in a predictable order.

---

## 14. Files 12–13 — Updating Records

### Update a Single Record

```sql
UPDATE students
SET age = 23
WHERE id = 1;
```

### Update Multiple Records

```sql
UPDATE products
SET price = 500
WHERE category = 'Electronics';
```

* `UPDATE` → Specifies the table to modify.
* `SET` → Specifies the new values.
* `WHERE` → Determines which rows are updated.

**Important:** Without `WHERE`, all rows in the table are updated.

---

## 15. File 14 — Deleting Records

### Delete Specific Records

```sql
DELETE FROM products
WHERE id = 1;
```

### Delete All Records

```sql
DELETE FROM products;
```

**Important:** `DELETE FROM products;` removes every row from the table but leaves the table itself intact.

Before deleting, check the target records with a matching `SELECT` query.

---

## 16. File 15 — RETURNING Clause

`RETURNING` displays the rows affected by an `INSERT`, `UPDATE`, or `DELETE` statement.

### After INSERT

```sql
INSERT INTO products (name, category, price)
VALUES ('Laptop', 'Electronics', 50000)
RETURNING *;
```

### After UPDATE

```sql
UPDATE products
SET price = 45000
WHERE id = 1
RETURNING id, name, price;
```

### After DELETE

```sql
DELETE FROM products
WHERE id = 1
RETURNING *;
```

**Remember**

* `RETURNING *` → Returns all columns of affected rows.
* `RETURNING id, name` → Returns only the specified columns.
* Useful for verifying changes without running a separate query.

---

## 17. Part 2 — Revision
✓  RETURNING: Inspect affected rows after data changes.

✓ WHERE: Filter records using conditions.

✓ AND / OR / NOT: Combine conditions.

✓ LIKE / ILIKE: Match text patterns; `%` matches zero or more characters and `_` matches exactly one.

✓ IN / NOT IN / BETWEEN: Filter using lists and ranges.

✓ NULL: Use `IS NULL` and `IS NOT NULL`.

✓ LIMIT / OFFSET: Control results and implement pagination.

✓ ORDER BY: Sort records.

✓ UPDATE: Modify existing records; use `WHERE` carefully.

✓ DELETE: Remove records; use `WHERE` carefully.

---

`Part 2 ends here.`
