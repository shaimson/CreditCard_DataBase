use CreditCard
go 

select *
from CreditCard

select *
from Purchases

--Toby: 1,4,7,10,13,16,19
--Dina: 2,5,8,11,14,17,20

--1. For each CreditCard, list the CreditCard ID, Name of the Company that Issued the Card and the 
--total $ amount of purchases that were made using the CreditCard

select CreditCard.CreditCardNum,Company, isnull(sum(amount),0) as AmountOfPurchases
from CreditCard
left join Purchases on Purchases.CreditCardNum=CreditCard.CreditCardNum
group by CreditCard.CreditCardNum,Company

--2. For each month of the year 2021, list the total $ amount of 
--purchases that were made for Food.  Include all Food Purchases made for all CreditCards.

select year([Date]),
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 1) As January,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 2) As February,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 3) As March,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 4) As April,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 5) As May,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 6) As June,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 7) As July,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 8) As August,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 9) As September,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 10) As October,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 11) As November,
	(select sum(isnull(amount, 0))
	from Purchases
		inner join PurchaseTypes
		on PurchaseTypes.TypeId = purchases.PurchaseType
	where ValidType = 'FOOD' 
	group by month([date])
	having month(date) = 12) As December
from Purchases
group by year([Date])
having year([Date]) = 2021


--4. List the ID and Company that issued the Card for any CreditCard that will be expiring during the 
--current year.

select CreditCardNum, Company
from CreditCard
where year(ExpirationDate)=2022

--5. For each CreditCard list the CreditCard ID and the Company that 
--issued the card and the amount of years that the individual has had this CreditCard. 

select CreditCardNum, Company, DATEDIFF(year, IssueDate, getDate()) As NumYears
from CreditCard

--7. What is the total amount of LateFees that have been incurred?

select sum(Amount) as amountLateFees
from Fees
inner join feeType on feetype.FeeTypeID=fees.FeeType
where Feetype.FeeType like 'LatePayment'

--8. What is the amount of the largest Purchase that was ever charged to any CreditCard?

select max(Amount) As [Biggest Purchase]
from purchases

--10. Given a specific Vendor and Year, list the total $ amount of purchases made from that Vendor 
--during that year. 

Select sum(Amount) as amountVendor
from Purchases
inner join Vendors on Vendors.vendorID=Purchases.Vendor
where vendor=1324 and year(date)=2020

--11. List the name of the Vendor for which the largest total $ amount
--of Purchases have been made during a given year. The year can be any year  (your choice) 

select VendorName, sum(amount) As[Highest vendor total for 2019]
from Vendors
inner join Purchases
on Purchases.Vendor = Vendors.VendorID
group by VendorName
having sum(amount) = 
	(select max(VendorTotal) 
		from (select sum(amount) VendorTotal
		from Purchases
		where year([Date]) = 2019
		group by Vendor) EachVendorTotal)

--13. Which CreditCards have incurred LateFees during a given month / year? List the CreditCard ID 
--and name of the Company that issued the CreditCard.

Select distinct CreditCard.CreditCardNum, Company
from CreditCard
inner join Fees on Fees.CreditCardNum=CreditCard.CreditCardNum
inner join feeType on feetype.FeeTypeID=fees.FeeType
where Feetype.FeeType like 'LatePayment' and year(dateapplied)=2020

--14. List the total amount spent for all types of Purchases for all Credit Cards. 
--Include in the same results the subtotals for each CreditCard for each type of 
--Purchase, the subtotals for each type of Purchase across all CreditCards  
--(you may have to research rollup and cube to write this query).  
--Include CreditCard that weren’t used and all types of Purchases, even if that type of Purchase hasn’t occurred.

select distinct Purchases.CreditCardNum,
	 PurchaseTypes.ValidType,
	isnull(sum(amount), 0) as totals
from CreditCard
	left join Purchases
	on Purchases.CreditCardNum = CreditCard.CreditCardNum 
	right join PurchaseTypes
	on  PurchaseTypes.typeId = Purchases.PurchaseType 	 
group by cube(Purchases.CreditCardNum, PurchaseTypes.ValidType)
order by  Purchases.CreditCardNum, ValidType 

--16. For each Vendor, list the vendor name and what are the total purchases for each month of the 
--current year. Include the $ amount for each month on the same row as the Vendor name, 
--flattening the data instead of presenting them on different rows.

select *
from Purchases

select VendorName,
   ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 1 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As JanPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 2 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As FebPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 3 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As MarPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 4 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As AprPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 5 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As MayPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 6 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As JunePurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 7 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As JulyPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 8 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As AugPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 9 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As SeptPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 10 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As OctPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 11 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As NovPurchases,
      ( select isnull(sum(Amount),0)
      from Purchases
   where month(Date) = 12 and year(date)=2022
     and Purchases.Vendor=
   Vendors.VendorID  )As DecPurchases
from Vendors


--17.	List the name(s) of each Vendor from whom the individual has purchased ALL the same types of Purchases as Vendor “ShopRite”

select distinct AllPurchases.VendorName
from
	(select  VendorName, PurchaseType
	from Purchases
	inner join Vendors
	on Purchases.Vendor = Vendors.VendorId) As AllPurchases
		inner join
		(select PurchaseType
		from Purchases
			inner join Vendors
			on Purchases.Vendor = Vendors.VendorId
		where VendorName = 'Shop Rite') As ShopRitePurchases
		on AllPurchases.PurchaseType = ShopRitePurchases.PurchaseType


--19. List the category (type of Purchase) of Purchase for which no Purchases were made during a 
--given month/year

select ValidType 
from PurchaseTypes
where TypeID not in(
select PurchaseType
from Purchases
where year([date]) = 2019)


--Query 20.	 For each CreditCard , if the CreditCard hasn’t been used for Purchases in the past 3 months, list INACTIVE, if CreditCard has been used for at least one 
--Purchase in the past 3 months, list ACTIVE, if the CreditCard has been used for more than 10 Purchases in the last 3 months, list VERY ACTIVE, 

select CreditCardNum,
case
	when datediff(month, MostRecentPurchase, getDate()) > 3 then 'INACTIVE'
	when datediff(month, MostRecentPurchase, getDate()) <= 3 and NumPurchases <=10 then 'ACTIVE'
	when datediff(month, MostRecentPurchase, getDate()) <= 3 and NumPurchases > 10 then 'VERY ACTIVE'
end As CardStatus
from 
(select CreditCardNum, max([Date]) As MostRecentPurchase, count(PurchaseNum) As NumPurchases
from Purchases
group by CreditCardNum) As LatestPurchases



