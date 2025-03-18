
-- Example of Foreign Key Constraint Violation

-- Consider the following example tables:

-- department table:
-- | dept_name  | building | budget |
-- |------------|----------|--------|
-- | Comp. Sci. | Taylor   | 100000 |
-- | Biology    | Watson   | 150000 |

-- instructor table:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 75000  |
-- | 2  | Jane Doe   | Biology    | 65000  |

-- Example 1: Insert that causes a violation
-- Attempting to insert an instructor with a dept_name that does not exist in the department table
INSERT INTO instructor (ID, name, dept_name, salary)
VALUES (3, 'Alice Brown', 'Physics', 72000);
-- This will cause a violation because 'Physics' does not exist in the department table.

-- Example 2: Delete that causes a violation
-- Deleting a department that is referenced by an instructor
DELETE FROM department
WHERE dept_name = 'Comp. Sci.';
-- This will cause a violation because 'Comp. Sci.' is referenced by an instructor in the instructor table.

-- To prevent these violations, ensure that:
-- 1. All dept_name values in the instructor table exist in the department table.
-- 2. Do not delete a department if it is referenced by any instructor.


-- Schema for the banking database
-- branch(branch_name, branch_city, assets)
-- customer(customer_name, customer_street, customer_city)
-- loan(loan_number, branch_name, amount)
-- borrower(customer_name, loan_number)
-- account(account_number, branch_name, balance)
-- depositor(customer_name, account_number)

-- a. Find the names of all branches located in “Chicago”.
-- Relational Algebra: π_branch_name(σ_branch_city='Chicago'(branch))
-- Explanation:
-- 1. σ_branch_city='Chicago'(branch): Selects all branches located in Chicago.
-- 2. π_branch_name: Projects the branch_name attribute from the selected tuples.

-- b. Find the names of all borrowers who have a loan in branch “Downtown”.
-- Relational Algebra: π_customer_name(σ_branch_name='Downtown'(borrower ⨝ loan))
-- Explanation:
-- 1. borrower ⨝ loan: Performs a natural join between borrower and loan tables.
-- 2. σ_branch_name='Downtown': Selects tuples where the branch_name is Downtown.
-- 3. π_customer_name: Projects the customer_name attribute from the selected tuples.


-- c. Find the names of all customers who have an account at the "Uptown" branch.
-- Relational Algebra: π_customer_name(σ_branch_name='Uptown'(depositor ⨝ account))
-- Explanation:
-- 1. depositor ⨝ account: Performs a natural join between depositor and account tables.
-- 2. σ_branch_name='Uptown': Selects tuples where the branch_name is Uptown.
-- 3. π_customer_name: Projects the customer_name attribute from the selected tuples.

-- d. Find the account numbers and balances of all accounts at branches in "New York".
-- Relational Algebra: π_account_number, balance(σ_branch_city='New York'(account ⨝ branch))
-- Explanation:
-- 1. account ⨝ branch: Performs a natural join between account and branch tables.
-- 2. σ_branch_city='New York': Selects tuples where the branch_city is New York.
-- 3. π_account_number, balance: Projects the account_number and balance attributes from the selected tuples.

-- e. Find the names of all customers who have both a loan and an account.
-- Relational Algebra: π_customer_name(borrower ⨝ depositor)
-- Explanation:
-- 1. borrower ⨝ depositor: Performs a natural join between borrower and depositor tables.
-- 2. π_customer_name: Projects the customer_name attribute from the selected tuples.

-- f. Find the names of all customers who have a loan at the "Midtown" branch but do not have an account.
-- Relational Algebra: π_customer_name(σ_branch_name='Midtown'(borrower ⨝ loan)) - π_customer_name(depositor)
-- Explanation:
-- 1. borrower ⨝ loan: Performs a natural join between borrower and loan tables.
-- 2. σ_branch_name='Midtown': Selects tuples where the branch_name is Midtown.
-- 3. π_customer_name: Projects the customer_name attribute from the selected tuples.
-- 4. π_customer_name(depositor): Projects the customer_name attribute from the depositor table.
-- 5. - : Performs a set difference to find customers with a loan at Midtown but no account.

