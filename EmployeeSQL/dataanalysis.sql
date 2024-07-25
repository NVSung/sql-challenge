--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.gender,
       (SELECT s.salary FROM salaries s WHERE s.emp_no = e.emp_no) AS salary
FROM employees e;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN employees e ON dm.emp_no = e.emp_no
JOIN departments d ON dm.dept_no = d.dept_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no, de.emp_no,
       (SELECT e.last_name FROM employees e WHERE e.emp_no = de.emp_no) AS last_name,
       (SELECT e.first_name FROM employees e WHERE e.emp_no = de.emp_no) AS first_name,
       (SELECT d.dept_name FROM departments d WHERE d.dept_no = de.dept_no) AS dept_name
FROM dept_emp de;

--List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, gender
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN (SELECT de.emp_no
                 FROM dept_emp de
                 JOIN departments d ON de.dept_no = d.dept_no
                 WHERE d.dept_name = 'Sales');

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
