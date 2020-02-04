# The Semantic-Conceptual Model 

In this homework, students will learn to design a database system from a concept based on use cases, bussines rules (database requeriments), and Entity Relation Diagrams (ERD). 

## Section I: Project Description

In this section, you will create a brief description of the idea for your database system. This is a high level description since at this point, the scope of the concept is not clear yet. For example, don´t talk about entitie´s attributes yet, just focus in the main entities. For instance, if your database systems is a library management system, books, customers .... will be your main entities. 

## Section II: Use Cases 

Based on your project description, create five use cases for all the main entities and actors in your system. Please, refer to class slides to learn about how to create good use cases for your system. Take into consideration that having good use cases will help to extract good bussines rules for your system. Use at least one of your use cases to define a possible failure in your system, and how to recover from it. For example, taking into consideration the example from section I, a good use case for that system would be:

Marie wants to rent a book from library X (X is your system´s name), the system asks Marie to register first as a prerequesite to rent the book. Marie register into the system, and then login in her account. Then, she can search for the book she wants to rent. Marie finds a good book and starts the renting process. During the process, she decides that she needs an additional book. However, the system does not let her to rent a new book until the process of renting the first one is done. 

As you can see, this is a good use case because is using three main entities, and one specific problem that our system should be able to solve with a good design. 

## Section III: Bussines Rules 

Bussines rules are database requeriments that are extracted from use cases. A good business rules contains: (1) two or more entities, (2) a rule defining a relationship between such entities, (3) all the entities must be quantifiable, and (4) an optional condition. Quantifiable entities are defined by the many, one or zero quantities. Bussines rules must be enumerated so later they are easy to find in the document. 

Example of bussines rules using our use case example: 

1. A user can create only one account. 
2. Users should be able to rent multiple books at once before checking out. 

Please try to create as many bussines rules as you can so you can use them in your ERD to improve your system. 

## Section IV: Detailed List of Main Entities, Attributes and Keys 

In this section, you must create a detailed list of the main entities and attributes in your system, including keys and attibutes details. For example using our two bussines rules from section III. A good list would be:

      1. User
          * userID: key 
          * name: composite 
          * dob: multivalue 
          * age: derived
          
      2. Book
          * ISBM: key 
          * title: composite 
          * description 
          * author: composite 
          * publisher 

      3. Account 
          * id: key 
          * user: key 
          * role: key 
      
## Section V: Entity Relationship Diagram (ERD) 

Based in your bussines rules from section III, create a ERD that will show the high level architecture of your database system. Your ERD should contain at least 16 entities with at least one of each one of the following relationships: one-to-one, many-to-one, one-to-many, many-to-many, ISA and recursive ones. Take into consideration that there may be many ways of define your system in a ERD. So, in order to do it correctly think always from the user point of view, and don´t forget to take into account non functional requeriments such as  the scalability and performance of the system.  

You are allowed to use any of the software tools avaliable to create this ERD. Drawing the ERD by hand is not recomended in this homework since your ERD may have to be modified at some point. 

## Section VI: Testing Table 

Create a testing table similar to the one below with all the relationships in your ERD, and test it as learned in class. If any of your tests fails, please fix your ERD, but do not update the test table to pass. That way, when I see that a relationship failed in your testing table, I can go back to your ERD and see how you fixed it. 

Testing table example:

| Rule | Entity A  |  Relation |  Entity B | Cardinality  | Pass/Fail  |           Error Description               |  
|------|-----------|-----------|-----------|--------------|------------|-------------------------------------------|
|  1   |   User    |  Creates  |  Account  |    1-to-1    |    Fail    |  Users must have only one account         | 
|  2   |   User    |  Rents    |  Book     |    M-to-N    |    Pass    |                None                       |



# Grading Guidelines

This homework is 10% worth of your final grade. For each incompleted section, you´ll loose 2% of your grade. If you have more than 2 missing sections, you´ll get a zero in this homework. The document with your homework must be in PDF format. Documents with a different format will be returned. Please if you do not understand or do not know how to do a section in this homework come to my office hours. I´ll be happy to help. 

# Submission Guidelines 

The due date for this homework will be announces in class, on ilearn and by email. By the due date, send an email to the class instructor jortizco@sfsu.edu with the following subject and message: 

Subject: CSC675-775-03 Database Systems: HW1

Message: Your name, student id, github username and a link pointing to your PDF document with your homework. Your homework must be located in the master branch of your class repository, and pointing to this directory. 

Failure to follow submission guidelines will result in your homework returned to you. No late submissions will be allowed. 