-- g. Find the names of all branches that have assets greater than $1,000,000.
-- Relational Algebra: π_branch_name(σ_assets>1000000(branch))
-- Explanation:
-- 1. σ_assets>1000000(branch): Selects all branches with assets greater than $1,000,000.
-- 2. π_branch_name: Projects the branch_name attribute from the selected tuples.

-- h. Find the names of all customers who live in the same city as the branch where they have an account.
-- Relational Algebra: π_customer_name(σ_customer_city=branch_city(depositor ⨝ account ⨝ branch))
-- Explanation:
-- 1. depositor ⨝ account ⨝ branch: Performs a natural join between depositor, account, and branch tables.
-- 2. σ_customer_city=branch_city: Selects tuples where the customer_city is the same as the branch_city.
-- 3. π_customer_name: Projects the customer_name attribute from the selected tuples.



-- Example:
-- Suppose we have the following data in the 'loan' table:
-- | loan_number | branch_name | amount |
-- |-------------|--------------|--------|
-- | L-1         | Downtown     | 1000   |
-- | L-2         | Uptown       | 2000   |
-- | L-3         | Downtown     | 1500   |
-- | L-4         | Midtown       | 500    |
-- | L-5         | Uptown       | 3000   |

-- The query:
SELECT COUNT(DISTINCT branch_name) FROM loan;

-- Explanation:
-- 1. The DISTINCT keyword eliminates duplicate branch names from the input multiset.
-- 2. The COUNT function then counts the number of unique branch names.

-- Result of the query:
-- | count |
-- |-------|
-- | 3     |

-- The result shows that there are 3 unique branch names in the 'loan' table: Downtown, Uptown, and Midtown.





-- Example:
-- Suppose we have the following data in the 'loan' table:
-- | loan_number | branch_name | amount |
-- |-------------|--------------|--------|
-- | L-1         | Downtown     | 1000   |
-- | L-2         | Uptown       | 2000   |
-- | L-3         | Downtown     | 1500   |
-- | L-4         | Midtown      | 500    |
-- | L-5         | Uptown       | 3000   |

-- The query:
SELECT COUNT(*) FROM loan;

-- Explanation:
-- 1. The COUNT(*) function counts the total number of tuples in the 'loan' table.
-- 2. This includes all rows, regardless of whether there are duplicate values in any columns.

-- Result of the query:
-- | count |
-- |-------|
-- | 5     |

-- The result shows that there are 5 tuples in the 'loan' table.

-- Another example:
-- Suppose we have the following data in the 'borrower' table:
-- | customer_name | loan_number |
-- |---------------|-------------|
-- | John Doe      | L-1         |
-- | Jane Smith    | L-2         |
-- | John Doe      | L-3         |
-- | Alice Brown   | L-4         |
-- | Bob White     | L-5         |

-- The query:
SELECT COUNT(*) FROM borrower;

-- Explanation:
-- 1. The COUNT(*) function counts the total number of tuples in the 'borrower' table.
-- 2. This includes all rows, regardless of whether there are duplicate values in any columns.

-- Result of the query:
-- | count |
-- |-------|
-- | 5     |

-- The result shows that there are 5 tuples in the 'borrower' table.



-- Explanation of Erroneous Query with Example Table

-- The following query is erroneous because it combines an individual attribute 'branch_name' with an aggregate function 'MAX(amount)' without using a GROUP BY clause.
-- This violates the SQL rule that any attribute not present in the GROUP BY clause must appear only inside an aggregate function if it appears in the SELECT clause.

-- Erroneous Query:
-- SELECT branch_name, MAX(amount) AS max_amt
-- FROM loan;

