exec usp_refund 1 , 5424678911225577, 100
exec usp_refund 2 , 342467891122558, 100
exec usp_refund 3 , 5424678911225577, 12.10

exec usp_Purchase 200.34, '2020-05-22', 1324, 5, 5424678911225577   
exec usp_Purchase 350.00, '2019-12-05', 2641,3,342467891122558
exec usp_Purchase 67.93, '2019-12-30', 5768, 6, 5424678911225577

select *
from Purchases
