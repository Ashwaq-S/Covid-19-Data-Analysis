use assignments_1_6

--Tasks To Be Performed:

---1. Create a view named ‘customer_san_jose’ which comprises of only those
---customers who are from San Jose

CREATE VIEW customer_san_jose
as
 select * from customer where city='san jose'


select * from customer_san_jose


---2. Inside a transaction, update the first name of the customer to Francis
---where the last name is Jordan:

begin transaction
update customer set last_name='francis' where last_name='jordan'
select * from customer

---a. Rollback the transaction

Rollback

---b. Set the first name of customer to Alex, where the last name is Jordan\

update customer set first_name ='Alex' WHERE LAST_NAME='Jordan'



---3. Inside a TRY... CATCH block, divide 100 with 0, print the default error message.


begin try
print(100/0)
end try

begin catch
print (error_message())
end catch



declare @error nvarchar(1000)
begin try
print(100/0)
end try
begin catch
set @error=error_message()
print @error
end catch





---4. Create a transaction to insert a new record to Orders table and save it

begin transaction

insert into orders values(13432,'01/02/2024',10000,1006)

commit transaction


select * from orders


