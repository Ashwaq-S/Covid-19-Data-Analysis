use assignments_1_6

--Tasks To Be Performed:

--1. Use the inbuilt functions and find the minimum, maximum and average
---amount from the orders table

select max(amount) max_amount,min(amount) min_amount,avg(amount) avg_amount from orders

--2. Create a user-defined function which will multiply the given number with 10

drop function multiply
create function multiply(@input int)
returns int
as
begin
return (@input*10)
end

select dbo.multiply(10) multiply

select dbo.multiply(amount) new_amount from orders 


--3. Use the case statement to check if 100 is less than 200, greater than 200
---or equal to 200 and print the corresponding value. 

select
case
    when 100<200 then '100 is less than 200'
	when 100<200 then '100 is greater than 200'
	else '100 is equal to 200'
end as result



---4. Using a case statement, find the status of the amount. Set the status of the
---amount as high amount, low amount or medium amount based upon the
---condition.

select *,
case
    when amount>20000 then 'high amount'
	when amount>=10000 then 'medium amount'
	else 'low amount'
end as status
from orders




---5. Create a user-defined function, to fetch the amount greater than then given input.

create function amountgreaterthan(@input int)
returns table

return(select * from orders where amount>@input)

select * from amountgreaterthan(10000)