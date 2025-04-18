SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_Footing]
AS
SELECT  
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 

dbo.i_BuildingProp.BuildingKKS AS '~BuildingKKS',	
dbo.i_ConcreteProperties.C AS '~Material',
--round(dbo.elements.elemVolume * 1e-15, 2, 0) AS 'Volume',
dbo.getTrueVolume(dbo.elements.simID, 0, 2) AS [Volume],


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_ConcreteProperties ON dbo.elements.simID = dbo.i_ConcreteProperties.simID
INNER JOIN   dbo.i_BuildingProp ON dbo.elements.simID = dbo.i_BuildingProp.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid






















GO
