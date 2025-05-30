SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_PKS2_List_Of_Rooms_ABD_Fire]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,

LEFT(dbo.i_Space.number, 7) AS [KKS отметки],


dbo.i_Space.number AS [KKS],  
dbo.i_Space.label  AS [Name RU], 
dbo.i_Space.label2  AS [Name EN], 
dbo.i_Space.SPF_FireLoadGroup as [FireLoad],
dbo.i_Space.NumFireComp as [NumFireComp],

--CASE (на будущее от Ани и Иринея)
-- WHEN fc.fcCode is NULL Then dbo.i_Space.NumFireComp
-- ELSE fc.fcCode  -- если определен в таблице отсеков то ставим код оттуда
--END AS [NumFireComp],
----вместо dbo.i_Space.NumFireComp AS [Number of Secondary Fire Compartment],


--dbo.getZero(dbo.getTrueArea(round(dbo.i_Space.actualGross * 1e-10, 1) ,round(dbo.elements.elemarea * 1e-10, 1)))  AS 'Floor Area',
dbo.getZero2(dbo.getTrueArea2(dbo.elements.simID, 0, 2))  AS [Floor Area],

LEFT(dbo.i_Space.number, 5) AS [KKS здания]


FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID

---- забор кодов из таблицы отсеков - Вибе Л. 11.03.2021 (на будущее от Ани и Иринея)
--LEFT OUTER JOIN dbo.o_FireComp fc ON fc.fcID = dbo.i_Space.fcID

--where i_Space.number like '50ukc%'













GO
