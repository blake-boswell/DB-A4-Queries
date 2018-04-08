-- Find the trips for which the departure date is a Friday.  For each such trip, print the corresponding employee name, 
-- day of departure and day of return both spelled out completely, 
-- and number of days between the departure and return

SELECT Employee.Name, TO_CHAR(Trip.Dep_Date, 'Day, Dd Month YYYY') AS Dep_Date, 
    TO_CHAR(Trip.Return_Date, 'Day, Dd Month YYYY') AS Return_Date, 
    (Trip.Return_Date - Trip.Dep_Date) AS Days_Gone 
FROM Trip JOIN Employee 
ON Employee.ID = Trip.Emp_ID 
WHERE TO_CHAR(Trip.Dep_Date, 'D') = 6;

-- Determine and print the total number of employees who returned from a trip during the last weekend.

SELECT Count(Emp_ID) 
FROM Trip 
WHERE (TO_CHAR(Return_Date, 'd') = 1 OR TO_CHAR(Return_Date, 'd') >= 6) 
    AND ((sysdate - Trip.Return_Date) <= 10 
        AND (sysdate - Trip.Return_Date) >= 0);

-- For all the receipts that were submitted in 2017, print the total amount for each expense type.  
-- The expense type must be spelled out rather than printing "T" or "H" or "M".  That is, 
-- print the total "Transportation" cost, total "Hotel" cost, and total "Meals" cost incurred in 2017.

SELECT DECODE(Expense.Type, 'T ', 'Transportation', 'H ', 'Hotel', 'M ', 'Meals'), SUM(Amount) 
FROM Expense 
WHERE TO_CHAR(Submitted, 'YYYY') = 2017 
    GROUP BY Expense.Type;

-- For every employee show the total number of trips he/she has taken.  
-- The output must show employee names and corresponding number of trips.  
-- If an employee has not taken any trip, print the employee's name and 0 (zero) next to his name.
SELECT Employee.Name, NVL(COUNT(Trip.ID), 0) FROM Employee LEFT JOIN Trip ON Employee.ID = Trip.Emp_ID GROUP BY Employee.Name ORDER BY Employee.Name; 
