SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_NW_PKS2_Well_Attributes]
AS
SELECT    
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 

dbo.i_Well.Name AS '~Name',
dbo.i_Well.Description AS '~Description',
dbo.i_Well.OuterDiameter AS '~Outer Diameter',
dbo.i_Well.Material AS '~Material',
doc.o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_Well ON dbo.elements.simID = dbo.i_Well.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid


GO
