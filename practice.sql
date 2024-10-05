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