-- Example Table: loan
-- | loan_number | branch_name | amount |
-- |-------------|-------------|--------|
-- | L-1         | Downtown    | 1000   |
-- | L-2         | Uptown      | 2000   |
-- | L-3         | Downtown    | 1500   |
-- | L-4         | Midtown     | 500    |
-- | L-5         | Uptown      | 3000   |

-- Correct Query:
-- To correct the query, we need to include the 'branch_name' attribute in the GROUP BY clause.
-- Here is the corrected query that finds the maximum loan amount for each branch.

SELECT branch_name, MAX(amount) AS max_amt
FROM loan
GROUP BY branch_name;

-- Result of the Correct Query:
-- | branch_name | max_amt |
-- |-------------|---------|
-- | Downtown    | 1500    |
-- | Uptown      | 3000    |
-- | Midtown     | 500     |

-- The corrected query groups the tuples by 'branch_name' and calculates the maximum loan amount for each group.
-- The 'branch_name' attribute is included in the GROUP BY clause, ensuring the query is valid.



-- Explanation of Grouping and Aggregates with Example Table

-- Grouping on multiple attributes allows us to create groups based on unique combinations of values for the specified attributes.
-- This can be useful when we want to perform aggregate calculations for each unique combination of attribute values.

-- Example Table: student_marks
-- | student_id | subject   | marks |
-- |------------|-----------|-------|
-- | 1          | Math      | 85    |
-- | 1          | Science   | 90    |
-- | 2          | Math      | 78    |
-- | 2          | Science   | 88    |
-- | 3          | Math      | 92    |
-- | 3          | Science   | 95    |

-- Correct Query:
-- To find the average marks for each student in each subject, we can group by both 'student_id' and 'subject'.
-- Here is the query that calculates the average marks for each unique combination of student and subject.

SELECT student_id, subject, AVG(marks) AS avg_marks
FROM student_marks
GROUP BY student_id, subject;

-- Result of the Correct Query:
-- | student_id | subject | avg_marks |
-- |------------|---------|-----------|
-- | 1          | Math    | 85        |
-- | 1          | Science | 90        |
-- | 2          | Math    | 78        |
-- | 2          | Science | 88        |
-- | 3          | Math    | 92        |
-- | 3          | Science | 95        |

-- The query groups the tuples by both 'student_id' and 'subject' and calculates the average marks for each group.
-- Each group has unique values for the combination of 'student_id' and 'subject', ensuring the query is valid.



-- Explanation of SQL Query with Grouping, Aggregates, and Having Clause

-- The following query demonstrates the use of grouping on multiple attributes, aggregate functions, and the HAVING clause.
-- The query calculates aggregate values for each unique combination of grouping attributes and filters the results based on a condition.

-- Example Table: student_marks
-- | student_id | subject   | marks |
-- |------------|-----------|-------|
-- | 1          | Math      | 85    |
-- | 1          | Science   | 90    |
-- | 2          | Math      | 78    |
-- | 2          | Science   | 88    |
-- | 3          | Math      | 92    |
-- | 3          | Science   | 95    |

-- Query:
-- This query calculates the average marks for each student in each subject and filters the results to include only those with an average marks greater than 80.
SELECT student_id, subject, AVG(marks) AS avg_marks
FROM student_marks
WHERE marks IS NOT NULL
GROUP BY student_id, subject
HAVING AVG(marks) > 80;

-- Explanation:
-- 1. SELECT student_id, subject, AVG(marks) AS avg_marks: Selects the student_id, subject, and calculates the average marks for each group.
-- 2. FROM student_marks: Specifies the table from which to retrieve the data.
-- 3. WHERE marks IS NOT NULL: Filters the rows to include only those with non-null marks.
-- 4. GROUP BY student_id, subject: Groups the rows by student_id and subject.
-- 5. HAVING AVG(marks) > 80: Filters the groups to include only those with an average marks greater than 80.

-- Result of the Query:
-- | student_id | subject | avg_marks |
-- |------------|---------|-----------|
-- | 1          | Math    | 85        |
-- | 1          | Science | 90        |
-- | 3          | Math    | 92        |
-- | 3          | Science | 95        |

