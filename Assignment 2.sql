use Food_Delivery

select * from jomato

exec sp_help jomato

--Tasks to be performed:

--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick
--Chicken Bites’.

create Function QuickChickenBites(@input varchar(250))
RETURNS varchar(250)
 AS
Begin
		declare @output varchar(250)
		SET @output = replace(@INPUT,'Quick','Quick Chicken')
		RETURN @OUTPUT
END

SELECT dbo.QuickChickenBites('Quick bites')
select dbo.QuickChickenBites(restauranttype) as new_restauranttype from jomato
			

--2. Use the function to display the restaurant name and cuisine type which has the
---maximum number of rating.


select restaurantname,cuisinestype from Jomato where rating=(select max(rating) from Jomato)




/*3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
start rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
and below 3.5 and ‘Bad’ if it is below 3 star rating.*/


select RATING,
case
	when(Rating>4) then 'Excellent' 
	when(Rating<3) then 'Bad' 
	when(Rating between 3 and 3.5) then 'Average'
	else 'Good'
end as RatingStatus
from Jomato


/*4. Find the Ceil, floor and absolute values of the rating column and display the current date
and separately display the year, month_name and day.*/

SELECT CEILing(RATING) as ceil_rating,
	   floor(rating) as floor_rating,
	   ABS(rating) as Abs_rating,
	   getdate() as currentdate,
	   year(getdate()) as currentyear ,
	   datename(month,getdate()) currentmonth,
	   day(getdate()) as currentday
FROM JOMATO


---5. Display the restaurant type and total average cost using rollup.

select coalesce(RestaurantType,'Total') restauranttype,sum(averagecost) total_average_cost from Jomato group by restauranttype with rollup