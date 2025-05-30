SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_FH1_Gate_Attributes]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 

DP.KKS AS 'KKS / MCS No.',

DP.Type AS 'Name of the equipment, item and material',
'-' AS 'Type, grade, model, code (drive model)',
cast(round (DM.width * 1e-2, 2, 2) as varchar) +'x'+ cast(round (DM.height * 1e-2, 2, 2) as varchar) +
'; Door leaf type/ Тип дверного полотна: '+ 
(CASE
	WHEN round (DM.width * 1e-2, 2, 2) >= 1200 Then 'Double/Двупольное'
	else 'Single/Однопольное'
END)+
'; Fire resistance/Предел огнестойкости: '+DP.FireResistance+
'; Smoke-tightness/Дымогазонепроницаемость: '+ 
(CASE
	WHEN DP.SmokeTightness != '' Then DP.SmokeTightness
		else ' '
END)+'; Door type (by environment)/Тип двери (по окружающей среде): '+(CASE
	WHEN DP.KKS_Room1 = '' and DP.KKS_Room2 = '' Then 'N/A'
	WHEN (DP.KKS_Room1 = 'NPP site' or DP.KKS_Room2 = 'NPP site') Then 'External/Наружная'
	else 'Internal/Внутреняя'
END) AS 'Technical characteristics',

'-' AS 'Code of Design Requirements',
'-' AS 'Normative basis and equipment classification',
DP.Material AS 'Material',
'pcs / шт' AS 'U/M',
'1' AS 'Quantity',
DP.Mass_of_unit AS 'Mass of unit',
(LEFT(DP.KKS, 5))+'; '+DP.KKS_Room1 AS 'Location; Building; Room',
'' AS 'Note'

FROM         dbo.elements 


INNER JOIN dbo.i_DoorProperties AS DP ON dbo.elements.simID = DP.simID 
INNER JOIN dbo.i_Dimensions AS DM ON dbo.elements.simID = DM.simID


INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid


where DP.Type = 'Gate/Ворота'


GO
