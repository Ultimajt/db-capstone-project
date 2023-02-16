show databases;
use littlelemondb;
show tables;
CREATE VIEW OrdersView As SELECT OrderID, Quantity, TotalCost From Orders;
Select * from OrdersView;
Select C.CustomerID, Concat(C.FirstName," ", C.LastName) AS FullName, O.OrderID, M.Price, M.Name, MI.CourseName FROM Orders AS O INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID INNER JOIN Menu AS M ON O.MenuID = M.MenuID Inner JOIN MenuItem AS MI ON M.ItemID = MI.ItemID;
SELECT Name From Menu Where MenuID >= Any (Select MenuID FROM Orders WHERE Quantity >2); 

DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(Quantity) FROM Orders;
END//
DELIMITER ;

CALL GetMaxQuantity();

PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = (?)';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;

DELIMITER //
CREATE PROCEDURE CancelOrder(IN oid INT)
BEGIN
DELETE FROM Orders WHERE OrderID = oid;
END//
DELIMITER ;

CALL CancelOrder(5);
