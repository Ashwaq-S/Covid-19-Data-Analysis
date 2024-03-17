use google

DROP TABLE IF EXISTS SALESMAN
create table Salesman(salesmanID INT,SalesmanName VARCHAR(250),Commission Decimal(10,2),City VARCHAR(250),Age INT)

INSERT INTO Salesman 
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30)

SELECT * FROM SALESMAN

drop table if exists customer
create table Customer(SalesmanId INT,CustomerId INT,CustomerName VARCHAR(255),PurchaseAmount INT)

INSERT INTO Customer 
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545)

SELECT * FROM Customer

drop table if exists orders
CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money)

INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)

SELECT * FROM orders


--tasks to be performed

--1. Insert a new record in your Orders table.

INSERT INTO Orders Values 
(5002,4345,103,'2023-06-02',1000)


/*2. Add Primary key constraint for SalesmanId column in Salesman table. Add default
constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
column in Customer table. Add not null constraint in Customer_name column for the Customer table.*/


Alter table salesman 
ALTER COLUMN salesmanid int NOT NULL

Alter table salesman ADD CONSTRAINT PK_123 PRIMARY KEY(SALESMANID)

ALTER TABLE SALESMAN ADD CONSTRAINT DF_123 DEFAULT 'new york' for city

alter table DBO.customer WITH NOCHECK add CONSTRAINT FK_123 FOREIGN KEY(SALESMANID) REFERENCES DBO.SALESMAN(SALESMANID)

ALTER TABLE CUSTOMER
ALTER COLUMN CUSTOMERNAME VARCHAR(250) NOT NULL


/*3. Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase
amount value greater than 500.*/

SELECT * FROM CUSTOMER WHERE CustomerName LIKE '%n' and  PurchaseAmount > 500





/*4. Using SET operators, retrieve the first result with unique SalesmanId values from two
tables, and the other result containing SalesmanId with duplicates from two tables.*/

select salesmanID from Salesman
union
select salesmanID  from Customer

select salesmanID  from Salesman
union all
select salesmanID  from Customer



/*5. Display the below columns which has the matching data.
Orderdate, Salesman Name, Customer Name, Commission, and City which has the 
range of Purchase Amount between 500 to 1500.*/


SELECT O.Orderdate, S.SalesmanName, C.CustomerName, S.Commission,S.City 
		FROM SALESMAN S
		JOIN CUSTOMER C ON S.SALESMANID=C.SalesmanId 
		  JOIN ORDERS O  ON C.SalesmanId=O.SalesmanId
WHERE PurchaseAmount BETWEEN 500 AND 1500
       




--6. Using right join fetch all the results from Salesman and Orders table.SELECT * FROM SALESMAN S RIGHT JOIN Orders O ON S.salesmanID=O.SALESMANID


