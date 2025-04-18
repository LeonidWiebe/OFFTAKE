SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_NW_FH1_Gate_Attributes]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
dbo.i_DoorProperties.KKS AS '~Name',

round((dbo.i_Dimensions.width * 1e-2)-100, 0,2) AS '~Aperture width (in clear)', 
round((dbo.i_Dimensions.height * 1e-2)-100, 0,2) AS '~Aperture height (in clear)',

CASE 
	WHEN dbo.i_DoorProperties.FireResistance IS NULL THEN 'Нет данных'
	WHEN dbo.i_DoorProperties.FireResistance = 'не требуется' THEN 'N/A'
	ELSE dbo.i_DoorProperties.FireResistance
END AS '~Fire resistance',

--CASE 
--	WHEN dbo.i_DoorProperties.Type = 'DM - металлическая' THEN 'DM'
--	WHEN dbo.i_DoorProperties.Type = 'DF - металлическая противопожарная' THEN 'DF'
--	WHEN dbo.i_DoorProperties.Type = 'DP - металлопластиковая' THEN 'DP'
--	WHEN dbo.i_DoorProperties.Type = 'DT - герметичная' THEN 'DT'
--	WHEN dbo.i_DoorProperties.Type = 'PP - физзащитная' THEN 'PP'
--	ELSE dbo.i_DoorProperties.Type
--END AS '~Door type',

--dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 2)) AS '~Installation level',
--dbo.i_DoorProperties.KKS_Room1 AS '~KKS code of room 1',
--dbo.i_DoorProperties.KKS_Room2 AS '~KKS code of room 2',

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID



















GO
