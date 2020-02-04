# External Sorting or Indexing with B+ index 

In this homework, you can select between two options, (1) implementing a database external sorting algorithm, or (2) implementing a B+ tree index. Below are the details for each one of the options:

# Indexing: External Merge Sorting 

In this assignment you will implement the two-way external merge sorting algorithm which is used by
most of the relational database systems to sort large sets of data that do not fit in memory. Here are some
more specifics that your program should adhere to.

1. Use the file, age.txt, which is on ilearn as an input to your program. The file contains 1 million
numbers within the range [1,100] that are separated by commas.

2. Recall that the first pass of two-way merge sort algorithm needs 1 bu↵er, and the subsequent passes
need 3 bu↵er 2 for input data, and 1 for output data.

3. Assume that page size is 4KB.

4. Input buffers: Read-in the input data in chunks of 4KB (page size). Therefore, at any given point
your program should read-in at most 8KB (2 pages) of input data. However, you can assume a
tolerance of +/- 4bytes for each bu↵er to ensure that an entry (an age value) does not get split.

5. Output bu↵er: Holds at most 4KB of data, at which point the data is flushed out to the disk,
specifically, to an intermediate file, or to the final file in the final pass.

6. In addition to correctness, I will also grade your coding style and code readability for this assignment.
Use one of the following programming language for this assignment: Java, C++, Python, Swift,
Javascript, or PHP. You need to provide complete documentation about how to run your program. Please, name your project ExternalMergeSort, and upload to this directory the ExternalMergeSort file.

## Program Output:
* A sorted copy of the original input file
* Print out the following information in console for every pass
    * pass number ( starts at 0 ) 
    * number of bu↵ers used in this pass 
    * number of temporary files created in this pass.
    
    All this information should be printed in one line per pass separated by a comma (i.e 1, 3, 4). In this example, in pass #1, we created 3 buffers, and 4 temporary files.
    
* After your program creates the final sorted file print out the total cost ( in number of disk I/0s) in disk


## Grading Rubric:
* Correct and complete implementation of the external merge sort algorithm: 3%
* Appropriate documentation of the code, coding style and readability. If I cannot understand your
code, then your code is not good. 2%
* If I cannot run your program, you will get a 0 in this assignment. So, make sure you provide detailed instructions. I will run it from an UNIX terminal.

# B+ Tree Index 

In this assignment, you will implement a B+ tree index to perform the following operations: (1) Search, (2) Insert, and (3) Delete. 

## Program Input 

1. The order of the tree 

2. The data entries of the tree 

3. Create the new B+ tree index using the bulk load method, and print the tree. 

4. Show menu with all the operations allowed in the tree

## Program Output 

Depending on the operation selected by the user, print the following

1. Search: if the data entry was found, print the tree with the appropiate message (see example below). Otherwise, print "data entry not found".

2. Insert: Print the tree after inserting the new data entry. 

3. Delete: Print the tree after deleting the existing data entry. If the data to be deleted does not exist, print the correspondent message. 

Below you can find the input and output required for your program. Px are the pointers pointing to that node from the parent node. For example, in the first tree, 1,5(p0) means that pointer 0 from the non-leaf node 12,NULL is pointing to the leaf node 1,5. Note that pointer 0 is always the first pointer of a non-leaf node starting from the most left one.

```python
Enter order of the tree: 2
Enter data entries: 12, 32, 1, 35, 87, 24, 78, 43, 88, 5

B+ tree: 
32,NULL 
 +-- 12,NULL(p0) 
 |   +-- 1,5(p0) 
 |.  +-- 12,24(p1)
 +-- 47,87(p1)
 |   +-- 32,25(p0)
 |   +-- 47,78(p1)
 |   +-- 87,88(p2)
 
 Menu:
 
 1. Search
 2. Insert
 3. Delete 
 4. Exit
 
 Select an option from the menu: 1
 Enter the data entry: 5
 Data entry found in path: 32 --> 12(p0) --> 1,5(p0)
 
 Select an option from the menu: 2
 Enter the data entry: 89
 B+ tree: 
 32,87
 +-- 12,NULL(p0) 
 |   +-- 1,5(p0)
 |   +-- 12,24(p1)
 +-- 47,NULL(p1)
 |   +-- 32,25(p0)
 |   +-- 47,78(p1)
 +-- 89,NULL(p2)
 |   +-- 87,88(p0)
 |   +-- 89,NULL(p1)
 
 
 Select an option from the menu: 3
 Enter the data entry: 87
 B+ tree: 
 32,88
 +-- 12,NULL(p0) 
 |   +-- 1,5(p0)
 |   +-- 12,24(p1)
 +-- 47,NULL(p1)
 |   +-- 32,25(p0)
 |   +-- 47,78(p1)
 +-- 89,NULL(p2)
 |   +-- 88,NULL(p0)
 |   +-- 89,NULL(p1)
 
 Select an option from the menu: 4
 
```

## Grading Rubric:
* Correct and complete implementation of the external merge sort algorithm: 3%
* Appropriate documentation of the code, coding style and readability. If I cannot understand your
code, then your code is not good. 2%
* If I cannot run your program, you will get a 0 in this assignment. So, make sure you provide detailed instructions. I will run it from an UNIX terminal.

