SELECT T1.Name AS Employee FROM Employee AS T1, Employee AS T2
WHERE T1.ManagerId = T2.Id 
AND T1.Salary > T2.Salary;
