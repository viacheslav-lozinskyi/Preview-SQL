CREATE TABLE STATION
(ID INTEGER PRIMARY KEY,
CITY CHAR(20),
STATE CHAR(2),
LAT_N REAL,
LONG_W REAL);

CREATE TABLE Customers
(ID     INT IDENTITY(1, 1),
 Emp_ID INT,
 Name   VARCHAR(20),
 City   VARCHAR(20) NULL,
);

INSERT INTO Customers
       SELECT *
       FROM Employees;

INSERT INTO Customers (Emp_ID ,Name)
       SELECT *
       FROM Employees;

ALTER TABLE Employees
ADD Country varchar(50);


INSERT INTO STATION VALUES (13, 'Phoenix', 'AZ', 33, 112);
INSERT INTO STATION VALUES (44, 'Denver', 'CO', 40, 105);
INSERT INTO STATION VALUES (66, 'Caribou', 'ME', 47, 68);

UPDATE STATS SET RAIN_I = RAIN_I + 0.01;
Update Employees set Country='India'

INSERT INTO Customers
    (Emp_ID,
     Name
    )
    SELECT ID,Name
    FROM Employees;

INSERT TOP(1) INTO Customers
    (Emp_ID,
     Name
    )
    SELECT ID,Name
    FROM Employees;

INSERT TOP(1) INTO Customers (Emp_ID,  Name, City)
       SELECT ID, Name,'Delhi' FROM Employees;

DELETE FROM STATS
WHERE MONTH = 7
OR ID IN (SELECT ID FROM STATION
WHERE LONG_W < 90);

DELETE FROM STATION WHERE LONG_W < 90;

COMMIT WORK;