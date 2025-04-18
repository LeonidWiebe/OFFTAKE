SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_NW_FH1_Window_Attributes]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
--dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Name],

dbo.[i_PartProperties].kks AS [~Name],
--CASE 
--	WHEN dbo.i_WindowProperties.FireResistance = 'не требуется' THEN 'N/A'
--	ELSE dbo.i_WindowProperties.FireResistance
--END AS '~Fire resistance',

--CASE 
--	WHEN i_WindowProperties.Type = 'WM - металлическое' THEN 'WM'
--	WHEN i_WindowProperties.Type = 'WP - металлопластиковое' THEN 'WP'
--	WHEN i_WindowProperties.Type = 'WF - металлическое противопожарное' THEN 'WF'
--	ELSE i_WindowProperties.Type
--END AS '~Type',
--round(dbo.i_Dimensions.width * 1e-2, 0,2) AS '~Aperture width (in clear)', --до уменьшения проема
--round(dbo.i_Dimensions.height * 1e-2, 0,2) AS '~Aperture height (in clear)', --до уменьшения проема
round((dbo.i_Dimensions.width * 1e-2)-70, 0,2) AS '~Aperture width (in clear)', --проем уменьшен в свету на 35 мм с каждой стороны по ТЗ Левашко, август 2021
round((dbo.i_Dimensions.height * 1e-2)-70, 0,2) AS '~Aperture height (in clear)', --проем уменьшен в свету на 35 мм с каждой стороны по ТЗ Левашко, август 2021

--dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 2)) AS '~Installation level',


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename


FROM         dbo.elements 

INNER JOIN   dbo.i_WindowProperties ON dbo.elements.simID = dbo.i_WindowProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
Left JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID
Left JOIN dbo.[i_PartProperties] ON dbo.elements.simID = dbo.[i_PartProperties].simID


















GO
