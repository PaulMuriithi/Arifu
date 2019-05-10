Optional Task 2: Database Queries
 
Using the attached SQL file, create a sample database, import the tables and solve the following queries.
 
Managers Table
1. Delete duplicate data from table so that only first data remains constant. Show the SQL command
  DELETE
  FROM managers
  WHERE id NOT IN (
    SELECT *
    FROM (
           SELECT MIN(m.id)
           FROM managers m
           GROUP BY m.fname, m.salary) mm);

Customers Table
 
1. The Customers table has some Null entries. Find the Name of Customers where First Name, Second Name and Last Name is given in table. Some Names are missing such as First Name, Second Name and may be Last Name. Write an SQL query to show a list of all 6 customers names, without NULL values. Hint use COALESCE() function. Show the SQL command
  SELECT CONCAT(c.fname, ' ', c.sname, ' ', C.lname) AS name
  FROM customers c
  WHERE c.fname IS NOT NULL
    AND c.sname IS NOT NULL
    AND c.lname IS NOT NULL;

  SELECT TRIM(CONCAT(
             COALESCE(c.fname, ''), ' ',
             COALESCE(c.sname, ''), ' ',
             COALESCE(c.lname, ''))) as name
  FROM customers c;

Employees Table
 
1. Find the Employees who were hired in the Last 1 to 5 months. Show the SQL command
  SELECT *
  FROM employees e
  where (e.hiredate < NOW() - INTERVAL 1 MONTH AND e.hiredate >= NOW() - INTERVAL 5 MONTH)
  ORDER BY e.hiredate DESC;

2. Find the Employees who have been hired in the last 1 to 100 days. Show the SQL command.
  SELECT *
  FROM employees e
  where (e.hiredate < NOW() - INTERVAL 1 DAY AND e.hiredate >= NOW() - INTERVAL 100 DAY)
  ORDER BY e.hiredate DESC;

3. Find the Employees who have been hired in the last 1 to 4 years. Show the SQL command.
  SELECT *
  FROM employees e
  where (e.hiredate < NOW() - INTERVAL 1 year AND e.hiredate >= NOW() - INTERVAL 4 year)
  ORDER BY e.hiredate DESC;
  
4. Select all fnames that start with letter A. Show the SQL command
  SELECT e.fname
  FROM employees e
  WHERE e.fname LIKE 'A%';










