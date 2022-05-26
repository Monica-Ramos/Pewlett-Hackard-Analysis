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



