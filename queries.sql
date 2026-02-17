-- salary ranking
SELECT 
    performance_month,
    emp_id,
    emp_name,
    department,
    salary,
    RANK() OVER (
        PARTITION BY performance_month 
        ORDER BY monthly_sales DESC  
    ) as sales_rank_for_month
FROM employee_performance
ORDER BY performance_month, sales_rank_for_month;

--average salary
SELECT 
    emp_id,
    emp_name,
    department,
    salary,
    performance_month,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
FROM employee_performance
ORDER BY department, performance_month;

-- compare monthly sales with the previous month's sales 
SELECT
    emp_id,
    emp_name,
    department,
    performance_month,
    monthly_sales,
    LAG(monthly_sales) OVER (
        PARTITION BY emp_id
        ORDER BY performance_month
    ) AS prev_month_sales,
    monthly_sales - LAG(monthly_sales) OVER (
        PARTITION BY emp_id
        ORDER BY performance_month
    ) AS sales_diff
FROM employee_performance
ORDER BY emp_id, performance_month;

--Dividing the employees within each department into 3 levels based on their total sales.
select
  emp_id,
  emp_name,
  department,
  total_sales,
  ntile(3) over(partition by department order by monthly_sales_globale DESC ) as groupes
from(
  select
    emp_id,
    emp_name,
    department,
    sum(monthly_sales) as total_sales 
  from employee_performance
  group by emp_id,emp_name,department)t
ORDER BY department,groupes;

-- the cumulative (running) sales total for each employee across months.
SELECT 
    emp_id,
    emp_name,
    department,
    performance_month,
    monthly_sales,
    SUM(monthly_sales) OVER (
        PARTITION BY emp_id 
        ORDER BY performance_month
    ) AS cumulative_sales,
    ROUND(
        monthly_sales * 100.0 / SUM(monthly_sales) OVER (PARTITION BY emp_id),
        2
    ) AS monthly_percentage
FROM employee_performance
ORDER BY emp_id, performance_month;

--the top performer (highest monthly sales) in each department for each month.
SELECT
    emp_id,
    emp_name,
    department,
    performance_month,
    monthly_sales
FROM (
    SELECT
        emp_id,
        emp_name,
        department,
        performance_month,
        monthly_sales,
        ROW_NUMBER() OVER (
            PARTITION BY department, performance_month
            ORDER BY monthly_sales DESC
        ) AS rn
    FROM employee_performance
) t
WHERE rn = 1
ORDER BY performance_month, department;

--For each month, the employees whose sales are above the department's average sales for that month.
SELECT * from(
  select
    emp_id,
    emp_name,
    department,
    monthly_sales,
    performance_month,
    avg(monthly_sales) over( 
    partition by performance_month,department
    
   )as average_sales
  from  employee_performance
)t
where monthly_sales > average_sales
ORDER BY performance_month, department, monthly_sales DESC;





















