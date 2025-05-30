SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_NW_LYG_Waterstop_Attributes]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID,
	dbo.i_ProfileQuantities.PathLength AS '~PathLength',
	dbo.i_ProfileQuantities.CrossSectionArea AS '~CrossSectionArea',
	dbo.i_ProfileQuantities.NetVolume AS '~NetVolume',
	dbo.i_Profile_Common.Is_external AS '~Is_external',
	dbo.i_Profile_Common.IsCurve AS '~IsCurve',
	dbo.i_Profile_Common.Manufacturer AS '~Manufacturer',
	
doc.o_filename AS o_filename

FROM         dbo.elements 

INNER JOIN   dbo.i_ProfileQuantities ON dbo.elements.simID = dbo.i_ProfileQuantities.simID
INNER JOIN   dbo.i_Profile_Common ON dbo.elements.simID = dbo.i_Profile_Common.simID
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid



GO