-- The query groups the tuples by both 'student_id' and 'subject', calculates the average marks for each group, and filters the results based on the HAVING clause.
-- Each group has unique values for the combination of 'student_id' and 'subject', ensuring the query is valid.


-- Explanation of SQL Query to Find Number of Branches with Loans

-- The following query demonstrates how to find the number of branches that currently have loans.
-- The query counts the number of unique branch names in the 'loan' table.

-- Example Table: loan
-- | loan_number | branch_name | amount |
-- |-------------|-------------|--------|
-- | L-1         | Downtown    | 1000   |
-- | L-2         | Uptown      | 2000   |
-- | L-3         | Downtown    | 1500   |
-- | L-4         | Midtown     | 500    |
-- | L-5         | Uptown      | 3000   |

-- Query:
-- This query counts the number of unique branch names in the 'loan' table.
SELECT COUNT(DISTINCT branch_name) AS branch_count
FROM loan;

-- Explanation:
-- 1. SELECT COUNT(DISTINCT branch_name) AS branch_count: Selects the count of unique branch names and aliases it as branch_count.
-- 2. FROM loan: Specifies the table from which to retrieve the data.

-- Result of the Query:
-- | branch_count |
-- |--------------|
-- | 3            |

-- The result shows that there are 3 unique branch names in the 'loan' table: Downtown, Uptown, and Midtown.


-- Explanation of SQL Query to Find Number of Accounts Each Customer Has at Each Branch

-- The following query demonstrates how to find the number of accounts each customer has at each branch.
-- The query groups the data by both customer name and branch name, and then counts the number of tuples in each group.

-- Example Table: depositor
-- | customer_name | account_number |
-- |---------------|----------------|
-- | John Doe      | A-101          |
-- | Jane Smith    | A-102          |
-- | John Doe      | A-103          |
-- | Alice Brown   | A-104          |
-- | Bob White     | A-105          |

-- Example Table: account
-- | account_number | branch_name | balance |
-- |----------------|-------------|---------|
-- | A-101          | Downtown    | 500     |
-- | A-102          | Uptown      | 1500    |
-- | A-103          | Downtown    | 2000    |
-- | A-104          | Midtown     | 2500    |
-- | A-105          | Uptown      | 3000    |

-- Query:
-- This query counts the number of accounts each customer has at each branch.
SELECT D.customer_name, A.branch_name, COUNT(*) AS account_count
FROM depositor D
JOIN account A ON D.account_number = A.account_number
GROUP BY D.customer_name, A.branch_name;

-- Explanation:
-- 1. SELECT D.customer_name, A.branch_name, COUNT(*) AS account_count: Selects the customer name, branch name, and counts the number of accounts, aliasing it as account_count.
-- 2. FROM depositor D: Specifies the depositor table with alias D.
-- 3. JOIN account A ON D.account_number = A.account_number: Joins the depositor and account tables on the account_number attribute.
-- 4. GROUP BY D.customer_name, A.branch_name: Groups the rows by customer name and branch name.

-- Step-by-Step Execution:

-- Step 1: Retrieve data from the depositor table
-- | customer_name | account_number |
-- |---------------|----------------|
-- | John Doe      | A-101          |
-- | Jane Smith    | A-102          |
-- | John Doe      | A-103          |
-- | Alice Brown   | A-104          |
-- | Bob White     | A-105          |

-- Step 2: Retrieve data from the account table
-- | account_number | branch_name | balance |
-- |----------------|-------------|---------|
-- | A-101          | Downtown    | 500     |
-- | A-102          | Uptown      | 1500    |
-- | A-103          | Downtown    | 2000    |
-- | A-104          | Midtown     | 2500    |
-- | A-105          | Uptown      | 3000    |

