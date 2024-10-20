-- Query 1: Using the USING clause
-- This query performs a natural join on the 'student' and 'instructor' tables using the 'dept_name' attribute.
-- The USING clause specifies that the join should be based on the 'dept_name' attribute.
SELECT student.ID, student.name, student.dept_name, instructor.salary
FROM student
JOIN instructor USING (dept_name);

-- Example:
-- Suppose we have the following data in the 'student' table:
-- | ID | name       | dept_name |
-- |----|------------|-----------|
-- | 1  | John Smith | Comp. Sci.|
-- | 2  | Jane Doe   | Biology   |
-- 
-- And the following data in the 'instructor' table:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 3  | Alice Brown| Comp. Sci. | 90000  |
-- | 4  | Bob White  | Biology    | 80000  |
-- 
-- The result of the query will be:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |

-- Query 2: Using the ON clause
-- This query performs a join on the 'student' and 'instructor' tables using the 'dept_name' attribute.
-- The ON clause specifies that the join should be based on the 'dept_name' attribute.
SELECT student.ID, student.name, student.dept_name, instructor.salary
FROM student
JOIN instructor ON student.dept_name = instructor.dept_name;

-- Example:
-- Suppose we have the following data in the 'student' table:
-- | ID | name       | dept_name |
-- |----|------------|-----------|
-- | 1  | John Smith | Comp. Sci.|
-- | 2  | Jane Doe   | Biology   |
-- 
-- And the following data in the 'instructor' table:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 3  | Alice Brown| Comp. Sci. | 90000  |
-- | 4  | Bob White  | Biology    | 80000  |
-- 
-- The result of the query will be:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |

-- Query 3: Using the WHERE clause
-- This query performs a join on the 'student' and 'instructor' tables using the 'dept_name' attribute.
-- The WHERE clause specifies that the join should be based on the 'dept_name' attribute.
SELECT student.ID, student.name, student.dept_name, instructor.salary
FROM student, instructor
WHERE student.dept_name = instructor.dept_name;

-- Example:
-- Suppose we have the following data in the 'student' table:
-- | ID | name       | dept_name |
-- |----|------------|-----------|
-- | 1  | John Smith | Comp. Sci.|
-- | 2  | Jane Doe   | Biology   |
-- 
-- And the following data in the 'instructor' table:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 3  | Alice Brown| Comp. Sci. | 90000  |
-- | 4  | Bob White  | Biology    | 80000  |
-- 
-- The result of the query will be:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |

-- Explanation:
-- The first query uses the USING clause to perform a natural join on the 'dept_name' attribute.
-- The second query uses the ON clause to perform a join on the 'dept_name' attribute.
-- The third query uses the WHERE clause to perform a join on the 'dept_name' attribute.
-- All three queries produce the same result, but the syntax differs.
-- The USING clause is more concise and only requires the attribute name, while the ON clause allows for more complex join conditions.
-- The WHERE clause is another way to specify the join condition, but it is less commonly used for joins in modern SQL.


-- Example 1: Inner Join
-- This query performs an inner join on the 'student' and 'instructor' tables using the 'dept_name' attribute.
-- Only rows with matching 'dept_name' in both tables are included in the result.
SELECT student.ID, student.name, student.dept_name, instructor.salary
FROM student
INNER JOIN instructor ON student.dept_name = instructor.dept_name;

-- Example:
-- Suppose we have the following data in the 'student' table:
-- | ID | name       | dept_name |
-- |----|------------|-----------|
-- | 1  | John Smith | Comp. Sci.|
-- | 2  | Jane Doe   | Biology   |
-- | 3  | Mark Twain | Physics   |
-- 
-- And the following data in the 'instructor' table:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 4  | Alice Brown| Comp. Sci. | 90000  |
-- | 5  | Bob White  | Biology    | 80000  |
-- 
-- The result of the query will be:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |

-- Example 2: Left Outer Join
-- This query performs a left outer join on the 'student' and 'instructor' tables using the 'dept_name' attribute.
-- All rows from the 'student' table are included, along with matching rows from the 'instructor' table.
-- If there is no match, NULL values are returned for columns from the 'instructor' table.
SELECT student.ID, student.name, student.dept_name, instructor.salary
FROM student
LEFT OUTER JOIN instructor ON student.dept_name = instructor.dept_name;

