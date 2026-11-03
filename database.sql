


CREATE DATABASE EmployeeManagement;

USE EmployeeManagement;



CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    designation VARCHAR(100),
    basic_salary DECIMAL(10,2),
    joining_date DATE,
    status VARCHAR(20)
);



INSERT INTO Employees
(employee_id, employee_name, department, designation,
 basic_salary, joining_date, status)
VALUES
(101, 'Rahul Sharma', 'IT', 'Software Developer', 55000, '2023-01-15', 'Active'),
(102, 'Priya Patil', 'HR', 'HR Executive', 35000, '2022-06-10', 'Active'),
(103, 'Amit Verma', 'IT', 'Senior Developer', 75000, '2021-03-20', 'Active'),
(104, 'Sneha Gupta', 'Finance', 'Accountant', 28000, '2023-08-05', 'Active'),
(105, 'Rohan Mehta', 'Sales', 'Sales Executive', 45000, '2022-11-12', 'Inactive'),
(106, 'Neha Singh', 'IT', 'Database Administrator', 62000, '2020-09-18', 'Active'),
(107, 'Karan Shah', 'HR', 'HR Manager', 68000, '2019-04-25', 'Active'),
(108, 'Pooja Desai', 'Finance', 'Finance Manager', 85000, '2018-07-14', 'Active'),
(109, 'Vikas Kumar', 'Sales', 'Sales Manager', 72000, '2020-12-01', 'Active'),
(110, 'Anjali Rao', 'Marketing', 'Marketing Executive', 25000, '2024-02-11', 'Active'),
(111, 'Mohit Jain', 'IT', 'Junior Developer', 29000, '2024-05-19', 'Inactive'),
(112, 'Divya Nair', 'Marketing', 'Marketing Manager', 61000, '2021-10-30', 'Active');


SELECT * FROM Employees;

-- TASK 1

DELIMITER //
CREATE PROCEDURE GetEmployeeSalaryReport(
    IN department_name VARCHAR(50),
    IN minimum_salary DECIMAL(10,2)
)
BEGIN

    SELECT
        employee_id,
        employee_name,
        department,
        designation,
        basic_salary,
        joining_date
    FROM Employees
    WHERE department = department_name
      AND basic_salary >= minimum_salary
      AND status = 'Active';

END //

DELIMITER ;

CALL GetEmployeeSalaryReport('IT', 50000);



---- TASK 2 

DELIMITER //

CREATE PROCEDURE CalculateEmployeeSalary(
    IN emp_id INT
)
BEGIN



    IF EXISTS (
        SELECT 1
        FROM Employees
        WHERE employee_id = emp_id
    ) THEN

        SELECT
            employee_name,
            basic_salary,

            basic_salary * 0.20 AS HRA,

            basic_salary * 0.10 AS DA,

            basic_salary * 0.12 AS PF,

            basic_salary
            + (basic_salary * 0.20)
            + (basic_salary * 0.10)
            - (basic_salary * 0.12) AS Net_Salary

        FROM Employees
        WHERE employee_id = emp_id;

    ELSE

        SELECT 'Employee ID does not exist'
        AS Message;

    END IF;

END //

DELIMITER ;



CALL CalculateEmployeeSalary(101);


DELIMITER //



-- Bonus Task

CREATE PROCEDURE GetDepartmentSummary(
    IN department_name VARCHAR(50)
)
BEGIN

    -- Check whether department exists

    IF EXISTS (
        SELECT 1
        FROM Employees
        WHERE department = department_name
    ) THEN

        SELECT
            department,
            COUNT(employee_id) AS Total_Employees,
            ROUND(AVG(basic_salary), 2) AS Average_Salary,
            MAX(basic_salary) AS Highest_Salary,
            MIN(basic_salary) AS Lowest_Salary,
            SUM(basic_salary) AS Total_Salary_Expenditure

        FROM Employees
        WHERE department = department_name
        GROUP BY department;

    ELSE

        SELECT
            CONCAT(
                'Department ',
                department_name,
                ' does not exist.'
            ) AS Message;

    END IF;

END //

DELIMITER ;

CALL GetDepartmentSummary('IT');

CALL GetDepartmentSummary('Legal');



