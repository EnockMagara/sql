-- Create a Table

-- This statement creates a table named 'employees' with five columns: employee_id, first_name, last_name, email, and hire_date.
CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    hire_date DATE
);

-- Insert Data
-- This statement inserts five rows of data into the 'employees' table.
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date)
VALUES (1, 'John', 'Smith', 'john@example.com', '2022-01-01'),
       (2, 'Jane', 'Doe', 'jane@example.com', '2022-02-01'),
       (3, 'Bob', 'Johnson', 'bob@example.com', '2022-03-01'),
       (4, 'Alice', 'Brown', 'alice@example.com', '2022-04-01'),
       (5, 'Charlie', 'Davis', 'charlie@example.com', '2022-05-01');

-- Select Query
-- This statement selects all columns and rows from the 'employees' table.
SELECT * FROM employees;

-- Where Clause
-- This statement selects all columns from the 'employees' table where the last_name is 'Smith'.
SELECT * FROM employees WHERE last_name = 'Smith';

-- Update Statement
-- This statement updates the email of the employee with employee_id 3 to 'newemail@example.com'.
UPDATE employees SET email = 'newemail@example.com' WHERE employee_id = 3;

-- Delete Statement
-- This statement deletes the row from the 'employees' table where the employee_id is 5.
DELETE FROM employees WHERE employee_id = 5;

-- Order By
-- This statement selects all columns from the 'employees' table and orders the result by hire_date in descending order.
SELECT * FROM employees ORDER BY hire_date DESC;

-- Join Tables
-- This statement creates a table named 'departments' with two columns: dept_id and dept_name.
CREATE TABLE departments (
    dept_id INT,
    dept_name VARCHAR(50)
);

-- This statement selects all columns from the 'employees' and 'departments' tables where the employee_id matches the dept_id.
SELECT * FROM employees JOIN departments ON employees.employee_id = departments.dept_id;

-- Aggregate Functions
-- This statement counts the total number of rows in the 'employees' table.
SELECT COUNT(*) FROM employees;

-- Group By
-- This statement groups the rows in the 'employees' table by dept_id and counts the number of rows in each group.
SELECT dept_id, COUNT(*) FROM employees GROUP BY dept_id;

-- Having Clause
-- This statement groups the rows in the 'employees' table by dept_id, counts the number of rows in each group, and filters the groups to include only those with more than 2 rows.
SELECT dept_id, COUNT(*) FROM employees GROUP BY dept_id HAVING COUNT(*) > 2;

-- Subquery
-- This statement selects all columns from the 'employees' table where the hire_date is greater than the average hire_date of all employees.
SELECT * FROM employees WHERE hire_date > (SELECT AVG(hire_date) FROM employees);

-- Alter Table
-- This statement adds a new column named 'salary' to the 'employees' table with a decimal data type.
ALTER TABLE employees ADD COLUMN salary DECIMAL(10, 2);

-- Foreign Key Constraint
-- This statement adds a foreign key constraint to the 'employees' table, linking the dept_id to the dept_id in the 'departments' table.
ALTER TABLE employees ADD CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Create View
-- This statement creates a view named 'employee_details' that selects employee_id, first_name, last_name, and dept_name from the 'employees' and 'departments' tables.
CREATE VIEW employee_details AS
SELECT employee_id, first_name, last_name, dept_name
FROM employees
JOIN departments ON employees.dept_id = departments.dept_id;




-- Exercise 1: Renaming Attributes
-- Question: Write a query to select the instructor_name and course_id from the 'instructor' and 'teaches' tables, renaming 'name' to instructor_name
-- Answer:
-- This query selects the 'name' column from the 'instructor' table and renames it to 'instructor_name'.
-- It also selects the 'course_id' column from the 'teaches' table.
-- The query joins the 'instructor' and 'teaches' tables on the 'ID' column.
SELECT name AS instructor_name, course_id
FROM instructor, teaches
WHERE instructor.ID = teaches.ID;
-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
-- | 2  | Jane Doe   |
-- 
-- And the following data in the 'teaches' table:
-- | ID | course_id |
-- |----|-----------|
-- | 1  | CS101     |
-- | 2  | CS102     |
-- 
-- The result of the query will be:
-- | instructor_name | course_id |
-- |-----------------|-----------|
-- | John Smith      | CS101     |
-- | Jane Doe        | CS102     |




-- Exercise 2: Renaming Relations
-- Question: Write a query to find the names of all instructors whose salary is greater than at least one instructor in the Biology department.
-- Answer:
-- This query selects the distinct names of instructors (T) whose salary is greater than at least one instructor (S) in the Biology department.
-- The 'instructor' table is aliased as 'T' and 'S' to compare salaries within the same table.
-- The WHERE clause ensures that the salary of instructor T is greater than the salary of instructor S and that instructor S is in the Biology department.
SELECT DISTINCT T.name
FROM instructor AS T, instructor AS S
WHERE T.salary > S.salary AND S.dept_name = 'Biology';


-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary | dept_name |
-- |----|------------|--------|-----------|
-- | 1  | John Smith | 90000  | Physics   |
-- | 2  | Jane Doe   | 80000  | Biology   |
-- | 3  | Alice Brown| 85000  | Chemistry |
-- | 4  | Bob White  | 75000  | Biology   |
-- 
-- The query will compare the salaries of all instructors with those in the Biology department.
-- John Smith (90000) has a salary greater than Jane Doe (80000) and Bob White (75000).
-- Alice Brown (85000) has a salary greater than Bob White (75000).
-- Therefore, the result of the query will be:
-- | name        |
-- |-------------|
-- | John Smith  |
-- | Alice Brown |




-- Exercise 3: Using Correlation Names
-- Question: Write a query to find the names of all instructors who earn more than the lowest salary in the Biology department.
-- Answer:
-- This query selects the names of instructors (T) whose salary is greater than the lowest salary of any instructor (S) in the Biology department.
-- The 'instructor' table is aliased as 'T' for the main query and 'S' for the subquery.
-- The subquery finds the minimum salary of instructors in the Biology department.
-- The WHERE clause in the main query ensures that the salary of instructor T is greater than this minimum salary.
SELECT T.name
FROM instructor AS T
WHERE T.salary > (SELECT MIN(S.salary) FROM instructor AS S WHERE S.dept_name = 'Biology');

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary | dept_name |
-- |----|------------|--------|-----------|
-- | 1  | John Smith | 90000  | Physics   |
-- | 2  | Jane Doe   | 80000  | Biology   |
-- | 3  | Alice Brown| 85000  | Chemistry |
-- | 4  | Bob White  | 75000  | Biology   |
-- 
-- The subquery will find the minimum salary in the Biology department, which is 75000 (Bob White).
-- The main query will then compare the salaries of all instructors with this minimum salary.
-- John Smith (90000) has a salary greater than 75000.
-- Alice Brown (85000) has a salary greater than 75000.
-- Therefore, the result of the query will be:
-- | name        |
-- |-------------|
-- | John Smith  |
-- | Alice Brown |



-- Exercise 1: Using String Functions
-- Question: Write a query to find the names of all departments whose building name includes the substring 'Watson' and convert the department names to uppercase.
-- Answer:
-- This query selects the names of departments whose building name includes the substring 'Watson'.
-- The 'department' table is used for this query.
-- The WHERE clause uses the LIKE operator to find buildings with 'Watson' in their name.
-- The SELECT clause uses the UPPER function to convert the department names to uppercase.
SELECT UPPER(dept_name)
FROM department
WHERE building LIKE '%Watson%';

-- Example:
-- Suppose we have the following data in the 'department' table:
-- | dept_name       | building       |
-- |-----------------|----------------|
-- | Computer Science| Watson Hall    |
-- | Biology         | Watson Annex   |
-- | Chemistry       | Smith Hall     |
-- 
-- The query will find the departments with buildings 'Watson Hall' and 'Watson Annex'.
-- The result of the query will be:
-- | UPPER(dept_name) |
-- |------------------|
-- | COMPUTER SCIENCE |
-- | BIOLOGY          |


-- Exercise 2: Using Pattern Matching
-- Question: Write a query to find the names of all instructors whose names start with 'A' and have exactly 10 characters.
-- Answer:
-- This query selects the names of instructors whose names start with 'A' and have exactly 10 characters.
-- The 'instructor' table is used for this query.
-- The WHERE clause uses the LIKE operator to find names that start with 'A' and have exactly 10 characters.
SELECT name
FROM instructor
WHERE name LIKE 'A_________';

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name        | salary | dept_name |
-- |----|-------------|--------|-----------|
-- | 1  | Alice Brown | 85000  | Chemistry |
-- | 2  | Alan Smith  | 90000  | Physics   |
-- | 3  | Bob White   | 75000  | Biology   |
-- 
-- The query will find the instructor with the name 'Alice Brown'.
-- The result of the query will be:
-- | name        |
-- |-------------|
-- | Alice Brown |


-- Exercise 3: Using String Concatenation
-- Question: Write a query to concatenate the first name and last name of all instructors, separated by a space.
-- Answer:
-- This query selects the concatenated first name and last name of instructors, separated by a space.
-- The 'instructor' table is used for this query.
-- The SELECT clause uses the concatenation operator (||) to combine the first name and last name with a space in between.
SELECT first_name || ' ' || last_name AS full_name
FROM instructor;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | first_name | last_name | salary | dept_name |
-- |----|------------|-----------|--------|-----------|
-- | 1  | John       | Smith     | 90000  | Physics   |
-- | 2  | Jane       | Doe       | 80000  | Biology   |
-- | 3  | Alice      | Brown     | 85000  | Chemistry |
-- 
-- The query will concatenate the first name and last name of each instructor.
-- The result of the query will be:
-- | full_name   |
-- |-------------|
-- | John Smith  |
-- | Jane Doe    |
-- | Alice Brown |


