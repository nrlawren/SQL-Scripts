-- Lab 4 Script
-- Nash Lawrence 2/10/22

USE projectexercise;

-- create primary key for project table
ALTER TABLE project
ADD PRIMARY KEY(Proj_Num);

-- create primary key for employee table
ALTER TABLE employee
ADD PRIMARY KEY(Emp_Num);

-- create primary key for jobclass table
ALTER TABLE jobclass
ADD PRIMARY KEY(job_class_code(3));

-- create composite primary key for assignment table
ALTER TABLE assignment
ADD constraint pkc_Name PRIMARY KEY(Proj_Num, Emp_Num);

ALTER TABLE employee MODIFY Job_Class_Code VARCHAR(3);
ALTER TABLE jobclass MODIFY Job_Class_Code VARCHAR(3);

-- Create foreign keys
ALTER TABLE assignment
ADD CONSTRAINT FK_emp_num FOREIGN KEY(Emp_Num)
REFERENCES employee(Emp_Num);

ALTER TABLE assignment
ADD CONSTRAINT FK_proj_num FOREIGN KEY(Proj_Num)
REFERENCES project(Proj_Num);

ALTER TABLE employee
ADD CONSTRAINT Fk_job_class_code FOREIGN KEY(Job_Class_Code)
REFERENCES jobclass(Job_Class_Code);

-- Count the number of projects
SELECT Count(*) AS 'CountofProjects'
FROM project;

-- Count projects using an electrical engineer
SELECT COUNT(Proj_Num) AS 'Count of Projects using an Electrical Engineer'
FROM assignment, employee
WHERE assignment.Emp_Num = employee.Emp_Num
AND Job_Class_Code = 'EE';

-- Calculate the total number of charges per project
SELECT proj_name, FORMAT(SUM(hourly_chargeout_rate*hours_charged),2) AS
Project_Charges
FROM assignment, project, jobclass, employee
WHERE assignment.proj_num = project.proj_num
AND assignment.emp_num = employee.emp_num
AND employee.job_class_code = jobclass.job_class_code
GROUP BY proj_name
ORDER BY proj_name;

-- Display the sum of project charges grouped by employee
SELECT emp_lname, emp_fname,
ROUND(SUM(hourly_chargeout_rate*hours_charged),2) AS Project_Charges
FROM assignment, project, jobclass, employee
WHERE assignment.proj_num = project.proj_num
AND assignment.emp_num = employee.emp_num
AND employee.job_class_code = jobclass.job_class_code
GROUP BY emp_lname, emp_fname
ORDER BY Project_Charges DESC;

-- Display charge amounts to each project grouped by project
SELECT Proj_Num, FORMAT(SUM(Hours_Charged*Hourly_Chargeout_Rate),2) AS 'ProjectCharges',
	(SELECT FORMAT(SUM(Hours_Charged*Hourly_Chargeout_Rate),2)
    FROM project AS p, assignment AS a, jobclass AS j, employee as e
    WHERE p.Proj_Num = a.Proj_Num
    AND j.Job_Class_Code = e.Job_Class_Code
    AND a.Emp_Num = e.Emp_Num) AS 'AllProjectCharges'
FROM employee, assignment, jobclass
WHERE employee.Emp_Num = assignment.Emp_Num
AND employee.Job_Class_Code = jobclass.Job_Class_Code
GROUP BY Proj_Num;

-- count number of employees in the dataset
SELECT Count(*) FROM employee;

-- counts employees whose job class code is Programmer (PR)
SELECT Count(*) FROM employee WHERE Job_Class_Code = 'PR';

-- list employees with PR job class and assigned to a project
SELECT DISTINCT Emp_FName, Emp_MName, Emp_LName
FROM employee, assignment
WHERE employee.Emp_Num = assignment.Emp_Num
AND Job_Class_Code = 'PR';

-- Extract and group total count of employees by job class code
SELECT Job_Class_Desc, count(Emp_Num) AS EmployeeCount
FROM jobclass, employee
WHERE jobclass.Job_Class_Code = employee.Job_Class_Code
GROUP BY Job_Class_Desc
ORDER BY EmployeeCount DESC;

-- extract total count of employees by project
SELECT Proj_Name, count(Emp_Num) AS EmployeesOnProject
FROM project, assignment
WHERE project.Proj_Num = assignment.Proj_Num
GROUP BY Proj_Name
ORDER BY EmployeesOnProject DESC;

-- show which job class has the highest total project charges
SELECT jobclass.job_class_code, ROUND(SUM(hourly_chargeout_rate*hours_charged),2)
AS Project_Charges
FROM assignment, project, jobclass, employee
WHERE assignment.proj_num = project.proj_num
AND assignment.emp_num = employee.emp_num
AND employee.job_class_code = jobclass.job_class_code
GROUP BY  job_class_code
ORDER BY project_charges DESC;

-- show average project charges 
SELECT jobclass.job_class_code, ROUND(AVG(hourly_chargeout_rate*hours_charged),2)
AS Average_Project_Charges
FROM assignment, project, jobclass, employee
WHERE assignment.proj_num = project.proj_num
AND assignment.emp_num = employee.emp_num
AND employee.job_class_code = jobclass.job_class_code
GROUP BY  job_class_code
ORDER BY Average_project_charges DESC;

-- Inner Join method
SELECT employee.Emp_FName AS 'EmployeeName', assignment.Emp_Num AS 'EmployeedID', SUM(assignment.Hours_Charged) AS TotalHours
FROM employee INNER JOIN assignment
ON employee.Emp_Num = assignment.Emp_Num
GROUP BY employee.Emp_FName
HAVING TotalHours > 25.0
ORDER BY employee.Emp_FName, assignment.Hours_Charged;

-- Q15: specify the amount of projects that use a Programmer (PR) and the employees name associated
SELECT employee.Emp_FName AS EmployeeName, Count(Proj_Num) AS 'Count of Projects using coders'
FROM employee, assignment
WHERE employee.Emp_Num = assignment.Emp_Num
AND employee.Job_Class_Code = 'PR'
GROUP BY EmployeeName;
