SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_XDP_Fire_Zones]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 

DOC2.kks_zone AS 'KKS code of fire zone',

dbo.i_Space.number AS 'KKS code', 
dbo.i_Space.label2 AS 'name of room rus', 
dbo.i_Space.label AS 'name of room eng', 

dbo.getzero2(dbo.getTrueArea2(dbo.elements.simID, 0, 1))  AS 'Room area', 

DOC2.category_final AS 'Category as per NPB 105-2003',

CASE 
	when Doc2.pt = 'НЕТ' then '-'
	when Doc2.pt is not null then '+'
	else '' --null
END AS 'Availability of AFFU',

DOC2.type_zone AS 'Fire zone type in terms of functional features',

DOC2.If_uchastok 

--,dd.project_name
--,dd.o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_Space 
ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [10.36.69.85].[XZS].[dbo].[room_charact] AS DOC2 
ON dbo.elements.simID = DOC2.simid
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd
ON dbo.elements.pwdocID = dd.id

WHERE DOC2.If_uchastok='Помещение'
--в room_charact есть не только помещения, но и участки помещений с теми же кодами и simid. 
--По требованиям норм пожарной безопасности, одно помещение может быть разбито на несколько участков, поэтому нужно такое ограничение во вьюхе.



GO
