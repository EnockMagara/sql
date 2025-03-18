-- Exercise: Find all students who have taken at least one course in the 'Chemistry' department.
-- Explanation of the query using example tables:
-- This query finds all students who have taken at least one course in the Chemistry department.
-- It uses JOIN and EXISTS to achieve this.

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
-- | 1  | CHEM101   |
-- | 2  | BIO101    |
-- 
-- And the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|
-- | CHEM101   | Chemistry |
-- | BIO101    | Biology   |
-- 
-- The subquery will check if each student has taken at least one course in the 'Chemistry' department.
-- The outer query will then select the student IDs and names that satisfy this condition.
-- Therefore, the result of the query will be:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
-- Select the student ID and name from the 'student' table
SELECT S.ID, S.name
FROM student AS S
-- Check if there exists at least one course taken by the student in the 'Chemistry' department
WHERE EXISTS (
              -- Subquery to find if the student has taken any course in the 'Chemistry' department
              SELECT 1
              -- Join the 'takes' table with the 'course' table on the 'course_id' attribute
              FROM takes AS T
              JOIN course AS C ON T.course_id = C.course_id
              -- Ensure the student ID matches and the course belongs to the 'Chemistry' department
              WHERE S.ID = T.ID AND C.dept_name = 'Chemistry'
              );

-- Exercise: Find all students who have taken all courses offered in the 'Physics' department.
-- Explanation of the query using example tables:
-- This query finds all students who have taken all courses offered in the Physics department.
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
-- | 1  | PHYS101   |
-- | 1  | PHYS102   |
-- | 2  | PHYS101   |
-- 
-- And the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|
-- | PHYS101   | Physics   |
-- | PHYS102   | Physics   |
-- | CS101     | Comp. Sci.|
-- 
-- The subquery will count the number of courses in the Physics department: 2.
-- The main query will join the 'student', 'takes', and 'course' tables on the appropriate keys.
-- It will group the results by student ID and name, and count the distinct Physics courses each student has taken.
-- The HAVING clause ensures that only students who have taken all Physics courses are included in the result.
-- Therefore, the result of the query will be:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
SELECT S.ID, S.name
FROM student AS S
JOIN takes AS T ON S.ID = T.ID
JOIN course AS C ON T.course_id = C.course_id
WHERE C.dept_name = 'Physics'
GROUP BY S.ID, S.name
HAVING COUNT(DISTINCT C.course_id) = (SELECT COUNT(*)
                                      FROM course
                                      WHERE dept_name = 'Physics');



                                      
-- Exercise: Find all students who have taken at least one course in each department.
-- Explanation of the query using example tables:
-- This query finds all students who have taken at least one course in each department.
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
-- | 1  | PHYS101   |
-- | 2  | BIO101    |
-- 
-- And the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|
-- | BIO101    | Biology   |
-- | PHYS101   | Physics   |
-- | CS101     | Comp. Sci.|
-- 
-- The subquery will count the number of distinct departments: 3.
-- The main query will join the 'student', 'takes', and 'course' tables on the appropriate keys.
-- It will group the results by student ID and name, and count the distinct departments each student has taken courses in.
-- The HAVING clause ensures that only students who have taken at least one course in each department are included in the result.
-- Therefore, the result of the query will be:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
SELECT S.ID, S.name
FROM student AS S
JOIN takes AS T ON S.ID = T.ID
JOIN course AS C ON T.course_id = C.course_id
GROUP BY S.ID, S.name
HAVING COUNT(DISTINCT C.dept_name) = (SELECT COUNT(DISTINCT dept_name)
                                      FROM course);

-- Exercise: Find all students who have taken more than 3 courses in the 'Comp. Sci.' department.
-- Explanation of the query using example tables:
-- This query finds all students who have taken more than 3 courses in the Comp. Sci. department.
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
-- | 1  | CS101     |
-- | 1  | CS102     |
-- | 1  | CS103     |
-- | 1  | CS104     |
-- | 2  | CS101     |
-- | 2  | CS102     |
-- 
-- And the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|
-- | CS101     | Comp. Sci.|
-- | CS102     | Comp. Sci.|
-- | CS103     | Comp. Sci.|
-- | CS104     | Comp. Sci.|
-- 
-- The main query will join the 'student', 'takes', and 'course' tables on the appropriate keys.
-- It will group the results by student ID and name, and count the distinct Comp. Sci. courses each student has taken.
-- The HAVING clause ensures that only students who have taken more than 3 Comp. Sci. courses are included in the result.
-- Therefore, the result of the query will be:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
SELECT S.ID, S.name
FROM student AS S
JOIN takes AS T ON S.ID = T.ID
JOIN course AS C ON T.course_id = C.course_id
WHERE C.dept_name = 'Comp. Sci.'
GROUP BY S.ID, S.name
HAVING COUNT(DISTINCT C.course_id) > 3;