-- Example:
-- Using the same data as above, the result of the query will be:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |
-- | 3  | Mark Twain | Physics    | NULL   |

-- Example 3: Right Outer Join
-- This query performs a right outer join on the 'student' and 'instructor' tables using the 'dept_name' attribute.
-- All rows from the 'instructor' table are included, along with matching rows from the 'student' table.
-- If there is no match, NULL values are returned for columns from the 'student' table.
SELECT student.ID, student.name, student.dept_name, instructor.salary
FROM student
RIGHT OUTER JOIN instructor ON student.dept_name = instructor.dept_name;

-- Example:
-- Using the same data as above, the result of the query will be:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |
-- | NULL | NULL     | NULL       | 70000  | -- Assuming an additional instructor with no matching student

-- Example 4: Full Outer Join
-- This query performs a full outer join on the 'student' and 'instructor' tables using the 'dept_name' attribute.
-- All rows from both tables are included, with NULLs in place where there is no match.
SELECT student.ID, student.name, student.dept_name, instructor.salary
FROM student
FULL OUTER JOIN instructor ON student.dept_name = instructor.dept_name;

-- Example:
-- Using the same data as above, the result of the query will be:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |
-- | 3  | Mark Twain | Physics    | NULL   |
-- | NULL | NULL     | NULL       | 70000  | -- Assuming an additional instructor with no matching student



-- Example 1: Creating a View for Instructor Details without Salary
-- This view provides a relation with instructor ID, name, and department name, excluding the salary.
CREATE VIEW faculty AS
SELECT ID, name, dept_name
FROM instructor;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |
-- | 3  | Alice Brown| Chemistry  | 70000  |
-- 
-- The result of the view will be:
-- | ID | name       | dept_name  |
-- |----|------------|------------|
-- | 1  | John Smith | Comp. Sci. |
-- | 2  | Jane Doe   | Biology    |
-- | 3  | Alice Brown| Chemistry  |

-- Example 2: Creating a View for Physics Courses in Fall 2009
-- This view provides a relation with course ID, section ID, building, and room number for Physics courses in Fall 2009.
CREATE VIEW physics_fall_2009 AS
SELECT course.course_id, sec_id, building, room_number
FROM course, section
WHERE course.course_id = section.course_id
AND course.dept_name = 'Physics'
AND section.semester = 'Fall'
AND section.year = 2009;

-- Example:
-- Suppose we have the following data in the 'course' table:
-- | course_id | title            | dept_name  | credits |
-- |-----------|------------------|------------|---------|
-- | PH101     | Intro to Physics | Physics    | 3       |
-- | CS101     | Intro to CS      | Comp. Sci. | 3       |
-- 
-- And the following data in the 'section' table:
-- | course_id | sec_id | semester | year | building | room_number |
-- |-----------|--------|----------|------|----------|-------------|
-- | PH101     | 1      | Fall     | 2009 | Watson   | 101         |
-- | PH101     | 2      | Fall     | 2009 | Smith    | 202         |
-- 
-- The result of the view will be:
-- | course_id | sec_id | building | room_number |
-- |-----------|--------|----------|-------------|
-- | PH101     | 1      | Watson   | 101         |
-- | PH101     | 2      | Smith    | 202         |

-- Example 3: Using a View in a Query
-- This query finds all Physics courses offered in the Fall 2009 semester in the Watson building using the 'physics_fall_2009' view.
SELECT course_id
FROM physics_fall_2009
WHERE building = 'Watson';

-- Example:
-- Using the same data as above, the result of the query will be:
-- | course_id |
-- |-----------|
-- | PH101     |

-- Example 4: Creating a View for Department Total Salary
-- This view provides a relation with department name and the total salary of all instructors in that department.
CREATE VIEW departments_total_salary(dept_name, total_salary) AS
SELECT dept_name, SUM(salary)
FROM instructor
GROUP BY dept_name;

-- Example:
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 90000  |
-- | 2  | Jane Doe   | Biology    | 80000  |
-- | 3  | Alice Brown| Chemistry  | 70000  |
-- 
-- The result of the view will be:
-- | dept_name  | total_salary |
-- |------------|--------------|
-- | Comp. Sci. | 90000        |
-- | Biology    | 80000        |
-- | Chemistry  | 70000        |
