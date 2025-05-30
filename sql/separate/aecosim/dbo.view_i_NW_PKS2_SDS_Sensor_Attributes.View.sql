SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_NW_PKS2_SDS_Sensor_Attributes]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	

CASE 
	WHEN i_StrainDT.KKScode IS NULL THEN '-'
	WHEN i_StrainDT.KKScode = ' ' THEN '-'
	WHEN i_StrainDT.KKScode = '' THEN '-'
	ELSE i_StrainDT.KKScode
END AS '~Name',

CASE 
	WHEN i_StrainDT.NameRU IS NULL THEN '-/-'
	WHEN i_StrainDT.NameRU = ' ' THEN '-/-'
	WHEN i_StrainDT.NameRU = '' THEN '-/-'
	ELSE i_StrainDT.NameEN +' / '+ i_StrainDT.NameRU
END AS '~Description',

CASE 
	WHEN i_StrainDT.SurfaceMeasurement IS NULL THEN '-'
	WHEN i_StrainDT.SurfaceMeasurement = ' ' THEN '-'
	WHEN i_StrainDT.SurfaceMeasurement = '' THEN '-'
	ELSE i_StrainDT.SurfaceMeasurement
END AS '~Surface measurement',

CASE 
	WHEN i_StrainDT.DirectionMeasurement IS NULL THEN '-'
	WHEN i_StrainDT.DirectionMeasurement = ' ' THEN '-'
	WHEN i_StrainDT.DirectionMeasurement = '' THEN '-'
	ELSE i_StrainDT.DirectionMeasurement
END AS '~Direction measurement',
	

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN  dbo.i_StrainDT  ON dbo.elements.simID = dbo.i_StrainDT.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid






GO