-- Exercise 1: Selecting All Attributes
-- Question: Write a query to select all attributes of instructors.
-- Answer:
-- This query selects all attributes of the 'instructor' table.
-- The asterisk (*) symbol is used in the SELECT clause to denote all attributes.
SELECT *
FROM instructor;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name        | salary | dept_name |
-- |----|-------------|--------|-----------|
-- | 1  | Alice Brown | 85000  | Chemistry |
-- | 2  | Alan Smith  | 90000  | Physics   |
-- | 3  | Bob White   | 75000  | Biology   |
-- 
-- The query will select all attributes of each instructor.
-- The result of the query will be:
-- | ID | name        | salary | dept_name |
-- |----|-------------|--------|-----------|
-- | 1  | Alice Brown | 85000  | Chemistry |
-- | 2  | Alan Smith  | 90000  | Physics   |
-- | 3  | Bob White   | 75000  | Biology   |

-- Exercise 2: Ordering by Single Attribute
-- Question: Write a query to list all instructors in the Physics department in alphabetical order.
-- Answer:
-- This query selects the names of instructors in the Physics department and orders them alphabetically.
-- The WHERE clause filters instructors by the 'Physics' department.
-- The ORDER BY clause sorts the results by the 'name' attribute in ascending order.
SELECT name
FROM instructor
WHERE dept_name = 'Physics'
ORDER BY name;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name        | salary | dept_name |
-- |----|-------------|--------|-----------|
-- | 1  | Alan Smith  | 90000  | Physics   |
-- | 2  | John Doe    | 85000  | Physics   |
-- | 3  | Jane Roe    | 80000  | Biology   |
-- 
-- The query will list the instructors in the Physics department in alphabetical order.
-- The result of the query will be:
-- | name       |
-- |------------|
-- | Alan Smith |
-- | John Doe   |

-- Exercise 3: Ordering by Multiple Attributes
-- Question: Write a query to list all instructors ordered by salary in descending order and by name in ascending order.
-- Answer:
-- This query selects all attributes of the 'instructor' table.
-- The ORDER BY clause sorts the results by the 'salary' attribute in descending order and by the 'name' attribute in ascending order.
SELECT *
FROM instructor
ORDER BY salary DESC, name ASC;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name        | salary | dept_name |
-- |----|-------------|--------|-----------|
-- | 1  | Alan Smith  | 90000  | Physics   |
-- | 2  | John Doe    | 85000  | Physics   |
-- | 3  | Jane Roe    | 80000  | Biology   |
-- 
-- The query will list the instructors ordered by salary in descending order and by name in ascending order.
-- The result of the query will be:
-- | ID | name        | salary | dept_name |
-- |----|-------------|--------|-----------|
-- | 1  | Alan Smith  | 90000  | Physics   |
-- | 2  | John Doe    | 85000  | Physics   |
-- | 3  | Jane Roe    | 80000  | Biology   |

-- Exercise 4: Using BETWEEN Operator
-- Question: Write a query to find the names of instructors with salary amounts between $90,000 and $100,000.
-- Answer:
-- This query selects the names of instructors whose salary is between $90,000 and $100,000.
-- The WHERE clause uses the BETWEEN operator to filter the salary range.
SELECT name
FROM instructor
WHERE salary BETWEEN 90000 AND 100000;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name        | salary | dept_name |
-- |----|-------------|--------|-----------|
-- | 1  | Alan Smith  | 90000  | Physics   |
-- | 2  | John Doe    | 95000  | Physics   |
-- | 3  | Jane Roe    | 80000  | Biology   |
-- 
-- The query will find the instructors with salary amounts between $90,000 and $100,000.
-- The result of the query will be:
-- | name       |
-- |------------|
-- | Alan Smith |
-- | John Doe   |

-- Exercise 5: Using Tuple Comparison
-- Question: Write a query to find the names and course IDs of instructors in the Biology department who have taught some course.
-- Answer:
-- This query selects the names and course IDs of instructors in the Biology department who have taught some course.
-- The WHERE clause uses a tuple comparison to filter instructors by department and course taught.
SELECT name, course_id
FROM instructor, teaches
WHERE (instructor.ID, dept_name) = (teaches.ID, 'Biology');

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name        | dept_name |
-- |----|-------------|-----------|
-- | 1  | Alice Brown | Biology   |
-- | 2  | Bob White   | Biology   |
-- | 3  | John Doe    | Physics   |
-- 
-- And the following data in the 'teaches' table:
-- | ID | course_id |
-- |----|-----------|
-- | 1  | BIO-101   |
-- | 2  | BIO-102   |
-- | 3  | PHY-101   |
-- 
-- The query will find the names and course IDs of instructors in the Biology department who have taught some course.
-- The result of the query will be:
-- | name        | course_id |
-- |-------------|-----------|
-- | Alice Brown | BIO-101   |
-- | Bob White   | BIO-102   |



-- Exercise 6: Using Union
-- Question: Write a query to find the set of all courses taught either in Fall 2009 or in Spring 2010, or both.
-- Answer:
-- This query selects the course IDs of all courses taught in Fall 2009 and Spring 2010.
-- The UNION operation combines the results of the two SELECT statements and eliminates duplicates.
SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009
UNION
SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = 2010;

-- Example:
-- Suppose we have the following data in the 'section' table:
-- | course_id | semester | year |
-- |-----------|----------|------|
-- | CS-101    | Fall     | 2009 |
-- | CS-315    | Fall     | 2009 |
-- | CS-319    | Spring   | 2010 |
-- | CS-319    | Spring   | 2010 |
-- | FIN-201   | Spring   | 2010 |
-- 
-- The query will find the set of all courses taught either in Fall 2009 or in Spring 2010, or both.
-- The result of the query will be:
-- | course_id |
-- |-----------|
-- | CS-101    |
-- | CS-315    |
-- | CS-319    |
-- | FIN-201   |


-- Exercise 7: Using Union All
-- Question: Write a query to find the set of all courses taught either in Fall 2009 or in Spring 2010, including duplicates.
-- Answer:
-- This query selects the course IDs of all courses taught in Fall 2009 and Spring 2010.
-- The UNION ALL operation combines the results of the two SELECT statements and retains duplicates.
SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009
UNION ALL
SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = 2010;

-- Example:
-- Suppose we have the following data in the 'section' table:
-- | course_id | semester | year |
-- |-----------|----------|------|
-- | CS-101    | Fall     | 2009 |
-- | CS-315    | Fall     | 2009 |
-- | CS-319    | Spring   | 2010 |
-- | CS-319    | Spring   | 2010 |
-- | FIN-201   | Spring   | 2010 |
-- 
-- The query will find the set of all courses taught either in Fall 2009 or in Spring 2010, including duplicates.
-- The result of the query will be:
-- | course_id |
-- |-----------|
-- | CS-101    |
-- | CS-315    |
-- | CS-319    |
-- | CS-319    |
-- | FIN-201   |


-- Exercise 8: Using Intersect
-- Question: Write a query to find the set of all courses taught in both Fall 2009 and Spring 2010.
-- Answer:
-- This query selects the course IDs of all courses taught in both Fall 2009 and Spring 2010.
-- The INTERSECT operation finds the common results between the two SELECT statements and eliminates duplicates.
SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009
INTERSECT
SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = 2010;

-- Example:
-- Suppose we have the following data in the 'section' table:
-- | course_id | semester | year |
-- |-----------|----------|------|
-- | CS-101    | Fall     | 2009 |
-- | CS-315    | Fall     | 2009 |
-- | CS-319    | Spring   | 2010 |
-- | CS-319    | Spring   | 2010 |
-- | FIN-201   | Spring   | 2010 |
-- 
-- The query will find the set of all courses taught in both Fall 2009 and Spring 2010.
-- The result of the query will be:
-- | course_id |
-- |-----------|
-- | CS-101    |


-- Exercise 9: Using Intersect All
-- Question: Write a query to find the set of all courses taught in both Fall 2009 and Spring 2010, including duplicates.
-- Answer:
-- This query selects the course IDs of all courses taught in both Fall 2009 and Spring 2010.
-- The INTERSECT ALL operation finds the common results between the two SELECT statements and retains duplicates.
SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009
INTERSECT ALL
SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = 2010;

-- Example:
-- Suppose we have the following data in the 'section' table:
-- | course_id | semester | year |
-- |-----------|----------|------|
-- | CS-101    | Fall     | 2009 |
-- | CS-315    | Fall     | 2009 |
-- | CS-319    | Spring   | 2010 |
-- | CS-319    | Spring   | 2010 |
-- | FIN-201   | Spring   | 2010 |
-- 
-- The query will find the set of all courses taught in both Fall 2009 and Spring 2010, including duplicates.
-- The result of the query will be:
-- | course_id |
-- |-----------|
-- | CS-101    |


-- Exercise 10: Using Except
-- Question: Write a query to find the set of all courses taught in Fall 2009 but not in Spring 2010.
-- Answer:
-- This query selects the course IDs of all courses taught in Fall 2009 but not in Spring 2010.
-- The EXCEPT operation finds the results in the first SELECT statement that are not in the second SELECT statement and eliminates duplicates.
SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009
EXCEPT
SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = 2010;

-- Example:
-- Suppose we have the following data in the 'section' table:
-- | course_id | semester | year |
-- |-----------|----------|------|
-- | CS-101    | Fall     | 2009 |
-- | CS-315    | Fall     | 2009 |
-- | CS-319    | Spring   | 2010 |
-- | CS-319    | Spring   | 2010 |
-- | FIN-201   | Spring   | 2010 |
-- 
-- The query will find the set of all courses taught in Fall 2009 but not in Spring 2010.
-- The result of the query will be:
-- | course_id |
-- |-----------|
-- | CS-315    |


-- Exercise 11: Handling Null Values in Arithmetic Operations
-- Question: Write a query to find the names and salaries of all instructors, and add 5000 to their salary. If the salary is null, the result should also be null.
-- Answer:
-- This query selects the names and salaries of all instructors.
-- It adds 5000 to the salary of each instructor.
-- If the salary is null, the result of the addition will also be null.
SELECT name, salary + 5000 AS adjusted_salary
FROM instructor;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 90000  |
-- | 2  | Jane Doe   | null   |
-- 
-- The result of the query will be:
-- | name       | adjusted_salary |
-- |------------|-----------------|
-- | John Smith | 95000           |
-- | Jane Doe   | null            |


