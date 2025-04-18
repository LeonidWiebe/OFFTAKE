SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_Space]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dd.[o_docguid] as docguid,
dbo.elements.elemOldID, 
dbo.elements.elemguid, 
dbo.i_Space.Doc2_ID,
dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 1)) AS [Level],
dbo.i_Space.number AS kks, 
dbo.i_Space.label AS [name rus], 
dbo.i_Space.label2 AS [name eng], 

-- Floor Area
dbo.getTrueArea2(dbo.elements.simID, 0, 2)  AS [area],
dbo.getTrueVertArea(dbo.elements.simID, 0, 2) as [wall_area],
dbo.getTrueVolume(dbo.elements.simID, 0, 2) AS volume, 

dbo.i_Space.AccessArea AS [access area], 
dbo.i_Space.SafetyCanal AS [safety channel], 

dbo.i_Space.NumFireComp2 AS [Number of Fire Compartment], 
'' AS [Area of a fire compartment],

-- забор кодов из таблицы отсеков - Вибе Л. 11.03.2021
CASE
 WHEN fc.fcCode is NULL Then dbo.i_Space.NumFireComp
 ELSE fc.fcCode  -- если определен в таблице отсеков то ставим код оттуда
END AS [Number of Secondary Fire Compartment],
--вместо dbo.i_Space.NumFireComp AS [Number of Secondary Fire Compartment],

'EI'+cast(fc.fcFireRes as varchar) AS [Fire resistance rating for walls of fire compartment],
(LEN(fc.fcRoomCodes)+1)/12 as [Rooms Quantity],
-- забор площади отсека из таблицы отсеков - Вибе Л. 11.03.2021
CASE
 WHEN fc.fcFloorArea is NULL Then ''
 ELSE fc.fcFloorArea  -- если определен в таблице отсеков то ставим оттуда
END AS [Area of a secondary fire compartment],
-- вместо '' AS [Area of a secondary fire compartment],

dbo.i_Space.SignFireComp AS [fire comp sign], 
dbo.i_Space.ProtectionLevel AS [protection level], 
dbo.i_Space.SPF_FireLoadGroup AS [fire load group], -- getFireLoadGroup?
dbo.getFireLoadGroup2(dbo.i_Space.SPF_FireLoadGroup) as [fire_load_group2], -- 
dbo.i_Space.SPF_FireHazardClass AS [fire hazard class], 
dbo.i_Space.SPF_Speciality AS speciality, 
dbo.i_Space.SPF_RadiationSafetyAreaYVLC2 AS [radiation safety area], 

dbo.i_Space.TopCoatLayer as [top coat layer],
dbo.i_Space.WallInteriorFinish as [wall interior finish],
dbo.i_Space.CeilInteriorFinish as [ceiling interior finish],
dbo.i_Space.FloorWaterproofed as [Floor Waterproofed],

dbo.getFullFireLoad(dbo.elements.simID, 'floor', 2) as [FFL floor],
dbo.getFullFireLoad(dbo.elements.simID, 'wall', 2) as [FFL wall],
dbo.getFullFireLoad(dbo.elements.simID, 'ceil', 2) as [FFL ceiling],


dbo.elements.dtID, 

dd.project_name, 
dd.bldID,
dd.deleted

FROM         dbo.elements 

INNER JOIN dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id

-- забор кодов из таблицы отсеков - Вибе Л. 11.03.2021
LEFT OUTER JOIN dbo.o_FireComp fc ON fc.fcID = dbo.i_Space.fcID








GO
