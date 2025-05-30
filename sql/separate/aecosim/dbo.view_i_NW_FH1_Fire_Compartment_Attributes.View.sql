SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_NW_FH1_Fire_compartment_Attributes]
AS
SELECT  distinct

fc.fcID AS fcID, 

fc.fcCode  AS [~Name],

case 
	when fc.fcFireRes is null then 'not defined'
	when fc.fcFireRes = 0 then 'not defined'
	else 'EI' + cast(fc.fcFireRes as varchar) 
end	AS [~Fire resistance rating for walls of fire compartment],

case 
	when fc.fcFloorArea is null then 'not calculated'
	else dbo.getZero2(fc.fcFloorArea) + ' m^2' 
end	 AS [~Floor area],

case 
	when fc.fcFireLoad  is null then 'not defined'
	when fc.fcFireLoad ='>' then '- over than 1200 MJ/m^2'
	when fc.fcFireLoad ='=' then '- from 600 to 1200 MJ/m^2'
	when fc.fcFireLoad ='<' then '- less than 600 MJ/m^2'
	else 'not defined'
end	 AS [~Fire load category],



case 
	when fc.fcRoomCodes   is null then 'not defined'
	else fc.fcRoomCodes 
end	 AS '~KKS code of room'


--'Fire Compartment' as [Object]

FROM         dbo.[o_fireComp] AS fc

left outer join dbo.i_space AS s on s.NumFireComp = fc.fcCode


















GO