-- Exercise 12: Handling Null Values in Comparison Operations
-- Question: Write a query to find the names of all instructors whose salary is not null and greater than 80000.
-- Answer:
-- This query selects the names of instructors whose salary is not null and greater than 80000.
-- The WHERE clause uses the IS NOT NULL predicate to filter out rows with null salaries.
-- It also checks if the salary is greater than 80000.
SELECT name
FROM instructor
WHERE salary IS NOT NULL AND salary > 80000;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 90000  |
-- | 2  | Jane Doe   | null   |
-- | 3  | Alice Brown| 85000  |
-- | 4  | Bob White  | 75000  |
-- 
-- The result of the query will be:
-- | name        |
-- |-------------|
-- | John Smith  |
-- | Alice Brown |


-- Exercise 13: Handling Null Values in Set Operations
-- Question: Write a query to find the distinct names of all instructors, including those with null salaries.
-- Answer:
-- This query selects the distinct names of all instructors.
-- The DISTINCT clause ensures that duplicate names are eliminated.
-- Instructors with null salaries are included in the result.
SELECT DISTINCT name
FROM instructor;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 90000  |
-- | 2  | Jane Doe   | null   |
-- | 3  | Alice Brown| 85000  |
-- | 4  | Bob White  | 75000  |
-- | 5  | Jane Doe   | null   |
-- 
-- The result of the query will be:
-- | name        |
-- |-------------|
-- | John Smith  |
-- | Jane Doe    |
-- | Alice Brown |
-- | Bob White   |


-- Exercise 14: Average Salary
-- Question: Write a query to find the average salary of instructors in the Computer Science department.
-- Answer:
-- This query selects the average salary of instructors in the Computer Science department.
-- The 'instructor' table is used for this query.
-- The WHERE clause filters the rows to include only those in the Computer Science department.
-- The SELECT clause uses the AVG function to calculate the average salary.
SELECT AVG(salary) AS avg_salary
FROM instructor
WHERE dept_name = 'Comp. Sci.';

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary | dept_name  |
-- |----|------------|--------|------------|
-- | 1  | John Smith | 75000  | Comp. Sci. |
-- | 2  | Jane Doe   | 65000  | Comp. Sci. |
-- | 3  | Alice Brown| 92000  | Comp. Sci. |
-- 
-- The result of the query will be:
-- | avg_salary |
-- |------------|
-- | 77333.33   |


-- Exercise 15: Total Number of Instructors
-- Question: Write a query to find the total number of instructors who teach a course in the Spring 2010 semester.
-- Answer:
-- This query selects the total number of distinct instructors who teach a course in the Spring 2010 semester.
-- The 'teaches' table is used for this query.
-- The WHERE clause filters the rows to include only those in the Spring 2010 semester.
-- The SELECT clause uses the COUNT function with the DISTINCT keyword to count the unique instructor IDs.
SELECT COUNT(DISTINCT ID) AS total_instructors
FROM teaches
WHERE semester = 'Spring' AND year = 2010;

-- Example:
-- Suppose we have the following data in the 'teaches' table:
-- | ID | course_id | semester | year |
-- |----|-----------|----------|------|
-- | 1  | CS101     | Spring   | 2010 |
-- | 2  | CS102     | Spring   | 2010 |
-- | 1  | CS103     | Spring   | 2010 |
-- 
-- The result of the query will be:
-- | total_instructors |
-- |-------------------|
-- | 2                 |


-- Exercise 16: Average Salary in Each Department
-- Question: Write a query to find the average salary in each department.
-- Answer:
-- This query selects the average salary of instructors in each department.
-- The 'instructor' table is used for this query.
-- The GROUP BY clause groups the rows by department name.
-- The SELECT clause uses the AVG function to calculate the average salary for each group.
SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary | dept_name  |
-- |----|------------|--------|------------|
-- | 1  | John Smith | 75000  | Comp. Sci. |
-- | 2  | Jane Doe   | 65000  | Comp. Sci. |
-- | 3  | Alice Brown| 92000  | Comp. Sci. |
-- | 4  | Bob White  | 72000  | Biology    |
-- 
-- The result of the query will be:
-- | dept_name  | avg_salary |
-- |------------|------------|
-- | Comp. Sci. | 77333.33   |
-- | Biology    | 72000      |


-- Exercise 17: Number of Instructors in Each Department
-- Question: Write a query to find the number of instructors in each department who teach a course in the Spring 2010 semester.
-- Answer:
-- This query selects the number of distinct instructors in each department who teach a course in the Spring 2010 semester.
-- The 'instructor' and 'teaches' tables are used for this query.
-- The WHERE clause filters the rows to include only those in the Spring 2010 semester.
-- The GROUP BY clause groups the rows by department name.
-- The SELECT clause uses the COUNT function with the DISTINCT keyword to count the unique instructor IDs for each group.
SELECT dept_name, COUNT(DISTINCT instructor.ID) AS instr_count
FROM instructor
NATURAL JOIN teaches
WHERE semester = 'Spring' AND year = 2010
GROUP BY dept_name;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | dept_name  |
-- |----|------------|------------|
-- | 1  | John Smith | Comp. Sci. |
-- | 2  | Jane Doe   | Comp. Sci. |
-- | 3  | Alice Brown| Comp. Sci. |
-- 
-- And the following data in the 'teaches' table:
-- | ID | course_id | semester | year |
-- |----|-----------|----------|------|
-- | 1  | CS101     | Spring   | 2010 |
-- | 2  | CS102     | Spring   | 2010 |
-- | 1  | CS103     | Spring   | 2010 |
-- 
-- The result of the query will be:
-- | dept_name  | instr_count |
-- |------------|-------------|
-- | Comp. Sci. | 2           |


-- Exercise 18: Departments with Average Salary Greater Than $42,000
-- Question: Write a query to find the average salary of instructors in those departments where the average salary is more than $42,000.
-- Answer:
-- This query selects the department name and the average salary of instructors in each department.
-- The 'instructor' table is used for this query.
-- The GROUP BY clause groups the rows by department name.
-- The HAVING clause filters the groups to include only those with an average salary greater than $42,000.
SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 42000;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary | dept_name  |
-- |----|------------|--------|------------|
-- | 1  | John Smith | 75000  | Comp. Sci. |
-- | 2  | Jane Doe   | 65000  | Comp. Sci. |
-- | 3  | Alice Brown| 92000  | Comp. Sci. |
-- | 4  | Bob White  | 72000  | Biology    |
-- 
-- The result of the query will be:
-- | dept_name  | avg_salary |
-- |------------|------------|
-- | Comp. Sci. | 77333.33   |
-- | Biology    | 72000      |


-- Exercise 19: Average Total Credits for Course Sections in 2009
-- Question: Write a query to find the average total credits of all students enrolled in each course section offered in 2009, if the section had at least 2 students.
-- Answer:
-- This query selects the course ID, semester, year, section ID, and the average total credits of students enrolled in each course section offered in 2009.
-- The 'takes' and 'student' tables are used for this query.
-- The WHERE clause filters the rows to include only those in the year 2009.
-- The GROUP BY clause groups the rows by course ID, semester, year, and section ID.
-- The HAVING clause filters the groups to include only those with at least 2 students.
SELECT course_id, semester, year, sec_id, AVG(tot_cred)
FROM takes NATURAL JOIN student
WHERE year = 2009
GROUP BY course_id, semester, year, sec_id
HAVING COUNT(ID) >= 2;

-- Example:
-- Suppose we have the following data in the 'takes' table:
-- | ID | course_id | sec_id | semester | year |
-- |----|-----------|--------|----------|------|
-- | 1  | CS101     | 1      | Spring   | 2009 |
-- | 2  | CS101     | 1      | Spring   | 2009 |
-- | 3  | CS102     | 1      | Spring   | 2009 |
-- 
-- And the following data in the 'student' table:
-- | ID | tot_cred |
-- |----|----------|
-- | 1  | 30       |
-- | 2  | 40       |
-- | 3  | 50       |
-- 
-- The result of the query will be:
-- | course_id | semester | year | sec_id | avg(tot_cred) |
-- |-----------|----------|------|--------|---------------|
-- | CS101     | Spring   | 2009 | 1      | 35            |


-- Exercise 20: Departments with More Than 3 Instructors
-- Question: Write a query to find the names of departments that have more than 3 instructors.
-- Answer:
-- This query selects the department name and the count of instructors in each department.
-- The 'instructor' table is used for this query.
-- The GROUP BY clause groups the rows by department name.
-- The HAVING clause filters the groups to include only those with more than 3 instructors.
SELECT dept_name, COUNT(*) AS num_instructors
FROM instructor
GROUP BY dept_name
HAVING COUNT(*) > 3;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | dept_name  |
-- |----|------------|------------|
-- | 1  | John Smith | Comp. Sci. |
-- | 2  | Jane Doe   | Comp. Sci. |
-- | 3  | Alice Brown| Comp. Sci. |
-- | 4  | Bob White  | Comp. Sci. |
-- | 5  | Charlie Black | Biology |
-- 
-- The result of the query will be:
-- | dept_name  | num_instructors |
-- |------------|-----------------|
-- | Comp. Sci. | 4               |



-- Exercise 21: Set Membership with IN
-- Question: Write a query to find all courses taught in both the Fall 2009 and Spring 2010 semesters.
-- Answer:
-- This query selects distinct course IDs from the 'section' table where the semester is 'Fall' and the year is 2009.
-- It uses a nested subquery to find courses taught in the Spring 2010 semester.
-- The outer query checks if the course ID is in the set of course IDs from the subquery.
SELECT DISTINCT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009 AND
      course_id IN (SELECT course_id
                    FROM section
                    WHERE semester = 'Spring' AND year = 2010);

-- Example:
-- Suppose we have the following data in the 'section' table:
-- | course_id | semester | year  |
-- |-----------|----------|-------|
-- | CS101     | Fall     | 2009  |
-- | CS102     | Fall     | 2009  |
-- | CS101     | Spring   | 2010  |
-- | CS103     | Spring   | 2010  |
-- 
-- The subquery will find the course IDs taught in Spring 2010: CS101 and CS103.
-- The outer query will then find the course IDs taught in Fall 2009 that are also in the subquery result.
-- Therefore, the result of the query will be:
-- | course_id |
-- |-----------|
-- | CS101     |


