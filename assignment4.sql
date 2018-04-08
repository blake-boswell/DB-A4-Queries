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
-- sysdate = current time
-- (Return_Date, 'd') = 6 OR 7 OR 1 (Weekend day) && sysdate - Return_Date <= 7
SELECT Count(Emp_ID) FROM Trip WHERE (TO_CHAR(Return_Date, 'd') = 1 OR TO_CHAR(Return_Date, 'd') >= 6) AND ((sysdate - Trip.Return_Date) <= 10 AND (sysdate - Trip.Return_Date) >= 0);

-- For all the receipts that were submitted in 2017, print the total amount for each expense type.  
-- The expense type must be spelled out rather than printing "T" or "H" or "M".  That is, 
-- print the total "Transportation" cost, total "Hotel" cost, and total "Meals" cost incurred in 2017.

SELECT DECODE(Expense.Type, 'T ', 'Transportation', 'H ', 'Hotel', 'M ', 'Meals'), SUM(Amount) FROM Expense WHERE TO_CHAR(Submitted, 'YYYY') = 2017 GROUP BY Expense.Type;
