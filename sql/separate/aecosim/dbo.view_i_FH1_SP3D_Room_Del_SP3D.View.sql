SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_FH1_SP3D_Room_Del_SP3D]
AS
SELECT   
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,

SUBSTRING (dbo.i_Space.number,0,6) AS 'Building' 
,SUBSTRING (dbo.i_Space.number,0,8) AS 'Level' 
,dbo.i_Space.number
,doc.o_filename
--,JNamedItem.ItemName
--,JNamedItem2.Oid
FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
LEFT JOIN dbo.view_i_FH1_SP3D_Room_Name AS JNamedItem ON dbo.i_Space.number COLLATE SQL_Latin1_General_CP1_CI_AS = JNamedItem.ItemName
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
Where (JNamedItem.ItemName is Null AND dd.project_name = 'Hanhikivi' AND dd.deleted = 0)
OR (JNamedItem.ItemName ='' AND dd.project_name = 'Hanhikivi' AND dd.deleted = 0 )



GO