-- Exercise 22: Set Membership with NOT IN
-- Question: Write a query to find all courses taught in the Fall 2009 semester but not in the Spring 2010 semester.
-- Answer:
-- This query selects distinct course IDs from the 'section' table where the semester is 'Fall' and the year is 2009.
-- It uses a nested subquery to find courses taught in the Spring 2010 semester.
-- The outer query checks if the course ID is not in the set of course IDs from the subquery.
SELECT DISTINCT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009 AND
      course_id NOT IN (SELECT course_id
                        FROM section
                        WHERE semester = 'Spring' AND year = 2010);

-- Example:
-- Suppose we have the following data in the 'section' table:
-- | course_id | semester | year  |
-- |-----------|----------|-------|
-- | CS101     | Fall     | 2009  |
-- | CS102     | Fall     | 2009  |
-- | CS101     | Spring   | 2010  |
-- | CS103     | Spring   | 2010  |
-- 
-- The subquery will find the course IDs taught in Spring 2010: CS101 and CS103.
-- The outer query will then find the course IDs taught in Fall 2009 that are not in the subquery result.
-- Therefore, the result of the query will be:
-- | course_id |
-- |-----------|
-- | CS102     |


-- Exercise 23: Set Comparison with SOME
-- Question: Write a query to find the names of all instructors whose salary is greater than at least one instructor in the Biology department.
-- Answer:
-- This query selects the names of instructors from the 'instructor' table.
-- It uses a nested subquery to find the salaries of instructors in the Biology department.
-- The outer query checks if the salary is greater than some of the salaries from the subquery.
SELECT name
FROM instructor
WHERE salary > SOME (SELECT salary
                     FROM instructor
                     WHERE dept_name = 'Biology');

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | name       | salary | dept_name |
-- |------------|--------|-----------|
-- | John Smith | 90000  | Physics   |
-- | Jane Doe   | 80000  | Biology   |
-- | Alice Brown| 85000  | Chemistry |
-- | Bob White  | 75000  | Biology   |
-- 
-- The subquery will find the salaries of instructors in the Biology department: 80000 and 75000.
-- The outer query will then find the names of instructors whose salary is greater than at least one of these salaries.
-- Therefore, the result of the query will be:
-- | name        |
-- |-------------|
-- | John Smith  |
-- | Alice Brown |


-- Exercise 24: Set Comparison with ALL
-- Question: Write a query to find the names of all instructors whose salary is greater than all instructors in the Biology department.
-- Answer:
-- This query selects the names of instructors from the 'instructor' table.
-- It uses a nested subquery to find the salaries of instructors in the Biology department.
-- The outer query checks if the salary is greater than all of the salaries from the subquery.
SELECT name
FROM instructor
WHERE salary > ALL (SELECT salary
                    FROM instructor
                    WHERE dept_name = 'Biology');

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | name       | salary | dept_name |
-- |------------|--------|-----------|
-- | John Smith | 90000  | Physics   |
-- | Jane Doe   | 80000  | Biology   |
-- | Alice Brown| 85000  | Chemistry |
-- | Bob White  | 75000  | Biology   |
-- 
-- The subquery will find the salaries of instructors in the Biology department: 80000 and 75000.
-- The outer query will then find the names of instructors whose salary is greater than all of these salaries.
-- Therefore, the result of the query will be:
-- | name        |
-- |-------------|
-- | John Smith  |


-- Exercise 25: Test for Empty Relations with EXISTS
-- Question: Write a query to find all courses taught in both the Fall 2009 and Spring 2010 semesters using EXISTS.
-- Answer:
-- This query selects course IDs from the 'section' table where the semester is 'Fall' and the year is 2009.
-- It uses a nested subquery with EXISTS to check if the course is also taught in the Spring 2010 semester.
SELECT course_id
FROM section AS S
WHERE semester = 'Fall' AND year = 2009 AND
      EXISTS (SELECT *
              FROM section AS T
              WHERE semester = 'Spring' AND year = 2010 AND
                    S.course_id = T.course_id);

-- Example:
-- Suppose we have the following data in the 'section' table:
-- | course_id | semester | year  |
-- |-----------|----------|-------|
-- | CS101     | Fall     | 2009  |
-- | CS102     | Fall     | 2009  |
-- | CS101     | Spring   | 2010  |
-- | CS103     | Spring   | 2010  |
-- 
-- The subquery will check if each course ID from Fall 2009 is also present in Spring 2010.
-- The outer query will then select the course IDs that satisfy this condition.
-- Therefore, the result of the query will be:
-- | course_id |
-- |-----------|
-- | CS101     |


-- Exercise 26: Test for Nonexistence with NOT EXISTS
-- Question: Write a query to find all students who have taken all courses offered in the Biology department.
-- Answer:
-- This query selects distinct student IDs and names from the 'student' table.
-- It uses a nested subquery with NOT EXISTS to check if there are any courses in the Biology department that the student has not taken.
SELECT DISTINCT S.ID, S.name
FROM student AS S
WHERE NOT EXISTS ((SELECT course_id
                   FROM course
                   WHERE dept_name = 'Biology')
                  EXCEPT
                  (SELECT T.course_id
                   FROM takes AS T
                   WHERE S.ID = T.ID));

-- Example:
-- Suppose we have the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|
-- | BIO101    | Biology   |
-- | BIO102    | Biology   |
-- | CS101     | Comp. Sci.|
-- 
-- And the following data in the 'takes' table:
-- | ID | course_id |
-- |----|-----------|
-- | 1  | BIO101    |
-- | 1  | BIO102    |
-- | 2  | BIO101    |
-- 
-- The subquery will find the course IDs in the Biology department: BIO101 and BIO102.
-- The outer query will then find the students who have taken all these courses.
-- Therefore, the result of the query will be:
-- | ID | name       |
-- |----|------------|
-- | 1  | Student1   |


--Exercise: find all students who have taken all courses offered in the Biology department.
-- Explanation of the query using example tables:
-- This query finds all students who have taken all courses offered in the Biology department.
-- It uses JOIN and GROUP BY to achieve this.

-- Example:
-- Suppose we have the following data in the 'student' table:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
-- | 2  | Jane Doe   |
-- 
-- And the following data in the 'takes' table:
-- | ID | course_id |
-- |----|-----------|
-- | 1  | BIO101    |
-- | 1  | BIO102    |
-- | 2  | BIO101    |
-- 
-- And the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|
-- | BIO101    | Biology   |
-- | BIO102    | Biology   |
-- | CS101     | Comp. Sci.|
-- 
-- The subquery will count the number of courses in the Biology department: 2.
-- The main query will join the 'student', 'takes', and 'course' tables on the appropriate keys.
-- It will group the results by student ID and name, and count the distinct Biology courses each student has taken.
-- The HAVING clause ensures that only students who have taken all Biology courses are included in the result.
-- Therefore, the result of the query will be:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
SELECT S.ID, S.name
FROM student AS S
JOIN takes AS T ON S.ID = T.ID
JOIN course AS C ON T.course_id = C.course_id
WHERE C.dept_name = 'Biology'
GROUP BY S.ID, S.name
HAVING COUNT(DISTINCT C.course_id) = (SELECT COUNT(*)
                                      FROM course
                                      WHERE dept_name = 'Biology');




-- Exercise 29: Using EXISTS in a Subquery
-- Question: Write a query to find all students who have taken at least one course in the 'Physics' department.
-- Answer:
-- This query selects student IDs and names from the 'student' table.
-- It uses a subquery with EXISTS to check if the student has taken at least one course in the 'Physics' department.
SELECT S.ID, S.name
FROM student AS S
WHERE EXISTS (SELECT 1
              FROM takes AS T
              JOIN course AS C ON T.course_id = C.course_id
              WHERE S.ID = T.ID AND C.dept_name = 'Physics');

-- Example:
-- Suppose we have the following data in the 'student' table:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
-- | 2  | Jane Doe   |
-- 
-- And the following data in the 'takes' table:
-- | ID | course_id |
-- |----|-----------|
-- | 1  | PH101     |
-- | 2  | BIO101    |
-- 
-- And the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|
-- | PH101     | Physics   |
-- | BIO101    | Biology   |
-- 
-- The subquery will check if each student has taken at least one course in the 'Physics' department.
-- The outer query will then select the student IDs and names that satisfy this condition.
-- Therefore, the result of the query will be:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |

-- Exercise 27: Test for Absence of Duplicate Tuples with UNIQUE
-- Question: Write a query to find all courses that were offered at most once in 2009.
-- Answer:
-- This query selects course IDs from the 'course' table.
-- It uses a nested subquery with UNIQUE to check if the course was offered at most once in 2009.
SELECT T.course_id
FROM course AS T
WHERE UNIQUE (SELECT R.course_id
              FROM section AS R
              WHERE T.course_id = R.course_id AND
                    R.year = 2009);

-- Example:
-- Suppose we have the following data in the 'section' table:
-- | course_id | year  |
-- |-----------|-------|
-- | CS101     | 2009  |
-- | CS102     | 2009  |
-- | CS101     | 2009  |
-- 
-- The subquery will check if each course ID was offered at most once in 2009.
-- The outer query will then select the course IDs that satisfy this condition.
-- Therefore, the result of the query will be:
-- | course_id |
-- |-----------|
-- | CS102     |


-- Exercise 28: Subqueries in the FROM Clause
-- Question: Write a query to find the average instructors' salaries of those departments where the average salary is greater than $42,000.
-- Answer:
-- This query selects department names and average salaries from a subquery.
-- The subquery calculates the average salary for each department.
-- The outer query filters the results to include only those departments with an average salary greater than $42,000.
SELECT dept_name, avg_salary
FROM (SELECT dept_name, AVG(salary) AS avg_salary
      FROM instructor
      GROUP BY dept_name) AS dept_avg
