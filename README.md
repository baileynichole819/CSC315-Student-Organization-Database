# Student Organization Management System

This project is a MySQL database created for CSC 382. The purpose of the database is to help manage information for a student organization, including members, events, attendance, dues payments, service opportunities, service hours, and officer positions.

## Database

The database is named `student_org_management` and was created and tested using MySQL and MySQL Workbench.

The database contains the following tables:

- Member
- Event
- Attendance
- Payment
- ServiceOpportunity
- MemberService
- OfficerPosition
- MemberOfficerPosition

## Project Files

### SQL

`sql/schema.sql`  
Creates the database tables, primary keys, foreign keys, constraints, and views.

`sql/data.sql`  
Contains sample data used to populate and test the database.

`sql/queries.sql`  
Contains SQL statements used to implement the functional requirements from Project Milestone 1.

`sql/tests.sql`  
Contains positive and negative tests used to verify database constraints and integrity.

### Diagrams

The `diagrams` folder contains the revised E-R diagram for Project Milestone 2.

## Functional Requirements

The database supports adding and updating members, creating and managing events, recording attendance, recording dues payments, checking dues status, managing service opportunities and hours, assigning officer positions, and displaying attendance and dues totals.

## Testing

The database was tested using valid and invalid data. Tests were performed for primary and foreign key relationships, unique member emails, and payment amount constraints.

## Author

Bailey Smith  
CSC 382
Louisiana State University Shreveport
