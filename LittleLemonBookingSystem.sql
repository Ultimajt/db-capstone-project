DELIMITER //
CREATE PROCEDURE CheckBooking(IN dt DATE, nota INT)
BEGIN
SELECT (CASE WHEN EXISTS(SELECT Date, TableNumber FROM Bookings WHERE Date = dt and TableNumber = nota) THEN "Table already booked" ELSE "Table is free" END) AS Booking_status;
END//
DELIMITER ;

CALL CheckBooking('2022-11-12', 3);

DELIMITER //
CREATE PROCEDURE AddValidBooking(IN dt DATE, nota INT)
BEGIN
SELECT (CASE WHEN EXISTS(SELECT Date, TableNumber FROM Bookings WHERE Date = dt and TableNumber = nota) THEN "Table already booked - order cancelled" ELSE "Table is free" END) AS Booking_status;
START TRANSACTION;
INSERT INTO Bookings(Date, TableNumber, StaffID, CustomerID) Values(dt, nota, 1, 1); 
CASE WHEN EXISTS (SELECT Date, TableNumber FROM Bookings WHERE Date = dt and TableNumber = nota) THEN ROLLBACK;
ELSE COMMIT;
END//
DELIMITER ;

CALL AddValidBooking('2022-12-17', 6);

DELIMITER //
CREATE PROCEDURE AddBooking(IN bki INT, dt DATE, nota INT, stf INT, cus INT)
BEGIN
INSERT INTO Bookings Values(bki, dt, nota, stf, cus);
END//
DELIMITER ;

CALL AddBooking(9, '2022-12-10', 5, 1, 1);

DELIMITER //
CREATE PROCEDURE UpdateBooking(IN bki INT, dt DATE)
BEGIN
UPDATE Bookings SET BookingID = bki, Date = dt WHERE BookingID = bki;
END//
DELIMITER ;

CALL UpdateBooking(9, '2022-12-12');

DELIMITER //
CREATE PROCEDURE CancelBooking(IN bki INT)
BEGIN
DELETE FROM Bookings WHERE BookingID = bki;
END//
DELIMITER ;

CALL CancelBooking(9);

