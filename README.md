\# Student Organization Management System



This project is a MySQL database and Python application created for CSC 315. The purpose of the project is to help manage information for a student organization, including members, events, attendance, dues payments, service opportunities, service hours, and officer positions.



\## Database



The database is named `student\_org\_management` and was created and tested using MySQL and MySQL Workbench.



The database contains the following tables:



\- Member

\- Event

\- Attendance

\- Payment

\- ServiceOpportunity

\- MemberService

\- OfficerPosition

\- MemberOfficerPosition



\## Project Files



\### SQL



\- `sql/schema.sql` - Creates the database tables, primary keys, foreign keys, constraints, and views.

\- `sql/data.sql` - Contains sample data used to populate and test the database.

\- `sql/queries.sql` - Contains SQL statements used to implement the functional requirements from Project Milestone 1.

\- `sql/tests.sql` - Contains positive and negative tests used to verify database constraints and integrity.



\### Python



\- `src/main.py` - Contains the command-line menu and handles user input.

\- `src/database.py` - Connects to MySQL and contains the database operations.

\- `requirements.txt` - Lists the Python package needed to run the application.

\- `config.ini` - Stores local MySQL connection settings. This file is not uploaded to GitHub.



\### Diagrams



The revised E-R diagram for Project Milestone 2 is included in the repository.



\## Functional Requirements



The database supports adding and updating members, creating and managing events, recording attendance, recording dues payments, checking dues status, managing service opportunities and hours, assigning officer positions, and displaying attendance and dues totals.



\## PM3 - Python Database Application



For Project Milestone 3, a Python command-line application was created to interact with the MySQL database.



The application includes six menu options:



1\. Add New Member - Inserts a new member into the database.

2\. Update Member Information - Updates a member's email, phone number, and membership status.

3\. View All Members - Displays members in alphabetical order.

4\. View Event Attendance - Displays events and their attendance counts.

5\. View Service Hours - Displays the total service hours completed by each member.

6\. View Payment Summary - Displays the number of payments and total recorded payment amounts for each member.



The application uses parameterized SQL queries and includes error handling for invalid input and database errors.



\## Installation Instructions



1\. Install Python 3 and MySQL.

2\. Download the project files.

3\. Open MySQL Workbench.

4\. Run `sql/schema.sql` to create the database.

5\. Run `sql/data.sql` to insert sample records.

6\. Open PowerShell in the main project folder.

7\. Install the required Python package:



&#x20;  python -m pip install -r requirements.txt



\## Database Configuration



Create a file named `config.ini` in the main project folder.



Add the following information:



&#x20;   \[mysql]

&#x20;   host = localhost

&#x20;   port = 3306

&#x20;   user = YOUR\_MYSQL\_USERNAME

&#x20;   password = YOUR\_MYSQL\_PASSWORD

&#x20;   database = student\_org\_management



Replace the username and password with your own MySQL credentials.



The `config.ini` file should not be uploaded to GitHub because it contains private database login information.



\## Running the Application



1\. Open PowerShell.

2\. Navigate to the project's `src` folder.

3\. Run the following command:



&#x20;  python main.py



4\. Select an option from the menu.

5\. Follow the instructions displayed.

6\. Enter 0 to exit the program.



\## Testing



The database was tested using valid and invalid data. Tests were performed for primary and foreign key relationships, unique member emails, and payment amount constraints.



The Python application was also tested by:



\- Adding a new member.

\- Updating an existing member.

\- Displaying all members.

\- Displaying event attendance.

\- Displaying service hours.

\- Displaying payment summaries.

\- Entering an invalid menu option.

\- Entering a nonnumeric member ID.



The application successfully returned to the main menu after invalid input without crashing.



\## Author



Bailey Smith



CSC 315



Louisiana State University Shreveport



