use CreditCard
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE usp_addPayment
	@paymentDate date,
	@amount decimal (10,2),
	@cardNum int
AS
BEGIN
	SET NOCOUNT ON;

	begin try

    declare @availCredit decimal (10,2)
	select @availCredit= AvailableCredit 
	from CreditCard 
	where CreditCardNum = @cardNum

	if @amount > @availCredit
	begin;
	throw 80005, 'Insufficient Funds', 1
	end

	declare @statusID int                            
	select @statusID = [Status]
	from CreditCard
	where @cardNum like CreditCardNum

	declare @status varchar(20)
	select @status = [Status]
	from [Status]
	where StatusID = @statusID

	if @status not like 'Active' 
	begin;
		throw 80009, 'Inactive Card Error', 1
	end

	insert into Payment(PaymentDate, PaymentAmount, CreditCardNum)
	values (@paymentDate, @amount, @cardNum)

	update CreditCard
	set CurrentBalance = CurrentBalance - @amount
	where CreditCardNum = @cardNum

	end try
	begin catch;

	throw 80009, 'Payment Could not be Processed', 1
	end catch 
END
GO

