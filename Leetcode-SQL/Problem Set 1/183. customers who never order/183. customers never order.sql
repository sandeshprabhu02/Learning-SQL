SELECT Customers.Name AS Customers FROM Customers
LEFT JOIN Orders
ON Customers.Id = Orders.CustomerId
WHERE Orders.Id IS NULL; 





SELECT Customers.Name AS Customers FROM Customers 
WHERE NOT EXISTS (SELECT 1 FROM Orders 
WHERE Customers.Id = Orders.CustomerId);





SELECT Customers.Name AS Customers FROM Customers
WHERE Customers.Id NOT IN (SELECT Orders.CustomerId FROM Orders);

