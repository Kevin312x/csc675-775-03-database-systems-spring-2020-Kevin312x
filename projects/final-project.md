# Final Course Project 

In this project, you will create a real application by using the database model you created in homework 1 and 2. Please refer to the following guidelines to complete your project. 

## Project Guidelines 

1. Using your database model, and your favorite programming language, create a functional application (console, terminal or GUI) to represent the functionality of your database model with real users. Your program must meet the following high level requeriments: 

  * Create user account: your database model can insert dynamically data entered by the user into the database 
  * Signin: your database model should read and validate user credentials entered by registered users
  * Menu: once the user is succesfully logged into the system, show a user menu with the following options: 
  
        > User Menu 
        > 1. Create Account 
        > 2. Login 
        > 3. Search
        > 4. Insert 
        > 5. Update
        > 6. Delete 
        > 7. Exit
        
  
  * Search: when user selects this option, the user must be able to search for data based on the main entities implemented in your database model. For example, if your database model was modeled for a library system, a good example of a search service in your system would be the following: 
  
        > Enter book by isbn or title: Database System Concepts
        > Database System Concepts
          Author: Avi Silberschatz
          ISBN: 87736778838
          Publisher: Parson
     
     Take into consideration that a good search functionality should be able to search data from different tables, and show the data organized in the console or terminal
          
   * Insert: the user of your program must be able to insert data from your database model like in the following example: 
   
         > Enter book title: Database System Concepts
         > Enter ISBN: 87736778838
         > Enter author: Avi Silberschatz
         > Enter publisher: Parson 
         > Info succesfully saved in database. 
   
   * Update: the user must be able to update data from your database model 
   * Delete: the user must be able to delete data from your database model
   
   Take into consideration that for update and delete options, you must update or delete all the data related in other tables. In order to make it work, you must have implemented correctly ON DELETE and ON UPDATE in all the related tables. (done in HW2)
         
## Grading Rubrics
  
   * Your program must run in a UNIX terminal, or in a Windows console. You are also free to implement this program using GUI. 
   * If your program does not run, then you´ll get a zero in the project 
   * You must provide clear and complete documentation about how to run your program. If you do not provide docs, you´ll be penalized with 3% of the final grade in this assignment. 
   * If I cannot understand your code, then your code is not good, and you´ll be penalized with 3% of the final grade in this assignment 
   * This assignment is 10% worth of your final grade, for each option that is not implemented, you´ll loose 2%.  
   
## Submission Guidelines 
   * By the due date of this assignment, send an email to the class instructor jortizco@sfsu.edu with the link to your source code in this directory. Don´t forget to add the documentation of your program, including intructions about how to run your program. Late submissions won´t be accepted. 
        
