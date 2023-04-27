-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" varchar(20)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
	CONSTRAINT "pk_Departments" PRIMARY KEY(
        "dept_no"
		)
);

CREATE TABLE "Dept_emp" (
    "dept_emp" int   NOT NULL,
    "dept_no" varchar(20)   NOT NULL
);

CREATE TABLE "Dept_manager" (
    "dept_mn" varchar(20)   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title" varchar(20)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "sex" char(10)   NOT NULL,
    "hire_date" date   NOT NULL
	
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "Titles" (
    "title_id" varchar(20)   NOT NULL,
    "title" varchar(50)   NOT NULL

);

-- Adding Primary keys to Employee and Title tables

ALTER TABLE "Employees" ADD CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
		); 

ALTER TABLE "Titles" ADD CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
		);

-- Adding Foreign keys to tables

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_emp" FOREIGN KEY("dept_emp")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_mn" FOREIGN KEY("dept_mn")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--  Query * FROM Each Table to Confirm Data

SELECT * FROM public."Departments";
SELECT * FROM public."Employees";
SELECT * FROM public."Dept_emp";
SELECT * FROM public."Dept_manager";
SELECT * FROM public."Salaries";
SELECT * FROM public."Titles";

-- DATA ANALYSIS

--1. List the employee number, last name, first name, sex, and salary of each employee 

SELECT emp_no,last_name,first_name, sex FROM public."Employees";

SELECT salary FROM public."Salaries";
			
SELECT e.emp_no,last_name,first_name,sex,salary
FROM public."Employees" as e
JOIN public."Salaries" as s
ON e.emp_no = s.emp_no 
ORDER BY
emp_no;
		
--2. List the first name, last name, and hire date for the employees who were hired in 1986

SELECT first_name,
       last_name,
	   hire_date
	   FROM public."Employees"
       WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
  	
--3. List the manager of each department along with their department number, department name, employee number, last name, and first name 

SELECT dm.dept_mn
, d.dept_no
, d.dept_name
, e.emp_no
, e.last_name
, e.first_name
FROM public."Dept_manager" as dm
JOIN public."Departments" as d
ON d.dept_no = dm.dept_mn
JOIN public."Employees" as e
ON dm.emp_no = e.emp_no
ORDER BY
	emp_no;

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name

SELECT d.dept_no
, e.emp_no
, e.last_name
, e.first_name
, d.dept_name
FROM public."Departments" as d
JOIN public."Dept_emp" as de
ON d.dept_no = de.dept_no
JOIN public."Employees" as e
ON de.dept_emp = e.emp_no
ORDER BY
	emp_no;
	
--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex FROM public."Employees"

WHERE
	first_name='Hercules' and last_name like 'B%';
	
--6.List each employee in the Sales department, including their employee number, last name, and first name
	
SELECT d.dept_name
, e.emp_no
, e.last_name
, e.first_name
FROM public."Departments" as d
JOIN public."Dept_emp" as de
ON d.dept_no = de.dept_no
JOIN public."Employees" as e
ON de.dept_emp = e.emp_no
WHERE dept_name ='Sales'
ORDER BY
	emp_no;
	
	
--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT d.dept_name
, e.emp_no
, e.last_name
, e.first_name
FROM public."Departments" as d
JOIN public."Dept_emp" as de
ON d.dept_no = de.dept_no
JOIN public."Employees" as e
ON de.dept_emp = e.emp_no
WHERE dept_name ='Sales' or dept_name ='Development'
ORDER BY
	emp_no;
	
	

--8. In descending order, list the frequency count of the employee last names, i.e., how many employees share each last name.

SELECT 
        last_name,
COUNT
        (last_name) AS "frequency"
FROM
       public."Employees"
GROUP BY 
	last_name
ORDER BY
        COUNT(last_name) DESC;
