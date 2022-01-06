use CreditCard
go 

select *
from CreditCard

select *
from Purchases

--Toby: 1,4,7,10,13,16,19

--1. For each CreditCard, list the CreditCard ID, Name of the Company that Issued the Card and the 
--total $ amount of purchases that were made using the CreditCard

select CreditCard.CreditCardNum,Company, isnull(sum(amount),0) as AmountOfPurchases
from CreditCard
left join Purchases on Purchases.CreditCardNum=CreditCard.CreditCardNum
group by CreditCard.CreditCardNum,Company


--4. List the ID and Company that issued the Card for any CreditCard that will be expiring during the 
--current year.
select CreditCardNum, Company
from CreditCard
where year(ExpirationDate)=2022

--7. What is the total amount of LateFees that have been incurred?
select sum(Amount) as amountLateFees
from Fees
inner join feeType on feetype.FeeTypeID=fees.FeeType
where Feetype.FeeType like 'LatePayment'



--10. Given a specific Vendor and Year, list the total $ amount of purchases made from that Vendor 
--during that year. 

Select sum(Amount) as amountVendor
from Purchases
inner join Vendors on Vendors.vendorID=Purchases.Vendor
where vendor=1324 and year(date)=2020

--13. Which CreditCards have incurred LateFees during a given month / year? List the CreditCard ID 
--and name of the Company that issued the CreditCard.

Select distinct CreditCard.CreditCardNum, Company
from CreditCard
inner join Fees on Fees.CreditCardNum=CreditCard.CreditCardNum
inner join feeType on feetype.FeeTypeID=fees.FeeType
where Feetype.FeeType like 'LatePayment' and year(dateapplied)=2020



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


--19. List the category (type of Purchase) of Purchase for which no Purchases were made during a 
--given month/year

select ValidType 
from PurchaseTypes
where TypeID not in(
select PurchaseType
from Purchases
where year([date]) = 2019)