WHERE avg_salary > 42000;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | dept_name  | salary |
-- |------------|--------|
-- | Comp. Sci. | 45000  |
-- | Comp. Sci. | 47000  |
-- | Biology    | 40000  |
-- | Biology    | 41000  |
-- 
-- The subquery will calculate the average salary for each department:
-- Comp. Sci.: (45000 + 47000) / 2 = 46000
-- Biology: (40000 + 41000) / 2 = 40500
-- The outer query will then filter the results to include only those departments with an average salary greater than $42,000.
-- Therefore, the result of the query will be:
-- | dept_name  | avg_salary |
-- |------------|------------|
-- | Comp. Sci. | 46000      |


-- Exercise 29: Scalar Subqueries
-- Question: Write a query to list all departments along with the number of instructors in each department.
-- Answer:
-- This query selects department names from the 'department' table.
-- It uses a scalar subquery to count the number of instructors in each department.
SELECT dept_name,
       (SELECT COUNT(*)
        FROM instructor
        WHERE department.dept_name = instructor.dept_name) AS num_instructors
FROM department;

-- Example:
-- Suppose we have the following data in the 'department' table:
-- | dept_name  |
-- |------------|
-- | Comp. Sci. |
-- | Biology    |
-- | Chemistry  |
-- | Physics    |
-- 
-- And the following data in the 'instructor' table:
-- | dept_name  |
-- |------------|
-- | Comp. Sci. |
-- | Comp. Sci. |
-- | Biology    |
-- | Chemistry  |
-- | Chemistry  |
-- | Chemistry  |
-- | Physics    |
-- | Physics    |
-- | Physics    |
-- | Physics    |
-- 
-- The scalar subquery will count the number of instructors in each department:
-- Comp. Sci.: 2
-- Biology: 1
-- Chemistry: 3
-- Physics: 4
-- Therefore, the result of the query will be:
-- | dept_name  | num_instructors |
-- |------------|-----------------|
-- | Comp. Sci. | 2               |
-- | Biology    | 1               |
-- | Chemistry  | 3               |
-- | Physics    | 4               |


-- Exercise 30: Delete Instructors from Finance Department
-- Question: Write a query to delete all instructors from the Finance department.
-- Answer:
-- This query deletes all tuples in the 'instructor' table where the department name is 'Finance'.
DELETE FROM instructor
WHERE dept_name = 'Finance';

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | dept_name |
-- |----|------------|-----------|
-- | 1  | John Smith | Finance   |
-- | 2  | Jane Doe   | Finance   |
-- | 3  | Alice Brown| Biology   |
-- 
-- The result of the query will be:
-- | ID | name       | dept_name |
-- |----|------------|-----------|
-- | 3  | Alice Brown| Biology   |


-- Exercise 31: Delete Instructors with Salary Between 13000 and 15000
-- Question: Write a query to delete all instructors with a salary between $13,000 and $15,000.
-- Answer:
-- This query deletes all tuples in the 'instructor' table where the salary is between 13000 and 15000.
DELETE FROM instructor
WHERE salary BETWEEN 13000 AND 15000;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 14000  |
-- | 2  | Jane Doe   | 16000  |
-- | 3  | Alice Brown| 15000  |
-- 
-- The result of the query will be:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 2  | Jane Doe   | 16000  |


-- Exercise 32: Delete Instructors in Watson Building
-- Question: Write a query to delete all instructors associated with a department located in the Watson building.
-- Answer:
-- This query deletes all tuples in the 'instructor' table where the department name is in the set of department names located in the Watson building.
DELETE FROM instructor
WHERE dept_name IN (SELECT dept_name
                    FROM department
                    WHERE building = 'Watson');

-- Example:
-- Suppose we have the following data in the 'department' table:
-- | dept_name | building     |
-- |-----------|--------------|
-- | Comp. Sci.| Watson Hall  |
-- | Biology   | Watson Annex |
-- 
-- And the following data in the 'instructor' table:
-- | ID | name       | dept_name  |
-- |----|------------|------------|
-- | 1  | John Smith | Comp. Sci. |
-- | 2  | Jane Doe   | Biology    |
-- | 3  | Alice Brown| Chemistry  |
-- 
-- The result of the query will be:
-- | ID | name       | dept_name  |
-- |----|------------|------------|
-- | 3  | Alice Brown| Chemistry  |


-- Exercise 33: Delete Instructors with Salary Below Average
-- Question: Write a query to delete the records of all instructors with salary below the average at the university.
-- Answer:
-- This query deletes all tuples in the 'instructor' table where the salary is less than the average salary of all instructors.
DELETE FROM instructor
WHERE salary < (SELECT AVG(salary)
                FROM instructor);

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 90000  |
-- | 2  | Jane Doe   | 80000  |
-- | 3  | Alice Brown| 70000  |
-- 
-- The average salary is (90000 + 80000 + 70000) / 3 = 80000.
-- The result of the query will be:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 90000  |
-- | 2  | Jane Doe   | 80000  |


-- Exercise 34: Insert New Course
-- Question: Write a query to insert a new course 'CS-437' in the Computer Science department with title 'Database Systems' and 4 credit hours.
-- Answer:
-- This query inserts a new tuple into the 'course' table with the specified values.
INSERT INTO course (course_id, title, dept_name, credits)
VALUES ('CS-437', 'Database Systems', 'Comp. Sci.', 4);

-- Example:
-- Suppose we have the following data in the 'course' table:
-- | course_id | title            | dept_name  | credits |
-- |-----------|------------------|------------|---------|
-- | CS101     | Intro to CS      | Comp. Sci. | 3       |
-- 
-- The result of the query will be:
-- | course_id | title            | dept_name  | credits |
-- |-----------|------------------|------------|---------|
-- | CS101     | Intro to CS      | Comp. Sci. | 3       |
-- | CS-437    | Database Systems | Comp. Sci. | 4       |


-- Exercise 35: Insert Students as Instructors
-- Question: Write a query to make each student in the Music department who has earned more than 144 credit hours an instructor in the Music department with a salary of $18,000.
-- Answer:
-- This query inserts tuples into the 'instructor' table based on the result of a select query from the 'student' table.
INSERT INTO instructor (ID, name, dept_name, salary)
SELECT ID, name, dept_name, 18000
FROM student
WHERE dept_name = 'Music' AND tot_cred > 144;

-- Example:
-- Suppose we have the following data in the 'student' table:
-- | ID | name       | dept_name | tot_cred |
-- |----|------------|-----------|----------|
-- | 1  | John Smith | Music     | 150      |
-- | 2  | Jane Doe   | Music     | 140      |
-- 
-- The result of the query will be:
-- | ID | name       | dept_name | salary |
-- |----|------------|-----------|--------|
-- | 1  | John Smith | Music     | 18000  |


-- Exercise 36: Update Instructor Salaries by 5%
-- Question: Write a query to increase the salaries of all instructors by 5 percent.
-- Answer:
-- This query updates the 'salary' attribute of all tuples in the 'instructor' table by multiplying the current salary by 1.05.
UPDATE instructor
SET salary = salary * 1.05;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 90000  |
-- | 2  | Jane Doe   | 80000  |
-- 
-- The result of the query will be:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 94500  |
-- | 2  | Jane Doe   | 84000  |


-- Exercise 37: Update Instructor Salaries Based on Condition
-- Question: Write a query to give a 5 percent salary raise to instructors whose salary is less than the average salary.
-- Answer:
-- This query updates the 'salary' attribute of all tuples in the 'instructor' table where the salary is less than the average salary of all instructors.
UPDATE instructor
SET salary = salary * 1.05
WHERE salary < (SELECT AVG(salary)
                FROM instructor);

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 90000  |
-- | 2  | Jane Doe   | 80000  |
-- | 3  | Alice Brown| 70000  |
-- 
-- The average salary is (90000 + 80000 + 70000) / 3 = 80000.
-- The result of the query will be:
-- | ID | name       | salary |
-- |----|------------|--------|
-- | 1  | John Smith | 90000  |
-- | 2  | Jane Doe   | 80000  |
-- | 3  | Alice Brown| 73500  |


-- Exercise 38: Update Instructor Salaries with CASE
-- Question: Write a query to give a 3 percent raise to instructors with salary over $100,000 and a 5 percent raise to all others using CASE.
-- Answer:
-- This query updates the 'salary' attribute of all tuples in the 'instructor' table using a CASE statement to apply different raises based on the current salary.
UPDATE instructor
SET salary = CASE
    WHEN salary > 100000 THEN salary * 1.03
    ELSE salary * 1.05
END;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | salary  |
-- |----|------------|---------|
-- | 1  | John Smith | 110000  |
-- | 2  | Jane Doe   | 90000   |
-- 
-- The result of the query will be:
-- | ID | name       | salary  |
-- |----|------------|---------|
-- | 1  | John Smith | 113300  |
-- | 2  | Jane Doe   | 94500   |




-- Example Schema:
-- The 'instructor' table has columns: ID, name, dept_name, and salary.
-- The 'course' table has columns: course_id, title, dept_name, and credits.
-- The 'section' table has columns: course_id, sec_id, semester, year, and building.
-- The 'student' table has columns: ID, name, dept_name, and tot_cred.

-- Question: Write the following inserts, deletes or updates in SQL, using the university schema.
-- a. Increase the salary of each instructor in the Comp. Sci. department by 10%.
-- b. Delete all courses that have never been offered (that is, do not occur in the section relation).
-- c. Insert every student whose tot_cred attribute is greater than 100 as an instructor in the same department, with a salary of $10,000.

-- Answer:
-- a. Increase the salary of each instructor in the Comp. Sci. department by 10%.
-- This query updates the 'salary' attribute of all instructors in the 'Comp. Sci.' department by increasing it by 10%.
UPDATE instructor
SET salary = salary * 1.10
WHERE dept_name = 'Comp. Sci.';

-- b. Delete all courses that have never been offered (that is, do not occur in the section relation).
-- This query deletes all courses from the 'course' table that do not have a corresponding entry in the 'section' table.
DELETE FROM course
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM section);

