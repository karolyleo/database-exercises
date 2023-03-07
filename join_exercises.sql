USE employees;

# Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT departments.dept_name AS Department_Name,
       CONCAT(
           employees.first_name, ' ', employees.last_name
           ) AS Department_MANAGER
FROM dept_manager
JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = '9999-01-01'
ORDER BY Department_Name ASC;

# +--------------------+--------------------+
# | Department Name    | Department Manager |
# +--------------------+--------------------+
# | Customer Service   | Yuchang Weedman    |
# | Development        | Leon DasSarma      |
# | Finance            | Isamu Legleitner   |
# | Human Resources    | Karsten Sigstam    |
# | Marketing          | Vishwani Minakawa  |
# | Production         | Oscar Ghazalie     |
# | Quality Management | Dung Pesch         |
# | Research           | Hilary Kambil      |
# | Sales              | Hauke Zhang        |
# +--------------------+--------------------+

# Find the name of all departments currently managed by women.
SELECT departments.dept_name AS Department_Name,
       CONCAT(
               employees.first_name, ' ', employees.last_name
           ) AS Department_MANAGER
FROM dept_manager
         JOIN employees ON dept_manager.emp_no = employees.emp_no
         JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = '9999-01-01' AND employees.gender = 'f'
ORDER BY Department_Name ASC;

# +------------------+--------------------+
# | Department Name  | Department Manager |
# +------------------+--------------------+
# | Development      | Leon DasSarma      |
# | Finance          | Isamu Legleitner   |
# | Human Resources  | Karsten Sigstam    |
# | Research         | Hilary Kambil      |
# +------------------+--------------------+

# Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title, COUNT(titles.title) as Total
FROM titles
JOIN current_dept_emp as cde ON cde.emp_no = titles.emp_no
WHERE titles.to_date =  '9999-01-01' AND cde.dept_no = 'd009'
GROUP BY titles.title;
# 'd009' is Customer Service according to --->  select * from departments

# +--------------------+-------+
# | title              | Total |
# +--------------------+-------+
# | Senior Staff       | 11268 |
# | Staff              |  3574 |
# | Senior Engineer    |  1790 |
# | Engineer           |   627 |
# | Technique Leader   |   241 |
# | Assistant Engineer |    68 |
# | Manager            |     1 |
# +--------------------+-------+

# Find the current salary of all current managers.
SELECT departments.dept_name AS Department_Name,
       CONCAT(
               employees.first_name, ' ', employees.last_name
           ) AS Department_Manager, salaries.salary AS Salary
FROM dept_manager
         JOIN employees ON dept_manager.emp_no = employees.emp_no
         JOIN departments ON departments.dept_no = dept_manager.dept_no
         JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
ORDER BY Department_Name ASC;

# +--------------------+--------------------+--------+
# | Department Name    | Department Manager | Salary |
# +--------------------+--------------------+--------+
# | Customer Service   | Yuchang Weedman    |  58745 |
# | Development        | Leon DasSarma      |  74510 |
# | Finance            | Isamu Legleitner   |  83457 |
# | Human Resources    | Karsten Sigstam    |  65400 |
# | Marketing          | Vishwani Minakawa  | 106491 |
# | Production         | Oscar Ghazalie     |  56654 |
# | Quality Management | Dung Pesch         |  72876 |
# | Research           | Hilary Kambil      |  79393 |
# | Sales              | Hauke Zhang        | 101987 |
# +--------------------+--------------------+--------+

# Bonus Find the names of all current employees, their department name, and their current manager's name .
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Employee, d.dept_name AS Department,
       (SELECT CONCAT(m.first_name, ' ', m.last_name)
        FROM dept_manager AS dm
                 left JOIN employees AS m ON dm.emp_no = m.emp_no
        WHERE dm.dept_no = d.dept_no AND dm.to_date = '9999-01-01'
        LIMIT 1) AS Manager
From current_dept_emp AS cde
left JOIN employees AS e ON cde.emp_no = e.emp_no
left JOIN dept_emp AS de ON de.emp_no = e.emp_no
left JOIN departments AS d ON d.dept_no = de.dept_no
WHERE cde.to_date = '9999-01-01'
ORDER BY Department, e.emp_no;
# Incorrect (populates more than 260k)

# +----------------------+------------------+-----------------+
# | Employee             | Department       | Manager         |
# +----------------------+------------------+-----------------+
# | Huan Lortz           | Customer Service | Yuchang Weedman |
# | Basil Tramer         | Customer Service | Yuchang Weedman |
# | Breannda Billingsley | Customer Service | Yuchang Weedman |
# | Jungsoon Syrzycki    | Customer Service | Yuchang Weedman |
# | Yuichiro Swick       | Customer Service | Yuchang Weedman |
# ... 240,124 Rows in total

# Break it down
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Employee,
       departments.dept_name AS Department,
       CONCAT(m.first_name, ' ', m.last_name) AS Manager
from employees e
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees m on dept_manager.emp_no = m.emp_no
WHERE dept_emp.to_date = '9999-01-01' and dept_manager.to_date = '9999-01-01'
ORDER BY Department, e.emp_no;