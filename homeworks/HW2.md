# The Relational Model 

The relational model represents how data is storaged in databases based in a conceptual design (ERD). In this homework you will create the database model based in your ERD. 

## Section I: Final ERD Version 

Add to this section your final version of your ERD. If your ERD still has mistakes, please fix them before adding it to the document. 

## Section II: Database Model 

Use MySQLWorkbench or any other SQL compatible database software tool to create a database model of your system using based on your conceptual model. Use the tutorial posted on iLearn if you still need help to install and configure MySQLWorkbench. Once the database model is created, take a screenshot or pic, and copy and paste it in this section. Save the database model, and upload the file to this directory. Name it databasemodel.mwb

## Section III: Forward Engineering 

Once your database model is done forward engineering your database model to create the databasemodel.sql file that contains all the CREATE SQL statements to create your database model. Copy and paste the content of this file in this section, and upload the file to this directory

## Section IV: Inserting Data 

Insert some data to test your new database model. Create a inserts.sql file and add three inserts for each entity table in your model. Copy and paste the content of your file in this section, and upload this file to this directory 

## Section V: Testing 

Create a file test.sql and create the following tests for each business rule represented in your database model. 

* A delete SQL statement  
* A update SQL statement  
* A select SQL statement 

Copy and paste all the SQL statements of test.sql file in this section, and upload this file in this directory. 

## Section VI: Testing Table 

Create a testing table similar to the one below to test all the testing statements from section V. If a tests fails, fix it, but do not update it to pass in the testing table. That way, I can go back and see what you did

| Test | Statement |  Entity   |  Pass/Fails |                    Error Description                      |    
|------|-----------|-----------|-------------|-----------------------------------------------------------|
|  1   |   Delete  |  Account  |  Fails      |   Account is referencing primary key in User table        | 
|  2   |   Update  |  User     |  Pass       |                        None                               |

# Grading Guidelines

This homework is 10% worth of your final grade. For each incompleted section, you´ll loose 2% of your grade. If you have more than 2 missing sections, you´ll get a zero in this homework. The document with your homework must be in PDF format. Documents submitted in a different format will be returned. Please if you do not understand or do not know how to do a section in this homework come to my office hours. 
I´ll be happy to help. 

# Submission Guidelines 

This homework must have the following files uploaded to this directory: 

* The PDF document with all the sections stated in this document 
* The following files uploaded in this directory: 
  * The database model file: databasemodel.mwb
  * The SQL script file with all the SQL CREATE statements: databasemodel.sql 
  * The SQL script file with all the SQL INSERT statements: inserts.sql
  * The SQL test file with all the tests: tests.sql

The due date for this homework will be announces in class, on ilearn and by email. By the due date, send an email to the class instructor jortizco@sfsu.edu with the following subject and message: 

Subject: CSC675-775-03 Database Systems: HW2

Message: Your name, student id, github username and a link pointing to your PDF document with your homework. Your homework must be located in the master branch of your class repository, and pointing to this directory. 

Failure to follow submission guidelines will result in your homework returned to you. No late submissions will be allowed. 


  




