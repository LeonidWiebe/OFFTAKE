SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_PKS2_Fire_room_RU_DOC2_bkp]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,
dd.bldName AS 'KKS of Building',
dbo.i_Space.NumFireComp2 AS 'Number of fire compartment',
dbo.i_Space.NumFireComp AS 'KKS code of second fire compartment',
dbo.i_Space.number AS 'Room KKS code', 
dbo.i_Space.label  AS 'Room name', 
dbo.getZero(dbo.getTrueArea2(dbo.elements.simID, 0, 1))  AS 'Area',
dbo.getTrueArea2(dbo.elements.simID, 0, 1)  AS 'CalcArea',
dbo.getTrueVolume(dbo.elements.simID, 0, 2) AS 'Volume',
dbo.i_Space.SPF_FireLoadGroup AS 'Fire load',
CASE
	WHEN Doc2.safe_cell_kks = 'Отсутствует /missing' THEN 'Отсутствует'
	Else Doc2.safe_cell_kks
END AS 'Safety Canal',
CASE
	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'ЗСД'
	WHEN dbo.i_Space.AccessArea = 'Uncontrolled access area' THEN 'ЗСД'
	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'ЗКД'
END AS 'Acess Area',
CASE
	WHEN Doc2.aps_avl = 'да (yes)' THEN 'да'
	WHEN Doc2.aps_avl = 'нет (no)' THEN 'нет'
	ELSE Doc2.aps_avl
END AS 'Наличие АПС',
CASE 
	WHEN Doc2.autp_avl = 'да (yes)' THEN 'да'
	WHEN Doc2.autp_avl  = 'нет (no)' THEN 'нет'
	ELSE Doc2.aps_avl
END AS 'Наличие АУПТ'

FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [10.36.69.20].[PKS].[dbo].[Room_charact] AS Doc2 ON i_Space.Doc2_ID = Doc2.Doc2_ID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
Where dd.project_name = 'Paks-2' and dd.deleted = 0










GO
