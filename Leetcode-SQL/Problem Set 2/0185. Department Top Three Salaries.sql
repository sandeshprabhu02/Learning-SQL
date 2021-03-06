/*
185. Department Top Three Salaries
The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Explanation:

In IT department, Max earns the highest salary, both Randy and Joe earn the second highest salary, and Will earns the third highest salary. There are only two employees in the Sales department, Henry earns the highest salary while Sam earns the second highest salary.
*/
-- Solution 1:
SELECT d.Name AS Department,
       temp.Name AS Employee,
       temp.Salary
FROM
    ( SELECT Name,
             Salary,
             DepartmentId,
             DENSE_RANK() OVER(PARTITION BY DepartmentId
                                ORDER BY Salary DESC) AS rank
     FROM Employee
     WHERE rank <= 3 ) AS temp
JOIN Department AS d ON temp.DepartmentId = d.Id
GROUP BY d.Name
ORDER BY temp.Salary;

-- Solution 2
Select dep.Name as Department,
       emp.Name as Employee,
       emp.Salary
from Department dep,
     Employee emp
where emp.DepartmentId=dep.Id
    and
        (Select count(distinct Salary)
         From Employee
         where DepartmentId=dep.Id
             and Salary>emp.Salary)<3