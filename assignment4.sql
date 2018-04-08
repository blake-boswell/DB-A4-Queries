-- Q1
-- Find the trips for which the departure date is a Friday.  For each such trip, print the corresponding employee name, 
-- day of departure and day of return both spelled out completely, 
-- and number of days between the departure and return

SELECT Employee.Name, TO_CHAR(Trip.Dep_Date, 'Day, Dd Month YYYY') AS Dep_Date, 
    TO_CHAR(Trip.Return_Date, 'Day, Dd Month YYYY') AS Return_Date, 
    (Trip.Return_Date - Trip.Dep_Date) AS Days_Gone 
FROM Trip JOIN Employee 
ON Employee.ID = Trip.Emp_ID 
WHERE TO_CHAR(Trip.Dep_Date, 'D') = 6;

-- Q2
-- Determine and print the total number of employees who returned from a trip during the last weekend.

SELECT Count(Emp_ID) 
FROM Trip 
WHERE (TO_CHAR(Return_Date, 'd') = 1 OR TO_CHAR(Return_Date, 'd') >= 6) 
    AND ((sysdate - Trip.Return_Date) <= 10 
        AND (sysdate - Trip.Return_Date) >= 0);

-- Q3
-- For all the receipts that were submitted in 2017, print the total amount for each expense type.  
-- The expense type must be spelled out rather than printing "T" or "H" or "M".  That is, 
-- print the total "Transportation" cost, total "Hotel" cost, and total "Meals" cost incurred in 2017.

SELECT DECODE(Expense.Type, 'T ', 'Transportation', 'H ', 'Hotel', 'M ', 'Meals'), SUM(Amount) 
FROM Expense 
WHERE TO_CHAR(Submitted, 'YYYY') = 2017 
    GROUP BY Expense.Type;

-- Q4
-- For every employee show the total number of trips he/she has taken.  
-- The output must show employee names and corresponding number of trips.  
-- If an employee has not taken any trip, print the employee's name and 0 (zero) next to his name.
SELECT Employee.Name, NVL(COUNT(Trip.ID), 0) FROM Employee LEFT JOIN Trip ON Employee.ID = Trip.Emp_ID GROUP BY Employee.Name ORDER BY Employee.Name; 

-- Q5
-- Assume that receipts are due within 10 days of completion of a trip.  For example, if an employee returned from a trip on March 17, 2018, 
-- he/she must submit the receipts by March 27, 2018.  Create a view titled "Defaulters" that shows the employee name, the return date, 
-- and the number of days it has been since the return date for each employee that has violated the receipt submission policy.
CREATE VIEW Defaulters AS (
    SELECT Employee.name, Trip.Return_Date, (sysdate - Trip.Return_Date) AS Days_Since_Return
    FROM Trip JOIN Employee 
        ON Trip.Emp_ID = Employee.ID 
        JOIN Expense 
        ON Trip.ID = Expense.Trip_ID 
        WHERE Expense.Submitted > Trip.Return_Date + 10
);

-- Debug records for Query 5
-- On the 10 day limit
INSERT INTO Expense VALUES(19, 1, 25, 'H', '10-MAY-2018');
-- Out of the 10 day limit
INSERT INTO Expense VALUES(18, 1, 25, 'H', '10-MAY-2018');
-- After 11 days
INSERT INTO Expense VALUES(19, 2, 50, 'T', '11-MAY-2018');
-- After 9 days
INSERT INTO Expense VALUES(19, 3, 85, 'M', '09-MAY-2018');

