SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_spec_catlist_3]
AS

SELECT 

dbo.r_catlist_part.relID as clposID, -- catlist position ID
dbo.r_catlist_part.partSortID, 
dbo.r_catlist_part.partQty, 
dbo.r_catlist_part.catlistID, 
dbo.r_catlist_part.objID, 
dbo.view_r_part_position.partID, 
dbo.view_r_part_position.catID, 

case when dbo.r_catlist_part.partNameOver is null then
0 else 1
end as prm, -- масса позиции с учетом параметровимени изделия

case when dbo.r_catlist_part.partNameOver is null then
dbo.view_r_part_position.partName
else
dbo.r_catlist_part.partNameOver
end as partName, 

dbo.view_r_part_position.parentID, 
dbo.view_r_part_position.deleted, 
dbo.view_r_part_position.partDescr, 
dbo.view_r_part_position.partVersion, 
dbo.view_r_part_position.partIDold, 
dbo.view_r_part_position.catIDold, 
dbo.view_r_part_position.partSheet, 
dbo.view_r_part_position.partSortNumber, 
dbo.view_r_part_position.partMainPosEP, 
dbo.view_r_part_position.partStatusID, 
dbo.view_r_part_position.usrID, 
dbo.view_r_part_position.posID, 
dbo.view_r_part_position.pos_srtmID, 
dbo.view_r_part_position.muID, 
dbo.view_r_part_position.posQuantity, 
dbo.view_r_part_position.matID, 

case when not dbo.r_catlist_part.partNameOver is null and dbo.view_r_part_position.posNumber=1 then
dbo.r_catlist_part.koef
else
1.
end as koef, -- коэффициент корректировки массы для первой позиции

case when not dbo.r_catlist_part.partNameOver is null and dbo.view_r_part_position.posNumber=1 then
dbo.view_r_part_position.posUnitMass * dbo.r_catlist_part.koef
else
dbo.view_r_part_position.posUnitMass
end as posUnitMass, 

dbo.view_r_part_position.partMass, 

case when not dbo.r_catlist_part.partNameOver is null and dbo.view_r_part_position.posNumber=1 then
dbo.view_r_part_position.posCommonMass * dbo.r_catlist_part.koef
else
dbo.view_r_part_position.posCommonMass
end as posCommonMass, 

dbo.view_r_part_position.mcID, 
dbo.view_r_part_position.numDigits, 
dbo.view_r_part_position.posNumber, 
dbo.view_r_part_position.posIDold, 
dbo.view_r_part_position.posUMCalc, 
dbo.view_r_part_position.posCMCalc, 
dbo.view_r_part_position.pos_area, 
dbo.view_r_part_position.pos_diameter, 
dbo.view_r_part_position.pos_height, 
dbo.view_r_part_position.pos_length, 
dbo.view_r_part_position.pos_radius, 
dbo.view_r_part_position.pos_radiusinn, 
dbo.view_r_part_position.pos_radiusout, 
dbo.view_r_part_position.pos_segment, 
dbo.view_r_part_position.pos_thickness, 
dbo.view_r_part_position.pos_width, 
dbo.view_r_part_position.pos_diaminn, 
dbo.view_r_part_position.pos_diamout, 
dbo.view_r_part_position.pos_volume, 
dbo.view_r_part_position.catName, 
dbo.view_r_part_position.partNameOld, 
dbo.view_r_part_position.posSketch, 
dbo.view_r_part_position.partRoundShift, 
dbo.view_r_part_position.partRoundSaved, 
dbo.view_r_part_position.partdefID, 
dbo.view_r_part_position.typeID, 
dbo.view_r_part_position.posBarLength, 
dbo.view_r_part_position.dsPartListID, 
dbo.view_r_part_position.dsDrawingsID, 
dbo.view_r_part_position.lenmin, 
dbo.view_r_part_position.lenmax, 
dbo.view_r_part_position.lenmid, 
dbo.view_r_part_position.posName,
dbo.r_sortament_property.*

,(select count(*) from position where position.partID = dbo.view_r_part_position.partID) as poscnt
,(select sum(posCommonMass) from position where position.partID = dbo.view_r_part_position.partID) as mass 

FROM            dbo.r_catlist_part 

LEFT OUTER JOIN dbo.view_r_part_position ON dbo.r_catlist_part.partID = dbo.view_r_part_position.partID
LEFT OUTER JOIN dbo.r_sortament_property ON dbo.view_r_part_position.pos_srtmID = dbo.r_sortament_property.srtmID 

WHERE 
 (dbo.view_r_part_position.partID IS NOT NULL)
--and catlistID = 21383 

--ORDER BY [partSortID], clposID, [posNumber]



GO
