SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_PKS2_Fire_room_Summary]
AS
SELECT     
--dbo.elements.simID, 
--dbo.elements.elemID, 
--dbo.elements.pwdocID,
dd.bldName AS 'KKS of Building',

dbo.i_Space.NumFireComp2 AS 'Number of fire compartment',

--dbo.getTrueArea2(dbo.elements.simID, 0, 1)  AS 'CalcArea',
dbo.getZero(SUM(dbo.getTrueArea2(dbo.elements.simID, 0, 3)))  AS 'Area',

--sum(dbo.getTrueVolume(dbo.elements.simID, 0, 2)) AS 'Volume'
dbo.getZero2(SUM(dbo.getTrueVolume(dbo.elements.simID, 0, 2))) AS 'Volume'

FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
--LEFT OUTER JOIN [10.36.69.20].[PKS].[dbo].[Room_charact] AS Doc2 ON i_Space.Doc2_ID = Doc2.Doc2_ID -- Замена Doc2_ID на simID, Решетников ИО 2022 08 11
LEFT OUTER JOIN [10.36.69.20].[PKS].[dbo].[Room_charact] AS Doc2 ON i_Space.simID = Doc2.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
Where dd.project_name = 'Paks-2' and dd.deleted = 0
AND dd.bldName <> '50UCB_2'

GROUP BY dd.bldName, dbo.i_Space.NumFireComp2





GO
