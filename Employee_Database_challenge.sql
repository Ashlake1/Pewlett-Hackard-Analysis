--Employee_Database_challenge.sql
-- 1. Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no, first_name, last_name
FROM employees;

-- 2. Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title, from_date, to_date 
FROM titles;

-- 3. Create a new table using the INTO clause.
SELECT e.emp_no, 
e.first_name,
e.last_name,
ti.title, 
ti.from_date, 
ti.to_date
INTO Retirement_titles
FROM employees as e
-- 4. Join both tables on the primary key.
JOIN titles as ti
ON e.emp_no = ti.emp_no
-- 5. Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no 
-- 6. Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
-- Use Dictinct with Orderby to remove duplicate rows
SELECT * FROM Retirement_titles;

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY emp_no ASC, to_date DESC;
SELECT * FROM unique_titles;

SELECT COUNT(ut.emp_no),ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY title 
ORDER BY COUNT(title) DESC;
SELECT * FROM retiring_titles;

-- Part 2
SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentorship_eligiblity
FROM employees as e
LEFT JOIN dept_emp as de
	ON (e.emp_no=de.emp_no) 
LEFT JOIN titles as ti
	ON (e.emp_no=ti.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;
SELECT * from mentorship_eligiblity; 