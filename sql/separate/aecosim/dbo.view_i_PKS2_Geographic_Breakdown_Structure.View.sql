SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_PKS2_Geographic_Breakdown_Structure]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,
dd.bldName AS 'KKS of Building',
Doc2Titul.bld_name_eng AS 'Building description',
Doc2Titul.bld_name_rus AS 'Здание Описание',
LEFT(dbo.i_Space.number, 7) as [KKS отметки],
dbo.i_Space.number AS 'Room KKS code', 
dbo.i_Space.label2  AS 'Room name EN', 
dbo.i_Space.label  AS 'Room name RU'



FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [10.36.69.20].[PKS].[dbo].[Room_charact] AS Doc2 ON i_Space.Doc2_ID = Doc2.Doc2_ID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN [10.36.69.20].[PKS].[dbo].[Titul_list] AS Doc2Titul ON dd.bldName = Doc2Titul.kks_bld
Where dd.project_name = 'Paks-2' and dd.deleted = 0








GO
