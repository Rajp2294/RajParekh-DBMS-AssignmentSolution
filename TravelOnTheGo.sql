create database TravelOnTheGo;
use TravelOnTheGo;

/* 1) You are required to create two tables PASSENGER and PRICE with the following attributes and properties */
CREATE TABLE IF NOT EXISTS Passenger (
    Passenger_Name VARCHAR(50),
    Category VARCHAR(15),
    Gender VARCHAR(1),
    Boarding_City VARCHAR(50),
    Destination_City VARCHAR(50),
    Distance INT,
    Bus_Type VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Price (
    Bus_Type VARCHAR(20),
    Distance INT,
    Price INT
);

/* 2) Insert the following data in the tables */
INSERT INTO Passenger VALUES("Sejal", "AC", "F", "Bengaluru", "Chennai", 350, "Sleeper");
INSERT INTO Passenger VALUES("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sitting");
INSERT INTO Passenger VALUES("Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper");
INSERT INTO Passenger VALUES("Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper");
INSERT INTO Passenger VALUES("Udit", "Non-AC", "M", "Trivandrum", "Panaji", 1000, "Sleeper");
INSERT INTO Passenger VALUES("Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting");
INSERT INTO Passenger VALUES("Hemant", "Non-AC", "M", "Panaji", "Mumbai", 700, "Sleeper");
INSERT INTO Passenger VALUES("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting");
INSERT INTO Passenger VALUES("Piyush", "AC", "M", "Pune", "Nagpur", 700, "Sitting");

INSERT INTO Price VALUES("Sleeper", 350, 770);
INSERT INTO Price VALUES("Sleeper", 500, 1100);
INSERT INTO Price VALUES("Sleeper", 600, 1320);
INSERT INTO Price VALUES("Sleeper", 700, 1540);
INSERT INTO Price VALUES("Sleeper", 1000, 2200);
INSERT INTO Price VALUES("Sleeper", 1200, 2640);
INSERT INTO Price VALUES("Sleeper", 1500, 2700);
INSERT INTO Price VALUES("Sitting", 500, 620);
INSERT INTO Price VALUES("Sitting", 600, 744);
INSERT INTO Price VALUES("Sitting", 700, 868);
INSERT INTO Price VALUES("Sitting", 1000, 1240);
INSERT INTO Price VALUES("Sitting", 1200, 1488);
INSERT INTO Price VALUES("Sitting", 1500, 1860);

/* 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s? */
SELECT 
    Gender, COUNT(Gender)
FROM
    Passenger
WHERE
    Distance >= 600
GROUP BY Gender;

/* 4) Find the minimum ticket price for Sleeper Bus */
SELECT 
    MIN(Price) AS Min_Ticket_Price
FROM
    Price
WHERE
    Bus_Type = 'Sleeper';

/* 5)Select passenger names whose names start with character 'S' */
SELECT 
    Passenger_Name
FROM
    Passenger
WHERE
    Passenger_Name LIKE 'S%';

/* 6) Calculate price charged for each passenger displaying Passenger name, Boarding City, 
Destination City, Bus_Type, Price in the output */
SELECT 
    Passenger_Name,
    Boarding_City,
    Destination_City,
    p.Bus_Type,
    m.Price
FROM
    Passenger p
        LEFT JOIN
    Price m ON p.Bus_Type = m.Bus_Type
        AND p.Distance = m.Distance;

/* 7) What are the passenger name/s and his/her ticket price who travelled in 
the Sitting bus for a distance of 1000 KM s */
SELECT 
    Passenger_Name, Price AS Ticket_Price
FROM
    Passenger p,
    Price m
WHERE
    p.Bus_Type = m.Bus_Type
        AND p.Distance = m.Distance
        AND p.Distance = 1000
        AND p.Bus_Type = 'Sitting';

-- No Passenger travelled in sitting bus for 1000kms of distance

/* 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to 
Panaji? */
SELECT 
    m.Bus_Type, m.Price
FROM
    Passenger p,
    Price m
WHERE
    p.Passenger_Name = 'Pallavi'
        AND p.Distance = m.Distance;

/* 9) List the distances from the "Passenger" table which are unique (non-repeated 
distances) in descending order */
SELECT 
    Distance
FROM
    Passenger
GROUP BY Distance
HAVING COUNT(Distance) = 1
ORDER BY Distance DESC;

/* 10) Display the passenger name and percentage of distance travelled by that passenger 
from the total distance travelled by all passengers without using user variables */
SELECT 
    p.Passenger_Name,
    (p.Distance / (SELECT 
            SUM(Distance)
        FROM
            passenger)) * 100 AS Percentage_Distance_Travelled
FROM
    Passenger p;

/* 11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise */
SELECT 
    Distance,
    Price,
    CASE
        WHEN Price > 1000 THEN 'Expensive'
        WHEN Price <= 1000 AND price > 500 THEN 'Average Cost'
        ELSE 'Cheap'
    END AS Price_Category
FROM
    Price; 