-- c. Insert every student whose tot_cred attribute is greater than 100 as an instructor in the same department, with a salary of $10,000.
-- This query inserts students with more than 100 total credits into the 'instructor' table with a salary of $10,000.
INSERT INTO instructor (ID, name, dept_name, salary)
SELECT ID, name, dept_name, 10000
FROM student
WHERE tot_cred > 100;

-- Example Data:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |
-- 
-- And the following data in the 'course' table:
-- | course_id | title         | dept_name  | credits |
-- |-----------|---------------|------------|---------|
-- | CS101     | Intro to CS   | Comp. Sci. | 4       |
-- | BIO101    | Intro to Bio  | Biology    | 4       |
-- | MATH101   | Calculus I    | Math       | 4       |
-- 
-- And the following data in the 'section' table:
-- | course_id | sec_id | semester | year | building |
-- |-----------|--------|----------|------|----------|
-- | CS101     | 1      | Fall     | 2022 | Watson   |
-- 
-- And the following data in the 'student' table:
-- | ID | name       | dept_name  | tot_cred |
-- |----|------------|------------|----------|
-- | 1  | Alice Brown| Comp. Sci. | 120      |
-- | 2  | Bob White  | Biology    | 90       |
-- 
-- The result of the queries will be:
-- For query a:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 99000  |
-- | 2  | Jane Doe   | Biology    | 80000  |
-- 
-- For query b:
-- | course_id | title         | dept_name  | credits |
-- |-----------|---------------|------------|---------|
-- | CS101     | Intro to CS   | Comp. Sci. | 4       |
-- 
-- For query c:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 99000  |
-- | 2  | Jane Doe   | Biology    | 80000  |
-- | 1  | Alice Brown| Comp. Sci. | 10000  |




-- Schema Definition
-- person (driver_id PK, name, address)
-- car (license PK, model, year)
-- accident (report_number PK, date, location)
-- owns (driver_id PK, license PK)
-- participated (report_number PK, license PK, driver_id, damage_amount)

-- a. Find the number of accidents in which the cars belonging to “John Smith” were involved.
SELECT COUNT(DISTINCT A.report_number) AS num_accidents
FROM person P
JOIN owns O ON P.driver_id = O.driver_id
JOIN participated PA ON O.license = PA.license
JOIN accident A ON PA.report_number = A.report_number
WHERE P.name = 'John Smith';

-- Explanation:
-- This query counts the distinct number of accident report numbers.
-- It joins the 'person', 'owns', 'participated', and 'accident' tables.
-- The WHERE clause filters the results to include only those accidents involving cars owned by "John Smith".

-- Example:
-- Suppose we have the following data:
-- person: | driver_id | name       | address     |
--         |-----------|------------|-------------|
--         | 1         | John Smith | 123 Elm St  |
-- owns:   | driver_id | license    |
--         |-----------|------------|
--         | 1         | ABC123     |
-- participated: | report_number | license | driver_id | damage_amount |
--               |---------------|---------|-----------|---------------|
--               | AR1001        | ABC123  | 1         | 500           |
-- accident: | report_number | date       | location  |
--           |---------------|------------|-----------|
--           | AR1001        | 2023-01-01 | Downtown  |
-- The result will be:
-- | num_accidents |
-- |---------------|
-- | 1             |

-- b. Update the damage amount for the car with the license number “AABB2000” in the accident with report number “AR2197” to $3000.
UPDATE participated
SET damage_amount = 3000
WHERE license = 'AABB2000' AND report_number = 'AR2197';

-- Explanation:
-- This query updates the 'participated' table.
-- It sets the damage_amount to 3000 for the specified license and report number.

-- Example:
-- Suppose we have the following data before the update:
-- participated: | report_number | license  | driver_id | damage_amount |
--               |---------------|----------|-----------|---------------|
--               | AR2197        | AABB2000 | 2         | 1500          |
-- After the update, the data will be:
-- participated: | report_number | license  | driver_id | damage_amount |
--               |---------------|----------|-----------|---------------|
--               | AR2197        | AABB2000 | 2         | 3000          |





-- Schema Definition:
-- branch(branch_name PK, branch_city, assets)
-- customer(customer_name PK, customer_street, customer_city)
-- loan(loan_number PK, branch_name, amount)
-- borrower(customer_name, loan_number PK)
-- account(account_number PK, branch_name, balance)
-- depositor(customer_name, account_number PK)

-- a. Find all customers who have an account at all the branches located in "Brooklyn".
-- This query selects customer names from the 'customer' table.
-- It uses a nested subquery with NOT EXISTS to ensure the customer has an account at all branches in Brooklyn.
SELECT DISTINCT C.customer_name
FROM customer C
WHERE NOT EXISTS (
    SELECT B.branch_name
    FROM branch B
    WHERE B.branch_city = 'Brooklyn'
    EXCEPT
    SELECT D.branch_name
    FROM depositor D, account A
    WHERE D.account_number = A.account_number AND D.customer_name = C.customer_name AND A.branch_name = B.branch_name
);

-- b. Find out the total sum of all loan amounts in the bank.
-- This query calculates the total sum of all loan amounts from the 'loan' table.
SELECT SUM(amount) AS total_loan_amount
FROM loan;

-- c. Find the names of all branches that have assets greater than those of at least one branch located in "Brooklyn".
-- This query selects branch names from the 'branch' table.
-- It uses a subquery to compare assets with branches located in Brooklyn.
SELECT B1.branch_name
FROM branch B1
WHERE B1.assets > ANY (
    SELECT B2.assets
    FROM branch B2
    WHERE B2.branch_city = 'Brooklyn'
);





-- Schema Definition:
-- employee(employee_name PK, street, city)
-- works(employee_name PK, company_name, salary)
-- company(company_name PK, city)
-- manages(employee_name PK, manager_name)

-- a. Modify the database so that “Jones” now lives in “Newtown”.
-- This query updates the 'employee' table to set the city to 'Newtown' where the employee_name is 'Jones'.
UPDATE employee
SET city = 'Newtown'
WHERE employee_name = 'Jones';

-- b. Give all managers of “First Bank Corporation” a 10 percent raise
-- unless the salary becomes greater than $100,000; in such cases, give
-- only a 3 percent raise.
-- This query updates the 'works' table to give a 10 percent raise to managers of 'First Bank Corporation' 
-- whose salary after the raise does not exceed $100,000.
UPDATE works
SET salary = salary * 1.10
WHERE employee_name IN (SELECT employee_name
                        FROM manages)
  AND company_name = 'First Bank Corporation'
  AND salary * 1.10 <= 100000;

-- This query updates the 'works' table to give a 3 percent raise to managers of 'First Bank Corporation' 
-- whose salary after a 10 percent raise would exceed $100,000.
UPDATE works
SET salary = salary * 1.03
WHERE employee_name IN (SELECT employee_name
                        FROM manages)
  AND company_name = 'First Bank Corporation'
  AND salary * 1.10 > 100000;

-- Schema Definition:
-- employee(employee_name PK, street, city)
-- works(employee_name PK, company_name, salary)
-- company(company_name PK, city)
-- manages(employee_name PK, manager_name)

-- a. Find the names of all employees who work for “First Bank Corporation”.
-- This query selects the names of employees from the 'works' table where the company_name is 'First Bank Corporation'.
-- The WHERE clause filters the rows to include only those where the company_name is 'First Bank Corporation'.
SELECT employee_name
FROM works
WHERE company_name = 'First Bank Corporation';

-- b. Find all employees in the database who live in the same cities as the companies for which they work.
-- This query selects the names of employees from the 'employee', 'works', and 'company' tables where the employee's city matches the company's city.
-- The WHERE clause ensures that the employee's city is the same as the company's city.
-- The query joins the 'employee' and 'works' tables on the employee_name, and the 'works' and 'company' tables on the company_name.
SELECT E.employee_name
FROM employee E, works W, company C
WHERE E.employee_name = W.employee_name
  AND W.company_name = C.company_name
  AND E.city = C.city;

