SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_NW_FH1_SDS_sensor_Attributes]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
	i_StrainDT.KKScode AS '~Name',
	i_StrainDT.NameEN +' / '+ i_StrainDT.NameRU AS '~Description',
	i_StrainDT.SurfaceMeasurement AS '~Surface measurement',
	i_StrainDT.DirectionMeasurement AS '~Direction measurement',
	

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN  dbo.i_StrainDT  ON dbo.elements.simID = dbo.i_StrainDT.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid



GO