-- Step 3: Perform the JOIN operation on account_number
-- | customer_name | account_number | branch_name | balance |
-- |---------------|----------------|-------------|---------|
-- | John Doe      | A-101          | Downtown    | 500     |
-- | Jane Smith    | A-102          | Uptown      | 1500    |
-- | John Doe      | A-103          | Downtown    | 2000    |
-- | Alice Brown   | A-104          | Midtown     | 2500    |
-- | Bob White     | A-105          | Uptown      | 3000    |

-- Step 4: Group by customer_name and branch_name, and count the number of accounts
-- | customer_name | branch_name | account_count |
-- |---------------|-------------|---------------|
-- | John Doe      | Downtown    | 2             |
-- | Jane Smith    | Uptown      | 1             |
-- | Alice Brown   | Midtown     | 1             |
-- | Bob White     | Uptown      | 1             |

-- The result shows the number of accounts each customer has at each branch.
-- The query groups the tuples by both 'customer_name' and 'branch_name', calculates the count of accounts for each group, and displays the results.
-- Each group has unique values for the combination of 'customer_name' and 'branch_name', ensuring the query is valid.


-- Explanation of Nested Subqueries with Example
-- example:shows the loan number and amount for loans in the 'Downtown' branch where the amount is greater than the average amount for that branch.
-- Nested subqueries often produce a relation with a single attribute.
-- This is very common for subqueries in the WHERE clause.

-- Example 1: Single-attribute subquery in WHERE clause
-- Suppose we have the following data in the 'loan' table:
-- | loan_number | branch_name | amount |
-- |-------------|-------------|--------|
-- | L-1         | Downtown    | 1000   |
-- | L-2         | Uptown      | 2000   |
-- | L-3         | Downtown    | 1500   |
-- | L-4         | Midtown     | 500    |
-- | L-5         | Uptown      | 3000   |

-- The query:
SELECT loan_number, amount
FROM loan
WHERE branch_name = 'Downtown'
AND amount > (
    SELECT AVG(amount)
    FROM loan
    WHERE branch_name = 'Downtown'
);

-- Explanation:
-- 1. The subquery (SELECT AVG(amount) FROM loan WHERE branch_name = 'Downtown') calculates the average loan amount for the 'Downtown' branch.
-- 2. The main query selects loan numbers and amounts from the 'loan' table where the branch name is 'Downtown' and the amount is greater than the average amount calculated by the subquery.

-- Result of the query:
-- | loan_number | amount |
-- |-------------|--------|
-- | L-3         | 1500   |

-- The result shows the loan number and amount for loans in the 'Downtown' branch where the amount is greater than the average amount for that branch.

-- Nested subqueries can also produce a multiple-attribute relation.
-- This is very common for subqueries in the FROM clause.

-- Example 2: Multiple-attribute subquery in FROM clause
-- Suppose we have the following data in the 'instructor' table:
-- | ID | name       | dept_name  | salary |
-- |----|------------|------------|--------|
-- | 1  | John Smith | Comp. Sci. | 75000  |
-- | 2  | Jane Doe   | Biology    | 65000  |
-- | 3  | Alice Brown| Biology    | 72000  |
-- | 4  | Bob White  | Physics    | 91000  |
-- | 5  | Carol Black| Physics    | 85000  |

-- The query:
SELECT dept_name, avg_salary
FROM (
    SELECT dept_name, AVG(salary) AS avg_salary
    FROM instructor
    GROUP BY dept_name
) AS dept_avg
WHERE avg_salary > 70000;

-- Explanation:
-- 1. The subquery (SELECT dept_name, AVG(salary) AS avg_salary FROM instructor GROUP BY dept_name) calculates the average salary for each department.
-- 2. The main query selects department names and average salaries from the result of the subquery where the average salary is greater than 70000.

-- Result of the query:
-- | dept_name  | avg_salary |
-- |------------|------------|
-- | Comp. Sci. | 75000      |
-- | Biology    | 68500      |
-- | Physics    | 88000      |

-- The result shows the department names and average salaries for departments where the average salary is greater than 70000.
-- The subquery produces a multiple-attribute relation with 'dept_name' and 'avg_salary', which is then used in the main query.
