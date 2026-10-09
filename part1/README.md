# PostgreSQL Learning — Part 1/3

> This is the README for Part 1 of PostgreSQL learning.

---

## How to Run SQL Files

**Database:** `postgresql_part1`

Run commands from the repository root (`D:\postgresql-learning`) in the VS Code PowerShell terminal.

**Run a specific SQL file:**

```powershell
psql -U postgres -d postgresql_part1 -f .\part1\03_first_table.sql
```

Replace the filename with the SQL file you want to execute.

**Command breakdown:**

* `-U postgres` — Connect as the `postgres` user.
* `-d postgresql_part1` — Connect to this database.
* `-f` — Execute the specified SQL file.

---

## 1. Setup Info

* PostgreSQL server runs via Docker.
* PostgreSQL CLI (`psql`) is installed locally.
* SQL commands can now be executed from the VS Code terminal.

---

## 2. PostgreSQL Structure — ELI5

```text
PostgreSQL Server
└── Database
    └── Schema (schema name in current setup: basics)
        └── Table (One of a table name: students)
            ├── Columns → Structure and rules
            └── Rows    → Actual data
```

### Core Takeaways

* **Mental model:** Create a database → create a schema → create a table → insert data.
* **Schema:** Organizes related tables. The schema used in this setup is named `basics`. We don't define constraints here.
* **Table:** Defines columns, data types, and constraints.
* **Constraints:** Rules that control valid data, e.g., `NOT NULL`, `UNIQUE`, `CHECK`.
* **Purpose:** Better organization, namespacing, and permission management.

---

## 3. Setting Up Commands

### 1a. Create a brand-new database via VS Code CLI using `psql`

```powershell
psql -h localhost -p 5432 -U postgres -d postgres -f .\part1\01_first_database.sql
```

### 1b. Run a SQL file for a specific database

```powershell
psql -U postgres -d database_name -f .\path\to\file.sql
```

### 2. Connect to a database

```powershell
psql -U postgres -d postgresql_part1
```

### 3. List all databases

```sql
\l
```

### 4. List tables
```sql
\dt
```

### 5. List schemas inside the current database

```sql
\dn
```

### 6. Exit `psql`

```sql
\q
```

Or type `exit` in the shell after leaving `psql`.

### 7. Core workflow

**Make a database → make a schema → make a table → insert into table.**

---

## 4. Files in `part1/`

| File                            | Topic                               |
| ------------------------------- | ----------------------------------- |
| `01_first_database.sql`         | Database setup                      |
| `02_first_schema.sql`           | Schema setup                        |
| `03_first_table.sql`            | Table creation and insertion        |
| `04_data_types.sql`             | Data types                          |
| `05_other_data_types.sql`       | UUID, JSON, JSONB                   |
| `06_null_empty_string_zero.sql` | NULL, empty string, zero, undefined |
| `07_constraints.sql`            | Database constraints                |
| `08_primary_keys.sql`           | Primary keys                        |
| `09_self_done_assignment.sql`   | Assignment to revise  part1 contents|

### Files 01–03: Database, Schema, Table

**Core workflow:** Create a database → create a schema → create a table → insert data.

Execute a specific file from the VS Code terminal:

```powershell
psql -U postgres -d database_name -f .\part1\file_name.sql
```

---

## 5. File 04 — Data Types

| Type            | Purpose                                       |
| --------------- | --------------------------------------------- |
| `TEXT`          | Store strings without a declared length limit |
| `VARCHAR(n)`    | Set a maximum string length                   |
| `INTEGER`       | Store whole numbers                           |
| `BIGINT`        | Store larger whole numbers                    |
| `NUMERIC(p, s)` | Store exact decimal values                    |
| `BOOLEAN`       | Store `TRUE` or `FALSE`                       |
| `PRIMARY KEY`   | Uniquely identify a row                       |

### Remember

* `INTEGER` → Whole numbers.
* `BIGINT` → Larger whole numbers.
* `NUMERIC(p, s)` → `p` = total digits; `s` = digits after the decimal point.

Example: `NUMERIC(6,2)` allows six total digits, with two after the decimal point.

---

## 6. File 05 — Other Data Types

### UUID

* **UUID:** Universally unique identifier for a record.

```sql
CREATE TABLE basics.users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid()
);
```

**Remember the three parts:**

* `UUID` → Data type of the ID.
* `PRIMARY KEY` → Uniquely identifies each row.
* `DEFAULT gen_random_uuid()` → Automatically generates the ID when you omit it.

### JSON / JSONB

* **JSON:** Stores JSON data in its original textual representation.
* **JSONB:** Stores JSON in a binary representation, supporting efficient processing and indexing.
* **Use case:** Storing flexible metadata.
* **Filtering:** Records can be found using JSON keys and key-value pairs.

