# Children's Entertainment & Equipment Rental Database

A relational database management system designed for an equipment and event rental business, developed as part of the Database Systems course at ISMAT.

## Project Overview
The system models and manages the full operational lifecycle of a rental company, including customer registrations, employee assignments, equipment tracking, warehouse inventory, rental contracts, reservations, billing (invoices and receipts), and maintenance history.

## Tech Stack
* **Database Management System:** PostgreSQL
* **Languages:** SQL (DDL, DML, DQL), PL/pgSQL
* **Concepts:** Relational Data Modeling, Normalization, Integrity Constraints, Business Automation

---

## Database Architecture & Entities
The database contains 10 interconnected tables enforcing referential integrity:

* `cliente` (Customers): Contact information, address, and fiscal number (NIF).
* `funcionario` (Employees): Staff members responsible for operations and maintenance.
* `equipamentos` (Equipment): Details of event equipment, dimensions, status, and daily rental prices.
* `inventario` (Inventory): Equipment availability, quantities, warehouse locations, and stock dates.
* `aluguer` (Rentals): Rental agreements linking clients, employees, and items with dates, values, and status.
* `reserva` (Reservations): Booking schedule for equipment to avoid scheduling conflicts.
* `cartao` (Promotional Cards): Client membership cards with discounts and conditions.
* `fatura` & `recibo` (Billing): Complete invoicing and receipt tracking with VAT, totals, and payment methods.
* `mantem` (Maintenance): Repair and inspection logs with costs, dates, and assigned technicians.

---

## Automated Logic (PL/pgSQL)

### Stored Procedures / Functions
* `adicionar_equipamento()`: Automates the insertion of new equipment into the system with standardized attributes.
* `obter_receita(data_inicio, data_fim)`: Calculates the total rental revenue generated within a specified date interval using aggregation and `COALESCE`.

### Database Triggers
* `trigger_atualizar_inventario`: Automatically updates the inventory quantity (`qnt_disp - 1`) immediately after an item is rented (`AFTER INSERT ON aluguer`).
* `trigger_registar_eliminacao`: Audit log trigger that captures deleted rental records and writes timestamps and IDs into an event log table (`AFTER DELETE ON aluguer`).

---

## Business Intelligence & Queries
The project includes analytical queries covering realistic operational needs:
1. **Recent Rentals:** Identifying all clients with active rentals in the past month.
2. **Top Customer:** Ranking the most frequent customer over the past year.
3. **Real-time Availability:** Querying available items filtered by stock levels and warehouse locations.
4. **Popular Equipment:** Discovering the most rented equipment in the last six months.
5. **Maintenance Alerts:** Identifying equipment flagged for repair or service.
6. **Promotional Campaign Reach:** Measuring customer participation in loyalty card tiers.
7. **Staff Productivity:** Tracking the total volume of events handled per employee.
8. **Financial Reporting:** Calculating periodic revenue across given business cycles.

## Academic Context

This project was developed collaboratively as part of the Database Systems course at ISMAT.

### My Contribution

My contributions included database modelling, SQL query development, and testing of database functions and triggers.

## Notes
* **Language context:** As this project was developed for a Portuguese university course, database entities, column names, and internal comments are written in Portuguese. The documentation is provided in English for international review.

---

## Repository Structure
```text
├── README.md
├── sql/
│   ├── schema.sql                  # DDL: Table creation, constraints, foreign keys
│   ├── database_backup.sql         # Database backup and populated sample data
│   ├── queries.sql                 # Analytical business queries
│   └── procedures_triggers.sql # Stored functions and automated triggers
└── results/
    ├── question_1.csv                 # Exported query outputs
    ├── question_2.csv
    ├── question_3.csv
    ├── question_4.csv
    ├── question_5.csv
    ├── question_6.csv
    ├── question_7.csv
    └── question_8.csv

## Academic Context

This project was developed collaboratively as part of the Database Systems course at ISMAT.

### My Contribution

My contributions included database modelling, SQL query development, and testing of database functions and triggers.

## Notes
* **Language context:** As this project was developed for a Portuguese university course, database entities, column names, and internal comments are written in Portuguese. The documentation is provided in English for international review.