-- c. Find all employees in the database who live in the same cities and on the same streets as do their managers.
-- This query selects the names of employees from the 'employee' and 'manages' tables where the employee's city and street match the manager's city and street.
-- The WHERE clause ensures that the employee's city and street are the same as the manager's city and street.
-- The query joins the 'employee' table twice: once for the employee and once for the manager.
SELECT E1.employee_name
FROM employee E1, employee E2, manages M
WHERE E1.employee_name = M.employee_name
  AND M.manager_name = E2.employee_name
  AND E1.city = E2.city
  AND E1.street = E2.street;

  -- Schema Definition for the employee database of Figure 3.20

  -- This statement creates a table named 'employee' with three columns: employee_name, street, and city.
  -- The primary key is employee_name.
  CREATE TABLE employee (
      employee_name VARCHAR(50) PRIMARY KEY,
      street VARCHAR(50),
      city VARCHAR(50)
  );

  -- This statement creates a table named 'works' with three columns: employee_name, company_name, and salary.
  -- The primary key is employee_name.
  -- The employee_name is a foreign key referencing the employee table.
  CREATE TABLE works (
      employee_name VARCHAR(50) PRIMARY KEY,
      company_name VARCHAR(50),
      salary DECIMAL(10, 2),
      FOREIGN KEY (employee_name) REFERENCES employee(employee_name)
  );

  -- This statement creates a table named 'company' with two columns: company_name and city.
  -- The primary key is company_name.
  CREATE TABLE company (
      company_name VARCHAR(50) PRIMARY KEY,
      city VARCHAR(50)
  );

  -- This statement creates a table named 'manages' with two columns: employee_name and manager_name.
  -- The primary key is employee_name.
  -- The employee_name is a foreign key referencing the employee table.
  CREATE TABLE manages (
      employee_name VARCHAR(50) PRIMARY KEY,
      manager_name VARCHAR(50),
      FOREIGN KEY (employee_name) REFERENCES employee(employee_name)
  );




  -- Schema Definition
  -- This statement creates a table named 'member' with three columns: memb_no, name, and age.
  -- The primary key is memb_no.
  CREATE TABLE member (
      memb_no INT PRIMARY KEY,
      name VARCHAR(100),
      age INT
  );

  -- This statement creates a table named 'book' with four columns: isbn, title, authors, and publisher.
  -- The primary key is isbn.
  CREATE TABLE book (
      isbn VARCHAR(20) PRIMARY KEY,
      title VARCHAR(200),
      authors VARCHAR(200),
      publisher VARCHAR(100)
  );

  -- This statement creates a table named 'borrowed' with three columns: memb_no, isbn, and date.
  -- The primary key is a combination of memb_no and isbn.
  -- The memb_no is a foreign key referencing the member table.
  -- The isbn is a foreign key referencing the book table.
  CREATE TABLE borrowed (
      memb_no INT,
      isbn VARCHAR(20),
      date DATE,
      PRIMARY KEY (memb_no, isbn),
      FOREIGN KEY (memb_no) REFERENCES member(memb_no),
      FOREIGN KEY (isbn) REFERENCES book(isbn)
  );

  -- Rewriting the WHERE clause without using the UNIQUE construct
  -- The UNIQUE construct ensures that the subquery returns a single row.
  -- We can achieve the same result by using a GROUP BY clause and a HAVING clause to ensure uniqueness.
  -- The rewritten WHERE clause checks that the subquery returns exactly one row by counting the number of distinct titles.
  WHERE (SELECT COUNT(DISTINCT title) FROM course) = 1



  -- Question 3.23: Consider the query:
  -- select course_id, semester, year, sec_id, avg (tot_cred)
  -- from takes natural join student
  -- where year = 2009
  -- group by course_id, semester, year, sec_id
  -- having count (ID) >= 2;
  -- Explain why joining section as well in the from clause would not change the result.

  -- Explanation:
  -- The query is using a natural join between the 'takes' and 'student' tables.
  -- It selects course_id, semester, year, sec_id, and the average of tot_cred for the year 2009.
  -- The results are grouped by course_id, semester, year, and sec_id, with a condition that the count of IDs is at least 2.
  -- Adding a join with the 'section' table would not change the result because the query does not use any columns from the 'section' table.
  -- The grouping and conditions are based solely on the 'takes' and 'student' tables.

  -- Question 3.24: Rewrite the query without using the with construct.
  -- Original Query:
  -- with dept_total (dept_name, value) as
  -- (select dept_name, sum(salary)
  -- from instructor
  -- group by dept_name),
  -- dept_total_avg(value) as
  -- (select avg(value)
  -- from dept_total)
  -- select dept_name
  -- from dept_total, dept_total_avg
  -- where dept_total.value >= dept_total_avg.value;

  -- Rewritten Query:
  -- This query selects department names where the total salary is greater than or equal to the average total salary across all departments.
  SELECT dept_name
  FROM (
      SELECT dept_name, SUM(salary) AS total_salary
      FROM instructor
      GROUP BY dept_name
  ) AS dept_total
  WHERE total_salary >= (
      SELECT AVG(total_salary)
      FROM (
          SELECT SUM(salary) AS total_salary
          FROM instructor
          GROUP BY dept_name
      ) AS dept_total_avg
  );


  

  --Midterm review

SELECT V.vi_id
FROM Voter V
JOIN VotesCast VC ON V.v_id = VC.v_id
JOIN Office O ON VC.o_id = 
WHERE    

  
   
-- Explanation of Erroneous Query with Example Table

-- The following query is erroneous because the attribute 'ID' appears in the SELECT clause without being aggregated and is not present in the GROUP BY clause.
-- This violates the SQL rule that any attribute not present in the GROUP BY clause must appear only inside an aggregate function if it appears in the SELECT clause.

-- Erroneous Query:
-- select dept_name, ID, avg(salary)
-- from instructor
-- group by dept_name;

-- Example Table: instructor
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 75000  |
-- | 2  | Jane Doe   | Comp. Sci. | 65000  |
-- | 3  | Alice Brown| Biology    | 72000  |
-- | 4  | Bob White  | Biology    | 72000  |
-- | 5  | Carol Black| Physics    | 91000  |

-- Correct Query:
-- To correct the query, we need to remove the 'ID' attribute from the SELECT clause or include it in an aggregate function.
-- Here is the corrected query that finds the average salary in each department without including 'ID' in the SELECT clause.

SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name;

-- Result of the Correct Query:
-- | dept_name  | avg_salary |
-- |------------|------------|
-- | Comp. Sci. | 70000      |
-- | Biology    | 72000      |
-- | Physics    | 91000      |

-- The corrected query groups the tuples by 'dept_name' and calculates the average salary for each group.
-- The 'ID' attribute is not included in the SELECT clause, ensuring the query is valid.


-- Explanation of Weak Entities with Example Table

-- A weak entity is an entity that cannot be uniquely identified by its own attributes alone.
-- It relies on a "strong" or "owner" entity to provide additional attributes for unique identification.
-- Weak entities have a partial key, which is an attribute that can uniquely identify weak entities, but only when combined with the key of the strong entity.
-- Weak entities are represented in ER diagrams with a double rectangle, and their relationship with the strong entity is represented with a double diamond.

-- Example:
-- Consider the following example tables for a university database:

-- department table (strong entity):
-- | dept_name  | building | budget |
-- |------------|----------|--------|
-- | Comp. Sci. | Taylor   | 100000 |
-- | Biology    | Watson   | 150000 |

-- course table (weak entity):
-- | course_id | dept_name  | course_name |
-- |-----------|------------|-------------|
-- | 101       | Comp. Sci. | Data Structures |
-- | 102       | Comp. Sci. | Algorithms |
-- | 201       | Biology    | Genetics |
-- | 202       | Biology    | Microbiology |

-- In this example:
-- 1. The 'department' table is the strong entity with 'dept_name' as its primary key.
-- 2. The 'course' table is the weak entity that cannot be uniquely identified by 'course_id' alone.
-- 3. The combination of 'course_id' and 'dept_name' uniquely identifies each course.
-- 4. The 'dept_name' attribute in the 'course' table is a foreign key that references the 'department' table.

-- The relationship between 'department' and 'course' is a one-to-many relationship, where each department can offer multiple courses.
-- The 'course' table depends on the 'department' table for its unique identification.

-- To create these tables in SQL, we can use the following statements:

-- Create the 'department' table (strong entity)
CREATE TABLE department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget INT
);

