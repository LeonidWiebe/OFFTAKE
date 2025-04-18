SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE VIEW [dbo].[view_i_PW_elem_codes]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.cattype, 
cc.codeNum,
cc.codeFull,
dd.bldName,
dd.project_name
--dd.o_filename,
--dd.o_original,
--dd.deleted

FROM         dbo.elements 

INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN dbo.elemCodes as cc ON cc.simID = dbo.elements.simID


GO
