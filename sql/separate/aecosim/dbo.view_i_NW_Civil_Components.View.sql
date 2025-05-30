SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






















CREATE VIEW [dbo].[view_i_NW_Civil_Components]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Object],
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename,
dbo.elements.cattype AS cattype,
dbo.elements.partdef AS partdef,
dbo.elements.catitem AS catitem

FROM         dbo.elements 
--INNER JOIN   dbo.i_BuildingProp ON dbo.elements.simID = dbo.i_BuildingProp.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid

UNION 
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Object],
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
Cdoc.o_filename AS o_filename,
dbo.elements.cattype AS cattype,
dbo.elements.partdef AS partdef,
dbo.elements.catitem AS catitem

FROM         dbo.elements 
--INNER JOIN   dbo.i_BuildingProp ON dbo.elements.simID = dbo.i_BuildingProp.simID
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS Cdd ON dbo.elements.pwdocID = Cdd.id
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[dms_doc] AS Cdoc ON Cdd.o_docguid = Cdoc.o_docguid
















GO
