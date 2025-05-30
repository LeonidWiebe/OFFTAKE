SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_FH1_Space_RadiationZone_Doc2]
AS
SELECT     

dbo.elements.simID, 
--dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemOldID, 
dd.[o_docguid] as docguid,
dbo.elements.dtID, 

r.ra_avl

--dd.project_name, 
--dd.deleted

FROM         dbo.elements 

INNER JOIN [10.36.69.19].[HHKV_1].[dbo].[room_charact] AS r on dbo.elements.simID = r.simid
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id




GO