### Example — Filtering JSONB by Key and Value

Suppose a table has a `metadata` column containing:

```json
{
  "department": "engineering",
  "level": "junior"
}
```

**1. Check whether a key exists**

Find records whose metadata contains the `department` key, regardless of its value.

```sql
SELECT *
FROM students
WHERE metadata ? 'department';
```

**General pattern:** `column ? 'key_name'`

**2. Find a specific key-value match**

Find records where the `department` value is `engineering`.

```sql
SELECT *
FROM students
WHERE metadata ->> 'department' = 'engineering';
```

**General pattern:** `column ->> 'key_name' = 'value'`

**3. Match a key-value pair using containment**

Find records whose metadata contains the specified JSON structure.

```sql
SELECT *
FROM students
WHERE metadata @> '{"department": "engineering"}';
```

### Practice — Apply These Operators

Using `basics.assignment_students`:

**Check whether the `department` key exists:**

```sql
SELECT *
FROM basics.assignment_students
WHERE metadata ? 'department';
```

**Find students in the engineering department:**

```sql
SELECT *
FROM basics.assignment_students
WHERE metadata ->> 'department' = 'engineering';
```

### Remember

* `?` → Checks whether a top-level key exists.
* `->` → Extracts a JSON value, preserving its JSON type.
* `->>` → Extracts a value as text.
* `@>` → Checks whether a JSONB value contains the specified JSON structure.

---

## 7. File 06 — NULL, Empty, Undefined, Unknown, Zero

### ENUUZ

| Concept   | Meaning                                                | Example          |
| --------- | ------------------------------------------------------ | ---------------- |
| Empty     | Something exists but contains nothing                  | Empty array `[]` |
| NULL      | No value is stored                                     | `NULL`           |
| Undefined | JavaScript value that hasn't been assigned or provided | `let age;`       |
| Unknown   | Not knowing the value of something                     | Unknown age      |
| Zero      | A valid numeric value                                  | `stock = 0`      |

### JavaScript Examples

```javascript
let a;           // undefined

let b = null;    // explicitly no value

let c = [];      // initialized, empty array

let d = [1, 2];  // array containing elements
```

### SQL: Check for NULL

```sql
WHERE column_name IS NULL;
```

### SQL: Check for NOT NULL

```sql
WHERE column_name IS NOT NULL;
```

### SQL: Check for an empty string

```sql
WHERE column_name = '';
```

### SQL: Check for neither NULL nor empty

```sql
WHERE column_name IS NOT NULL
  AND column_name <> '';
```

---

## 8. File 07 — Database Constraints

### What are constraints?

Specific rules enforced by the database to maintain data integrity.

Backend validation exists, but database constraints are still needed to protect data if application validation is bypassed or data is inserted through another script or client.

### Qs. Why is backend validation still needed?

Backend validation handles more complex business logic and provides clear, user-friendly error messages. It also supports better UI/UX.

### Common constraints

| Constraint    | Purpose                                                                |
| ------------- | -----------------------------------------------------------------------|
| `NOT NULL`    | Prevents NULL values                                                   |
| `UNIQUE`      | Prevents duplicate values under the constraint                         |
| `CHECK`       | Enforces a condition                                                   |
| `PRIMARY KEY` | Uniquely identifies each row                                           |
| `FOREIGN KEY` | Enforces relationships with referenced records                         |
| `CHECK` with `BETWEEN` | Enforces a range, e.g. `CHECK (price BETWEEN 1000 AND 20000)` |

---

## 9. File 08 — Primary Keys

### Why is a primary key needed?

Without a primary key, it becomes harder to reliably identify a particular row for updates, deletions, and relationships with other tables.

### Qs. What happens if a table has no primary key?

The database can still store rows, but duplicate rows may exist, and identifying a specific row reliably becomes harder. Other tables also lack a designated primary key to reference through a foreign key.

### Example

```sql
id SERIAL PRIMARY KEY;
```

* `SERIAL` creates an integer column with an automatically generated sequence-backed default.
* `SERIAL` is not a separate integer type; it is shorthand for creating an integer column with sequence-based generation.

---

## 10. Part 1 —  Revision

✓ Understand the PostgreSQL structuring for ease → database → schema → table structure.

✓ Must create a database, schema then table.

✓ Schema contains related tables.

✓ Execute SQL files using `psql`.

✓ Understand common data types.

✓ Distinguish NULL, empty string, undefined, and zero.

✓ Revise JSON/JSONB based key, key&value filtering.

✓ Importance, need of  database constraints and primary keys.

---
`Part 1 ends here.`
