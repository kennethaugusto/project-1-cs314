0. 
- Sarah Choi (ssc185), Nirad Shah (ns1361), Kenneth Augusto (kma234)

1. 
- known issues / functions that aren't working and explain

2. 
- Collaborated with Nirad and Kenneth. 
- In order to copy the csv into the table, we referenced the following site: https://www.postgresqltutorial.com/postgresql-tutorial/import-csv-file-into-posgresql-table/. We used this to understand the basic procedure and then we designed our own table to copy it into. (We labeled columns and assigned what we believed to be appropriate variable types for each column). 
- To learn how to create new primary keys (not specified in csv) we referenced: https://neon.tech/postgresql/postgresql-tutorial/postgresql-primary-key
- Sarah did preliminary.sql, made the create table statements

3. 
- What is the minimum information would you need to collect from a user to allow
them to submit a mortgage application? What types of (multiple choice) questions
would you ask? Which columns do you think are genrated by the bank vs collected
from the user?


4. (problems, how long)
When using the COPY function to import the data from the csv file into the table, we had a syntax error for the INTEGER columns because any empty cell ('') was considered a string, not a null cell. To fix this, I looked at the COPY documentation (https://www.postgresql.org/docs/17/sql-copy.html) and found the FORCE_NULL and NULL sections to make any empty cells into the NULL datatype for the INTEGER columns.
We weren't sure how to create a new unique primary key for applicant_id for example. When we looked it up, we found the option to include SERIAL to generate a unique integer id: https://neon.tech/postgresql/postgresql-tutorial/postgresql-primary-key