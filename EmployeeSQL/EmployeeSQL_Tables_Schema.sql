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
