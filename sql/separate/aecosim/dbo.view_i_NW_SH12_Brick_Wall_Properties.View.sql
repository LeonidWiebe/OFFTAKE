SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_NW_SH12_Brick_Wall_Properties]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 


round(dbo.i_Wall.Width * 1e-2, 0,0) AS '~Толщина, мм',
'M150' AS '~Марка кирпича по прочности',
--round(dbo.elements.elemVolume * 1e-15, 2,2) AS '~Объем, м3',
dbo.getTrueVolume(dbo.elements.simID, 0, 3) AS '~Объем, м3',

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid





























GO
