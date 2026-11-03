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

-- TASK 3---


-- Task 4----------

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





