SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_FH1_Louver]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 



	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
-- dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Name],
--  заменен на KKS по просьбе архитекторов в декабре 2020.
dbo.[i_PartProperties].kks AS [Name],
dbo.[i_PartProperties].KKS_code_of_Room AS 'KKS code of Room',
 round(dbo.i_ObjectDimension.UnitWidth * 1e-2, 0,2) AS 'Width', 
 round(dbo.i_ObjectDimension.UnitHeight * 1e-2, 0,2) AS 'Hight',

dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 2)) AS 'Installation level',
	dbo.elements.pCentX AS 'Центр X',
	dbo.elements.pCentY AS 'Центр Y',
	dbo.elements.pCentZ AS 'Центр Z',
doc.o_filename


FROM         dbo.elements 
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
Left JOIN dbo.i_ObjectDimension ON dbo.elements.simID = dbo.i_ObjectDimension.simID
Left JOIN dbo.[i_PartProperties] ON dbo.elements.simID = dbo.[i_PartProperties].simID






















GO
