SELECT e.emp_no,
    e.first_name, 
    e.last_name,
    t.title, 
    t.from_date,
    t.to_date 
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t 
ON (e.emp_no=t.emp_no)
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

SELECT * FROM retirement_titles;

--Remove duplicates and keep only the most recent title of each employee
SELECT DISTINCT ON (emp_no) emp_no,
    first_name, 
    last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC;

SELECT * FROM unique_titles;

--Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT (title),title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT (title) DESC;

SELECT* FROM retiring_titles;
SELECT SUM(count) FROM retiring_titles;

--DELIVERABLE 2
--create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program

SELECT DISTINCT ON(e.emp_no) e.emp_no,
    e.first_name, 
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date ,
    t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no=de.emp_no
INNER JOIN titles as t
ON e.emp_no=t.emp_no
WHERE (de.to_date= '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT *FROM mentorship_eligibilty;
SELECT COUNT(emp_no) emp_no
FROM mentorship_eligibilty;

SELECT COUNT(emp_no), title
FROM mentorship_eligibilty
GROUP BY title
ORDER BY COUNT (title) DESC;

--Calculate the budget needed to cover the salaries per position
SELECT *FROM salaries;

SELECT e.emp_no,
    e.first_name, 
    e.last_name,
    t.title, 
    t.from_date,
    t.to_date,
	s.salary
INTO retirement_titles_salary
FROM employees as e
LEFT JOIN titles as t 
ON (e.emp_no=t.emp_no)
LEFT JOIN salaries as s
ON (e.emp_no=s.emp_no)
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

SELECT * FROM retirement_titles_salary;

SELECT DISTINCT ON (emp_no) emp_no,
    first_name, 
    last_name,
	title,
	salary
INTO unique_titles_salary
FROM retirement_titles_salary
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC;

SELECT * FROM unique_titles_salary;

SELECT COUNT (title),title, SUM (salary)
INTO retiring_titles_salary
FROM unique_titles_salary
GROUP BY title
ORDER BY COUNT(title) DESC;

--aprox budget needed for new employees per position
SELECT* FROM retiring_titles_salary;



