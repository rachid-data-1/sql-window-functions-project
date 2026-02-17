Employee Performance Analysis
 Project Overview
SQL-based analysis of employee performance data across departments using window functions and advanced analytics.

 Dataset Schema

employee_performance (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    performance_month DATE,
    monthly_sales DECIMAL(10,2)
)
 Files
queries.sql - Complete SQL queries with analysis

analysi_sinsights.md - Detailed findings and recommendations

 Analysis Includes
Ranking: Monthly sales rankings by department

Comparisons: Month-over-month performance tracking

Averages: Department salary analysis

Cumulative: Running sales totals per employee

Top Performers: Monthly department leaders

Tiering: NTILE grouping of employees by sales

 Technologies
SQL (Window Functions: RANK, LAG, NTILE, ROW_NUMBER)

Aggregate Functions

Subqueries
