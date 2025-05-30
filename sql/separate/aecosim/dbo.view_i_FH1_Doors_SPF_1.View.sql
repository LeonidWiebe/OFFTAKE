SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[view_i_FH1_Doors_SPF_1]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
 
dbo.i_DoorProperties.KKS,
CASE
	WHEN SUBSTRING(dbo.i_DoorProperties.KKS,10,1) IN (0,1,2)  Then 'Дверь / Door'
	WHEN SUBSTRING(dbo.i_DoorProperties.KKS,10,1) ='3'  Then 'Ворота / Gate'
	WHEN SUBSTRING(dbo.i_DoorProperties.KKS,10,1) ='4'  Then 'Люк / Hatch'
END AS 'Тип заполнения проема', 

--CASE
--	WHEN elRoom1.pMinZ > elRoom2.pMinZ OR elRoom2.pMinZ is Null THEN dbo.getZeroPlus(round(elRoom1.pMinZ* 1e-3, 2))
--	Else dbo.getZeroPlus(round(elRoom2.pMinZ* 1e-3, 2)) 
-- END AS [Высотная отметка],

dbo.getZeroPlus(round(elements.pMinZ* 1e-3, 2)) AS [Высотная отметка],

LEFT(dbo.i_DoorProperties.KKS, 5) AS [KKS здания],
--dbo.i_DoorProperties.KKS_Room1 AS 'Код KKS помещения 1',
'' AS 'Код KKS помещения 1',
--sp1.label AS 'Наименование помещения 1',
''AS 'Наименование помещения 1',
dbo.i_DoorProperties.KKS_Room2 AS 'Код KKS помещения 2',
sp2.label AS 'Наименование помещения 2',
--sp1.number AS sp1,
--sp2.number as sp2,
--elRoom1.simID as elRoom1,
--elRoom2.simID as elRoom2,
CASE
	WHEN SUBSTRING(dbo.i_DoorProperties.Type,1,2)='DT' Then round(dbo.i_Dimensions.width * 1e-2 - 200, 2, 2)
	Else round(dbo.i_Dimensions.width * 1e-2 - 100, 2, 2)
END AS [Ширина проема в свету],
CASE
	WHEN SUBSTRING(dbo.i_DoorProperties.Type,1,2)='DT' Then round(dbo.i_Dimensions.height * 1e-2 - 200, 2, 2)
	ELSE round(dbo.i_Dimensions.height * 1e-2 - 100, 2, 2)
END AS [Высота проема в свету],
round(dbo.i_Dimensions.width * 1e-2, 2, 2) AS [Ширина строительного проема] ,
round(dbo.i_Dimensions.height * 1e-2, 2, 2) AS [Высота строительного проема],
dbo.i_DoorProperties.FireResistance AS [Предел огнестойкости],

--CASE
--	WHEN elRoom1.pMinZ > elRoom2.pMinZ or elRoom2.pMinZ is Null THEN round(dbo.elements.pMinZ* 1e-0, 2)-round(elRoom1.pMinZ* 1e-0, 2)
--	Else round(dbo.elements.pMinZ* 1e-0, 2)-round(elRoom2.pMinZ* 1e-0, 2)
--END AS [Порог]

CASE
	WHEN round(dbo.elements.pMinZ* 1e-0, 2)-round(elements.pMinZ* 1e-0, 2) >300 THEN '0'
	Else round(dbo.elements.pMinZ* 1e-0, 2)-round(elements.pMinZ* 1e-0, 2)
END AS [Порог]


FROM         dbo.elements 
INNER JOIN dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID 
INNER JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID
  --INNER JOIN dbo.i_Space AS sp1 ON dbo.i_DoorProperties.KKS_Room1 = sp1.number 
LEFT JOIN   dbo.i_Space AS sp2 ON dbo.i_DoorProperties.KKS_Room2 = sp2.number 
--LEFT JOIN dbo.elements AS elRoom1 ON sp1.simID = elRoom1.simID
--LEFT JOIN dbo.elements AS elRoom2 ON sp2.simID = elRoom2.simID
--LEFT JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON elRoom2.pwdocID = dd.id
--LEFT JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
--WHERE (sp2.number is not NULL OR sp2.number !='') AND (dd.project_name = 'Hanhikivi')






GO