-- Exercise: Find all students who have taken at least one course in the 'Biology' department.
-- Explanation of the query using example tables:
-- This query finds all students who have taken at least one course in the Biology department.
-- It uses JOIN and EXISTS to achieve this.

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
-- | 2  | CHEM101   |
-- 
-- And the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|
-- | BIO101    | Biology   |
-- | CHEM101   | Chemistry |
-- 
-- The subquery will check if each student has taken at least one course in the 'Biology' department.
-- The outer query will then select the student IDs and names that satisfy this condition.
-- Therefore, the result of the query will be:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
SELECT S.ID, S.name
FROM student AS S
WHERE EXISTS (
              SELECT 1
              FROM takes AS T
              JOIN course AS C ON T.course_id = C.course_id
              WHERE S.ID = T.ID AND C.dept_name = 'Biology'
              );

-- Exercise: Find all students who have taken all courses offered in the 'Chemistry' department.
-- Explanation of the query using example tables:
-- This query finds all students who have taken all courses offered in the Chemistry department.
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
-- | 1  | CHEM101   |
-- | 1  | CHEM102   |
-- | 2  | CHEM101   |
-- 
-- And the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|
-- | CHEM101   | Chemistry |
-- | CHEM102   | Chemistry |
-- | CS101     | Comp. Sci.|
-- 
-- The subquery will count the number of courses in the Chemistry department: 2.
-- The main query will join the 'student', 'takes', and 'course' tables on the appropriate keys.
-- It will group the results by student ID and name, and count the distinct Chemistry courses each student has taken.
-- The HAVING clause ensures that only students who have taken all Chemistry courses are included in the result.
-- Therefore, the result of the query will be:
-- | ID | name       |
-- |----|------------|
-- | 1  | John Smith |
SELECT S.ID, S.name
FROM student AS S
JOIN takes AS T ON S.ID = T.ID
JOIN course AS C ON T.course_id = C.course_id
WHERE C.dept_name = 'Chemistry'
GROUP BY S.ID, S.name
HAVING COUNT(DISTINCT C.course_id) = (SELECT COUNT(*)
                                      FROM course
                                      WHERE dept_name = 'Chemistry');

-- Exercise: Find all students who have taken more than 2 courses in the 'Physics' department.
-- Explanation of the query using example tables:
-- This query finds all students who have taken more than 2 courses in the Physics department.
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
-- | 1  | PHYS101   |
-- | 1  | PHYS102   |
-- | 1  | PHYS103   |
-- | 2  | PHYS101   |
-- | 2  | PHYS102   |
-- 
-- And the following data in the 'course' table:
-- | course_id | dept_name |
-- |-----------|-----------|


-- This query finds the number of accidents involving cars owned by "John Smith".
-- It uses a series of JOIN operations to connect the relevant tables and filter the results.

-- Example tables:
-- person table:
-- | driver_id | name       | address       |
-- |-----------|------------|---------------|
-- | 1         | John Smith | 123 Elm St    |
-- | 2         | Jane Doe   | 456 Oak St    |

-- car table:
-- | license | model  | year |
-- |---------|--------|------|
-- | ABC123  | Toyota | 2010 |
-- | XYZ789  | Honda  | 2012 |

-- owns table:
-- | driver_id | license |
-- |-----------|---------|
-- | 1         | ABC123  |
-- | 2         | XYZ789  |

-- accident table:
-- | report_number | date       | location    |
-- |---------------|------------|-------------|
-- | 101           | 2023-01-01 | Downtown    |
-- | 102           | 2023-02-01 | Uptown      |

-- participated table:
-- | report_number | license | driver_id | damage_amount |
-- |---------------|---------|-----------|---------------|
-- | 101           | ABC123  | 1         | 500           |
-- | 102           | XYZ789  | 2         | 300           |

-- The result of the query will be:
-- | accident_count |
-- |----------------|
-- | 1              |

SELECT COUNT(DISTINCT A.report_number) AS accident_count
FROM person P
JOIN owns O ON P.driver_id = O.driver_id
JOIN participated PA ON O.license = PA.license
JOIN accident A ON PA.report_number = A.report_number
WHERE P.name = 'John Smith';


