use AdventureWorks2012

EXEC sp_columns Person

select * from Person.Person
select * from Person.EmailAddress
select * from Person.PhoneNumberType
select * from Person.PersonPhone

--3. Perform the following with help of the above database:

--a. Get all the details from the person table including email ID, phone
--number and phone number type

select p.*,E.emailaddress,ph.phonenumber,pt.phonenumbertypeid from person.person P
join person.emailaddress E 
     on P.BusinessEntityID=E.BusinessEntityID
join person.PersonPhone ph
     on Ph.BusinessEntityID=E.BusinessEntityID
join person.phonenumbertype Pt
     on Ph.phonenumbertypeID=Pt.phonenumbertypeID


--b. Get the details of the sales header order made in May 2011

select * from sales.SalesOrderHeader

select * from sales.SalesOrderHeader where OrderDate between '2011/05/01' and '2011/05/31'  
.

/*c. Get the details of the sales details order made in the month of May 2011*/

select * from sales.SalesOrderDetail

select * from sales.SalesOrderDetail where ModifiedDate between '2011/05/01' and '2011/05/31'  

--d. Get the total sales made in May 2011

select  * from sales.SalesOrderHeader		

select sum(TotalDue) Total_sales from Sales.SalesOrderHeader where OrderDate between '2011/05/01' and '2011/05/31'  


--e. Get the total sales made in the year 2011 by month order by increasing sales

select  * from sales.SalesOrderHeader

select datepart(year,OrderDate) Sales_by_Year,
       datepart(month,OrderDate) Sales_by_Month,
	   sum(TotalDue) Total_Sales
	   from sales.SalesOrderHeader
	   where datepart(year,OrderDate)='2011'
	   group by datepart(year,OrderDate), datepart(month,OrderDate)
	   order by Total_Sales


--f. Get the total sales made to the customer with FirstName='Gustavo'
--and LastName ='Achong'select  * from sales.SalesOrderHeaderselect * from Person.Person where FirstName='Gustavo' and LastName ='Achong'select * from sales.SalesOrderDetailselect p.firstname,p.lastname,isnull(sum(sd.LineTotal),0) total_sales from person.person P full JOINsales.SalesOrderHeader S     ON P.BusinessEntityID=S.CustomerID full JOINsales.SalesOrderdetail Sd     ON sd.salesorderID=S.salesorderID	 where FirstName='Gustavo' and LastName ='Achong'	 GROUP BY p.firstname,p.lastname
