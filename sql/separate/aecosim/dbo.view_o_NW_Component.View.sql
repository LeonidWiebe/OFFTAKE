SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO























CREATE VIEW [dbo].[view_o_NW_Component]
AS
SELECT 
	dbo.elemtech.elemID AS elemID,     
	dbo.elemtech.simID AS simID, 
	dbo.elemtech.pwdocID AS pwdocID, 
	dbo.elemtech.elemguid AS elemguid, 
	dbo.elemtech.dtID AS dtID, 
	
dbo.getComponentName ([dbo].[elemtech].[cattype]) AS [~Component name],
dbo.getComponentName ([dbo].[elemtech].[cattype]) AS [Component name]
--doc.o_filename AS o_filename


FROM         dbo.elemtech 
--INNER JOIN   dbo.i_BuildingProp ON dbo.elemtech.simID = dbo.i_BuildingProp.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elemtech.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid



















GO
