use Food_Delivery

exec sp_help jomato

select * from jomato

--Tasks to be performed:

/*1. Create a stored procedure to display the restaurant name, type and cuisine where the
table booking is not zero.*/

drop procedure  if exists display

create proc Display
as
BEGIN
select restaurantname,restauranttype,CuisinesType 
from Jomato
where tablebooking !=0
END

exec Display

/*2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result
and rollback it.*/

begin transaction
UPDATE JOMATO
SET CuisinesType =replace(CUISINESTYPE,'Cafe','Cafeteria')
select CuisinesType from jomato

ROLLBACK
 

--3. Generate a row number column and find the top 5 areas with the highest rating of
--restaurants.

WITH CTE AS
(
SELECT AREA,RATING,
ROW_NUMBER()OVER(PARTITION BY AREA ORDER BY RATING DESC) AS rownumber
FROM Jomato
)

SELECT
AREA,RATING,rownumber
	FROM CTE
WHERE rownumber <= 5


--4. Use the while loop to display the 1 to 50.


DECLARE @VAR INT
SELECT @VAR=1

WHILE @VAR<=50
BEGIN
PRINT(@VAR)
SET @VAR=@VAR+1
END


/*5. Write a query to Create a Top rating view to store the generated top 5 highest rating of
restaurants.*/


CREATE VIEW TopRating
AS
select TOP 5* from jomato order by rating desc


SELECT * FROM TopRating


/*6. Write a trigger that sends an email notification to the restaurant owner whenever a new
record is inserted*/

create trigger Email_Notification
on jomato
after insert
as
begin
Declare @ownersemail varchar(100),@restaurantname varchar(100)

select @ownersemail='ash@gmail.com,', @restaurantname=restaurantname from inserted

DECLARE @Subject NVARCHAR(255);
    SET @Subject = 'New Record Inserted for ' + @RestaurantName;

    DECLARE @Body NVARCHAR(MAX);
    SET @Body = 'A new record has been inserted for your restaurant ' + @RestaurantName + '.';

    
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name =mail_profile,
        @recipients = @OwnersEmail,
        @subject = @Subject,
        @body = @Body,
        @body_format = 'HTML'; 
end

begin transaction 
insert into Jomato values(9999,'a','Quick Bites',3.90000009536743,48,400,1,0,'Fast Food, Beverages','Byresandra,Tavarekere,Madiwala',
'HSR',60)

exec sp_configure 
SELECT * FROM sys.configurations WHERE name = 'Database Mail XPs'
EXEC msdb.dbo.sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC msdb.dbo.sp_configure 'Database Mail XPs', 1;
RECONFIGURE;