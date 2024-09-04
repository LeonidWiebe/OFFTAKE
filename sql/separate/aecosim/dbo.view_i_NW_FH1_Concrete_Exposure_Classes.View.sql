SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_NW_FH1_Concrete_Exposure_Classes]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
	
dbo.i_ConcreteExposure.XC AS '~Carbonation corrosion',
dbo.i_ConcreteExposure.XD AS '~Chlorides corrosion',
dbo.i_ConcreteExposure.XS AS '~Sea water corrosion',
dbo.i_ConcreteExposure.XF AS '~Freeze thaw attack',
dbo.i_ConcreteExposure.XA AS '~Chemical attack',



dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_ConcreteExposure ON dbo.elements.simID = dbo.i_ConcreteExposure.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid

















GO