-- Create the 'course' table (weak entity)
CREATE TABLE course (
    course_id INT,
    dept_name VARCHAR(50),
    course_name VARCHAR(50),
    PRIMARY KEY (course_id, dept_name),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

-- The 'course' table has a composite primary key consisting of 'course_id' and 'dept_name'.
-- The 'dept_name' attribute in the 'course' table is a foreign key that references the 'department' table.
-- This ensures that each course is associated with a valid department and can be uniquely identified by the combination of 'course_id' and 'dept_name'.




-- Create the 'course' table (strong entity)
CREATE TABLE course (
    course_id INT PRIMARY KEY,  -- Primary key for the course table
    title VARCHAR(100),         -- Title of the course
    credits INT                 -- Number of credits for the course
);

-- Create the 'section' table (weak entity)
CREATE TABLE section (
    sec_id INT,                 -- Section ID
    course_id INT,              -- Foreign key referencing course_id in the course table
    semester VARCHAR(20),       -- Semester in which the section is offered
    year INT,                   -- Year in which the section is offered
    PRIMARY KEY (sec_id, course_id, semester, year),  -- Composite primary key
    FOREIGN KEY (course_id) REFERENCES course(course_id)  -- Foreign key constraint
);

-- The 'section' table has a composite primary key consisting of 'sec_id', 'course_id', 'semester', and 'year'.
-- The 'course_id' attribute in the 'section' table is a foreign key that references the 'course' table.
-- This ensures that each section is associated with a valid course and can be uniquely identified by the combination of 'sec_id', 'course_id', 'semester', and 'year'.




-- Explanation of Composite and Multivalued Attributes

-- Composite Attributes:
-- Composite attributes are attributes that can be divided into smaller subparts, which represent more basic attributes with independent meanings.
-- In the given example, the 'name' attribute is a composite attribute consisting of 'first_name', 'middle_initial', and 'last_name'.
-- These subparts can be stored as separate attributes in the database schema.

-- Example:
-- Consider an entity set 'instructor' with a composite attribute 'name'.
-- The schema for this entity set can include separate attributes for each component of the composite attribute:
-- instructor(ID, first_name, middle_initial, last_name, ...)

-- Multivalued Attributes:
-- Multivalued attributes are attributes that can have multiple values for a single entity.
-- In the example, 'phone_number' is a multivalued attribute, meaning an instructor can have more than one phone number.
-- Multivalued attributes are typically represented by creating a separate table to store the multiple values.

-- Example:
-- To handle the multivalued attribute 'phone_number', we can create a separate table:
-- phone_numbers(instructor_ID, phone_number)
-- Here, 'instructor_ID' is a foreign key referencing the 'instructor' table, and 'phone_number' stores each phone number.

-- Ignoring multivalued attributes, the extended schema for the 'instructor' entity is:
-- instructor(ID, first_name, middle_initial, last_name, street_number, street_name, apt_number, city, state, zip_code, date_of_birth)

-- This schema includes separate attributes for each component of the composite attributes and omits the multivalued attribute.










-- Schema for the Library Database
-- book(book_id, title, author, genre, published_year)
-- member(member_id, first_name, last_name, membership_date)
-- loan(loan_id, book_id, member_id, loan_date, return_date)
-- reservation(reservation_id, book_id, member_id, reservation_date)

-- Example Questions:

-- 1. Find the titles and authors of all books published after the year 2000.
-- SQL Query:
-- SELECT title, author
-- FROM book
-- WHERE published_year > 2000;

-- 2. List the names of all members who have reserved a book but have not yet borrowed any book.
-- SQL Query:
-- SELECT first_name, last_name
-- FROM member
-- WHERE member_id IN (SELECT member_id FROM reservation)
-- AND member_id NOT IN (SELECT member_id FROM loan);

-- 3. Find the number of books each member has borrowed.
-- SQL Query:
-- SELECT member_id, COUNT(DISTINCT book_id) AS number_of_books
-- FROM loan
-- GROUP BY member_id;

-- Explanation:
-- 1. The COUNT(DISTINCT book_id) function counts the number of unique book_ids for each member.
-- 2. This ensures that if a member has borrowed the same book multiple times, it is only counted once.
-- 3. The GROUP BY clause groups the results by member_id, so we get the count of unique books for each member.



-- Customer(customer_id, name, city)
-- Product(product_id, name, category)
-- Purchase(customer_id, product_id, purchase_date)
    -- Foreign Key (customer_id) references Customer(customer_id)
    -- Foreign Key (product_id) references Product(product_id)

-- Example Questions:

-- 1. Find the customer_ids of customers who live in 'New York' and purchased products in the 'Electronics' category.
-- SQL Query:
-- SELECT customer_id
-- FROM Customer
-- NATURAL JOIN Purchase
-- NATURAL JOIN Product
-- WHERE city = 'New York' AND category = 'Electronics';

-- 2. Find the name and number of purchases for each product in the 'Books' category.
-- SQL Query:
-- SELECT name, COUNT(DISTINCT customer_id) AS number_of_purchases
-- FROM Product
-- NATURAL JOIN Purchase
-- WHERE category = 'Books'
-- GROUP BY name;


-- Explanation of Set Operations with Example Tables

-- Set-union:
-- The UNION operator combines the results of two SELECT statements and returns all unique rows from both queries.
-- Example:
-- Suppose we have the following data in two tables:

-- Table A:
-- | value |
-- |-------|
-- | 1     |
-- | 2     |

-- Table B:
-- | value |
-- |-------|
-- | 2     |
-- | 3     |

-- The query:
SELECT value FROM TableA
UNION
SELECT value FROM TableB;

-- Explanation:
-- 1. The UNION operator combines the results of the two SELECT statements.
-- 2. It returns all unique rows from both TableA and TableB.

-- Result of the query:
-- | value |
-- |-------|
-- | 1     |
-- | 2     |
-- | 3     |

-- Set-intersection:
-- The INTERSECT operator returns only the rows that are present in both SELECT statements.
-- Example:
-- Suppose we have the following data in two tables:

-- Table A:
-- | value |
-- |-------|
-- | 1     |
-- | 2     |

-- Table B:
-- | value |
-- |-------|
-- | 2     |
-- | 3     |

-- The query:
SELECT value FROM TableA
INTERSECT
SELECT value FROM TableB;

-- Explanation:
-- 1. The INTERSECT operator returns only the rows that are present in both TableA and TableB.

-- Result of the query:
-- | value |
-- |-------|
-- | 2     |

-- Set-difference:
-- The EXCEPT operator returns the rows from the first SELECT statement that are not present in the second SELECT statement.
-- Example:
-- Suppose we have the following data in two tables:

-- Table A:
-- | value |
-- |-------|
-- | 1     |
-- | 2     |

-- Table B:
-- | value |
-- |-------|
-- | 2     |
-- | 3     |

-- The query:
SELECT value FROM TableA
EXCEPT
SELECT value FROM TableB;

-- Explanation:
-- 1. The EXCEPT operator returns the rows from TableA that are not present in TableB.

-- Result of the query:
-- | value |
-- |-------|
-- | 1     |



-- This query finds the v_ids and dist_nums of voters who voted for all the candidates
-- that the voter with v_id = 123 voted for.

SELECT v_id, dist_num
FROM Voter AS T
WHERE NOT EXISTS (
    -- Subquery to find candidates voted by voter with v_id = 123
    (SELECT DISTINCT candidate
     FROM VotesCast
     WHERE v_id = 123)
    -- EXCEPT operator to find candidates not voted by current voter
    EXCEPT
    (SELECT DISTINCT candidate
     FROM VotesCast AS S
     WHERE S.v_id = T.v_id)
);

-- Explanation:
-- 1. The outer query selects v_id and dist_num from the Voter table.
-- 2. The NOT EXISTS clause ensures that the current voter (T.v_id) has voted for all candidates
--    that the voter with v_id = 123 has voted for.
-- 3. The first subquery selects distinct candidates voted by the voter with v_id = 123.
-- 4. The second subquery selects distinct candidates voted by the current voter (T.v_id).
-- 5. The EXCEPT operator finds candidates that are in the first subquery but not in the second.
--    It returns the set difference between the two subqueries.
-- 6. If the EXCEPT result is empty, it means the current voter voted for all candidates
--    that v_id = 123 voted for, satisfying the NOT EXISTS condition.

-- Example:
-- Suppose we have the following data in the VotesCast table:
-- | v_id | candidate |
-- |------|-----------|
-- | 123  | A         |
-- | 123  | B         |
-- | 124  | A         |
-- | 124  | B         |
-- | 125  | A         |
-- | 125  | C         |

-- For voter with v_id = 123, the candidates voted are A and B.
-- For voter with v_id = 124, the candidates voted are A and B.
-- For voter with v_id = 125, the candidates voted are A and C.

-- The first subquery:
-- SELECT DISTINCT candidate
-- FROM VotesCast
-- WHERE v_id = 123;
-- Result: {A, B}

-- The second subquery for voter with v_id = 124:
-- SELECT DISTINCT candidate
-- FROM VotesCast AS S
-- WHERE S.v_id = T.v_id;
-- Explanation using table:
-- Suppose we have the following data in the VotesCast table:
-- | v_id | candidate |
-- |------|-----------|
-- | 123  | A         |
-- | 123  | B         |
-- | 124  | A         |
-- | 124  | B         |
-- | 125  | A         |
-- | 125  | C         |
-- 
-- For voter with v_id = 123, the candidates voted are A and B.
-- For voter with v_id = 124, the candidates voted are A and B.
-- For voter with v_id = 125, the candidates voted are A and C.
-- 
-- The first subquery:
-- SELECT DISTINCT candidate
-- FROM VotesCast
-- WHERE v_id = 123;
-- Result: {A, B}
-- 
-- The second subquery for voter with v_id = 124:
-- SELECT DISTINCT candidate
-- FROM VotesCast AS S
-- WHERE S.v_id = T.v_id;
-- Result: {A, B}
-- 
-- The EXCEPT operator:
-- {A, B} EXCEPT {A, B}
-- Result: {}
-- 
-- Since the EXCEPT result is empty, the NOT EXISTS condition is satisfied for voter with v_id = 124.
-- 
-- The second subquery for voter with v_id = 125:
-- SELECT DISTINCT candidate
-- FROM VotesCast AS S
-- WHERE S.v_id = T.v_id;
-- Result: {A, C}
-- 
-- The EXCEPT operator:
-- {A, B} EXCEPT {A, C}
-- Result: {B}
-- 
-- Since the EXCEPT result is not empty, the NOT EXISTS condition is not satisfied for voter with v_id = 125.
-- Result: {A, B}

-- The EXCEPT operator:
-- {A, B} EXCEPT {A, B}
-- Result: {}

-- Since the EXCEPT result is empty, the NOT EXISTS condition is satisfied for voter with v_id = 124.





-- The second subquery for voter with v_id = 125:
-- SELECT DISTINCT candidate
-- FROM VotesCast AS S
-- WHERE S.v_id = T.v_id;
-- Result: {A, C}

-- The EXCEPT operator:
-- {A, B} EXCEPT {A, C}
-- Result: {B}

-- Since the EXCEPT result is not empty, the NOT EXISTS condition is not satisfied for voter with v_id = 125.

-- Therefore, the query will return the v_id and dist_num for voters who voted for all candidates that voter with v_id = 123 voted for, which in this example is only voter with v_id = 124.






-- Create a view to count the number of votes each candidate received
CREATE VIEW candidate_vote_count AS
SELECT candidate, COUNT(DISTINCT v_id) AS number_of_votes  -- Count unique voter IDs for each candidate
FROM Voter
NATURAL JOIN VotesCast  -- Join Voter and VotesCast tables on v_id
NATURAL JOIN Office     -- Join the result with Office table on o_id
WHERE title = 'President'  -- Filter for the title 'President'
AND locality = 'US'        -- Filter for the locality 'US'
AND dist_num = 456         -- Filter for the specific election district number 456
GROUP BY candidate;        -- Group the results by candidate to count votes per candidate

-- Example Tables:
-- Voter table:
-- | v_id | name       |
-- |------|------------|
-- | 1    | John Smith |
-- | 2    | Jane Doe   |
-- | 3    | Alice Brown|

-- VotesCast table:
-- | v_id | o_id | candidate |
-- |------|------|-----------|
-- | 1    | 101  | A         |
-- | 2    | 101  | B         |
-- | 3    | 101  | A         |
-- | 1    | 102  | B         |
-- | 2    | 102  | A         |

-- Office table:
-- | o_id | title     | locality | dist_num |
-- |------|-----------|----------|----------|
-- | 101  | President | US       | 456      |
-- | 102  | President | US       | 456      |
-- | 103  | Senator   | US       | 789      |

-- Explanation:
-- 1. The NATURAL JOIN between Voter and VotesCast tables will join rows based on the common attribute 'v_id'.
-- 2. The result is then NATURAL JOINed with the Office table based on the common attribute 'o_id'.
-- 3. The WHERE clause filters the rows to include only those with title 'President', locality 'US', and dist_num 456.
-- 4. The GROUP BY clause groups the rows by 'candidate' and the COUNT(DISTINCT v_id) function counts the unique voter IDs for each candidate.

-- Result of the view candidate_vote_count:
-- | candidate | number_of_votes |
-- |-----------|-----------------|
-- | A         | 2               |
-- | B         | 2               |

-- Select the candidate with the maximum number of votes
SELECT candidate
FROM candidate_vote_count
WHERE number_of_votes = (SELECT MAX(number_of_votes) FROM candidate_vote_count);  -- Find the candidate with the highest vote count

-- Explanation:
-- 1. The subquery (SELECT MAX(number_of_votes) FROM candidate_vote_count) finds the maximum number of votes any candidate received.
-- 2. The outer query selects the candidate(s) whose number_of_votes matches the maximum number of votes.

-- Result of the query:
-- | candidate |
-- |-----------|
-- | A         |
-- | B         |


