SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_NW_PKS2_Gate_Attributes]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
--dbo.i_DoorProperties.KKS AS '~KKS door',
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Name],

CASE 
	--WHEN dbo.i_DoorProperties.Type IS NULL THEN '-'
	WHEN dbo.i_DoorProperties.Type = 'DM - металлическая' THEN 'Metal door'
	WHEN dbo.i_DoorProperties.Type = 'DF - металлическая противопожарная' THEN 'Fire door'
	WHEN dbo.i_DoorProperties.Type = 'DP - металлопластиковая' THEN 'Metal plastic door'
	WHEN dbo.i_DoorProperties.Type = 'DT - герметичная' THEN 'Tight door'
	WHEN dbo.i_DoorProperties.Type = 'PP - физзащитная' THEN 'Physical protective door'
	ELSE dbo.i_DoorProperties.Type
END AS '~Type',

  CAST(round(dbo.i_Dimensions.width * 1e-2, 0, 2) AS int) AS '~Width', 
 CAST(round(dbo.i_Dimensions.height * 1e-2, 0, 2) AS int) AS '~Height',

CASE 
	--WHEN dbo.i_DoorProperties.FireResistance IS NULL THEN '-'
	WHEN dbo.i_DoorProperties.FireResistance = 'не требуется' THEN 'N/A'
	ELSE dbo.i_DoorProperties.FireResistance
END AS '~Fire resistance rating',
dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 2)) AS '~Installation level',




dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID

















GO
