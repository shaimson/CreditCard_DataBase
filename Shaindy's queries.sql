use creditCard 
go

--3.
select validType, 
sum(case when month([Date]) = 1  and year([date]) = 2021 then Purchases.amount else 0 END) As [JanPurchases],
  sum (case when month([Date])= 2 and year([date]) = 2021 then Purchases.amount else 0 END) as [FebPurchases],
  sum (case when month([Date])= 3 and year([date]) = 2021 then Purchases.amount else 0 END ) as [MarchPurchases],
  sum (case when month([Date])= 4  and year([date]) = 2021 then Purchases.amount else 0 end) as [AprilPurchases],
  sum (case when month([Date])= 5  and year([date]) = 2021 then Purchases.amount else 0 end) as [MayPurchase],
  sum (case when month([Date])= 6  and year([date]) = 2021 then Purchases.amount else 0 END) As [JunPurchases],
  sum (case when month([Date])= 7  and year([date]) = 2021 then Purchases.amount else 0 END) As [JulyPurchases],
  sum (case when month([Date])= 8  and year([date]) = 2021 then Purchases.amount else 0 END) As [AugPurchases],
  sum (case when month([Date])= 9  and year([date]) = 2021 then Purchases.amount else 0 END) As [SeptPurchases],
  sum (case when month([Date])= 10 and year([date]) = 2021 then Purchases.amount else 0 END) As [OctPurchases],
  sum (case when month([Date])= 11 and year([date]) = 2021  then Purchases.amount else 0 END) As [NovPurchases],
  sum (case when month([Date])= 12 and year([date]) = 2021 then Purchases.amount else 0 END) As [DecPurchases]
  from PurchaseTypes
	left join Purchases
		on PurchaseTypes.TypeID = Purchases.PurchaseType
			group by validType
			
--6. 
select count(distinct purchaseType) as [Number of Purchase Types]
from Purchases

--9.
select creditcard.creditcardnum,(
	select isnull(sum(amount),0) from purchases
	where month([date])=1  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum)as JanPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=2  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as FebPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=3  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as MarPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=4  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as AprPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=5  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as MayPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=6  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as JunePurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=7  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as JulPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=8  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as AugPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=9  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as SeptPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=10  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as OctPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=11  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as NovPurchases,(
	select isnull(sum(amount),0) from purchases
	where month([date])=12  and year(date)= year(getdate()) and purchases.CreditCardNum= creditcard.creditcardnum) as DecPurchases,(
	select isnull(sum(PaymentAmount),0) from payment 
	where month(paymentdate)=1 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as JanPayment,( 
	select isnull(sum(PaymentAmount),0) from Payment
	where month(paymentdate)=2 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as FebPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=3 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as MarPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=4 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as AprPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=5 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as MayPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=6 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as JunePayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=7 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as JulyPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=8 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as AugPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=9 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as SeptPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=10 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as OctPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=11 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as NovPayment,(
	select isnull(sum(PaymentAmount),0) from payment
	where month(paymentdate)=12 and year(paymentdate)= year(getdate()) and Payment.CreditCardNum=CreditCard.CreditCardNum) as DecPayment,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=1 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as JanFees,(
	select isnull(sum(amount),0) from Fees 
	where month(dateapplied)=2 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as FebFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=3 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as MarFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=4 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as AprilFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=5 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as MayFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=6 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as JuneFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=7 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as JulyFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=8 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as AugFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=9 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as SeptFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=10 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as OctFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=11 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as NovFees,(
	select isnull(sum(amount),0) from fees
	where month(dateapplied)=12 and year(dateapplied)= year(getdate()) and fees.CreditCardNum=CreditCard.CreditCardNum) as DecFees
from CreditCard
			
--12.	
select validType as LowestPurchaseAmountTypeIn2021
from PurchaseTypes
inner join Purchases 
	on PurchaseTypes.TypeId = Purchases.PurchaseType
where year([date]) = 2021 
group by validType,PurchaseType
having sum(amount) = 
(select min(SumAmnt) 
from 
(select sum(amount) as SumAmnt
from Purchases
where year([Date]) = 2021
group by PurchaseType) Amnts)

--15.	
select VendorName, VendorStreet, VendorCity, VendorState, VendorZip, isnull(sum(amount),0) as TotalPurchases
from Vendors
left join Purchases
	on Vendors.VendorId = Purchases.Vendor
	group by VendorName, VendorStreet, VendorCity, VendorState, VendorZip

--18.
select distinct VendorName 
from (
select VendorID, VendorName
from Vendors
where VendorZip in ('30312', '27401', '10001')) Vendors1
	inner join Purchases	
		on Vendors1.VendorID = Purchases.Vendor


--21.
select Purchases.Vendor, MaxDate, Amount
from Purchases
	inner join 
	(select Vendor, max([Date]) as MaxDate
	from purchases 
	group by Vendor) VendorMaxDate 
		on VendorMaxDate.MaxDate = Purchases.[Date]
		and VendorMaxDate.Vendor = Purchases.Vendor

