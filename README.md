# Auto Showroom Database (Oracle SQL) — Course Project

This repository contains an **Oracle SQL** database project that models the activity of an **auto showroom**, designed to manage:
- customers
- cars (available/sold)
- employees involved in sales
- sales transactions
- test drives
- payments for purchases

The database is structured to be **normalized (at least 3NF)** and demonstrates DDL, DML, constraints, and advanced SQL queries (joins, set operators, CASE/DECODE, subqueries, hierarchical queries), plus additional objects (views, indexes, sequences, synonyms).

---

## Database Overview

### Main Entities (6 Tables)
- **SR_CLIENTI** — customer identification data (name, phone, email)
- **SR_MASINI** — cars in the showroom (brand, model, year, price, status)
- **SR_ANGAJATI** — employees (name, role, salary)
- **SR_VANZARI** — sales transactions linking customer, car, employee, date, final price
- **SR_TESTDRIVE** — test drives performed by customers for cars (date + feedback)
- **SR_PLATI** — payments made for a sale (amount, method, date)

### Relationships
- **1:N**
  - one customer → multiple sales / multiple test drives
  - one employee → multiple sales
  - one sale → one or more payments
- **Keys & constraints** enforce referential integrity using **PK/FK**, plus **NOT NULL**, **CHECK**, and basic data rules.

---

## Schema Summary

### Tables & Columns (High Level)
**SR_CLIENTI**
- `id_client` (PK), `nume`, `prenume`, `telefon`, `email`

**SR_MASINI**
- `id_masina` (PK), `marca`, `model`, `an_fabricatie`, `pret`, `status`

**SR_ANGAJATI**
- `id_angajat` (PK), `nume`, `functie`, `salariu`

**SR_VANZARI**
- `id_vanzare` (PK), `id_client` (FK), `id_masina` (FK), `id_angajat` (FK), `data_vanzare`, `pret_final`

**SR_TESTDRIVE**
- `id_test` (PK), `id_client` (FK), `id_masina` (FK), `data_test`, `feedback`

**SR_PLATI**
- `id_plata` (PK), `id_vanzare` (FK), `suma`, `metoda_plata`, `data_plata`

---

## Constraints Implemented

### Primary Keys
- `pk_sr_clienti`, `pk_sr_masini`, `pk_sr_angajati`, `pk_sr_vanzari`, `pk_sr_testdrive`, `pk_sr_plati`

### Foreign Keys
- `SR_VANZARI.id_client` → `SR_CLIENTI.id_client`
- `SR_VANZARI.id_masina` → `SR_MASINI.id_masina`
- `SR_VANZARI.id_angajat` → `SR_ANGAJATI.id_angajat`
- `SR_TESTDRIVE.id_client` → `SR_CLIENTI.id_client`
- `SR_TESTDRIVE.id_masina` → `SR_MASINI.id_masina`
- `SR_PLATI.id_vanzare` → `SR_VANZARI.id_vanzare`

### CHECK / Data Rules
- car `status` must be in `('DISPONIBILA','VANDUTA')`
- payment `suma > 0`
- car year `an_fabricatie BETWEEN 1970 AND 2025`
- `SR_CLIENTI.email` extended to `VARCHAR2(80)`

---

## Data Population (Sample Data)

Each table is populated with **10–15 rows** (project requirement), including:
- 12 customers
- 12 employees
- 12 cars
- 12 sales
- 12 test drives
- 12 payments

---

## Updates & Data Manipulation (DML)

Examples included:
- increase salary by **5%** for `Agent Vanzari`
- update payment method from `CASH` to `CARD`
- increase car prices by **10%** for cars newer than 2018
- promote a specific employee to `Manager Showroom`

---

## Table Drop & Recovery (Flashback)

The project demonstrates:
- `DROP TABLE SR_TESTDRIVE;`
- `FLASHBACK TABLE SR_TESTDRIVE TO BEFORE DROP;`

> Note: Flashback requires Oracle configuration/privileges (recycle bin enabled).

---

## Query Showcase (30+ Queries)

The SQL section includes **30+ queries** covering:
- sorting, filtering, aggregation (MIN/MAX/AVG/COUNT/SUM)
- joins (INNER, LEFT, legacy outer join)
- subqueries + correlated subqueries
- set operators: **UNION / INTERSECT / MINUS**
- conditional logic: **CASE** and **DECODE**
- string/date functions and formatting
- hierarchical query using `CONNECT BY`

Examples include:
- employees ordered by salary
- sold cars ordered by price
- sales in a date range
- customers with purchases / test drives
- unpaid balances per sale (remaining amount to pay)
- “tested but did not buy” customers (MINUS)
- hierarchical tree: Brand → Model → Car

---

## Additional Database Objects

### Views
- `v_vanzari_complete` — full sales details (customer + car + employee)
- `v_clienti_contact` — customers with complete contact data (READ ONLY)

### Indexes
- `index_metoda_plata` on `SR_PLATI(metoda_plata)`
- `index_functie` on `SR_ANGAJATI(UPPER(functie))`

### Sequence
- `seq_vanzari` — generates unique sale IDs (1000 → 9999)

### Synonym
- `clienti_showroom` as a synonym for `SR_CLIENTI`

---

## How To Run (Oracle SQL Developer)

1. Open **Oracle SQL Developer**
2. Connect to your Oracle schema/user
3. Run scripts in this order:
   1) `CREATE TABLE` statements  
   2) `ALTER TABLE` constraints (PK/FK/CHECK/MODIFY)  
   3) `INSERT` statements  
   4) `UPDATE` statements  
   5) Optional: `DROP` + `FLASHBACK` demo  
   6) Queries + views/indexes/sequence/synonym

> Tip: It’s recommended to place everything into a single `showroom.sql` file and execute it top-to-bottom.

---

## Tech Stack

- **Oracle Database**
- **Oracle SQL / PL/SQL environment**
- SQL Developer (recommended)

---

## Notes

- This is an **educational project** built for a database course.
- Constraints and query variety are designed to meet typical academic requirements.
- Some features (Flashback) depend on Oracle environment settings and privileges.

---

## Author

Auto Showroom Database — Oracle SQL Project  
Created for a university database course assignment
