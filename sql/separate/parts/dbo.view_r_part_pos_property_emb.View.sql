SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_r_part_pos_property_emb]
AS
SELECT

-- part properties
dbo.view_part2.catID, 
dbo.view_part2.partID, 
dbo.view_part2.partName, 
dbo.view_part2.deleted, 
dbo.view_part2.partVersion, 
dbo.view_part2.partSortNumber, 

-- pos1 ids
pos1.posID, 
pos1.posNumber, 
stdpd1.posdefID, -- 

-- pos1 properties
srtm_prop_1.width AS srtmwidth, 
srtm_prop_1.thickness, 
pos_prop_1.width, 
pos_prop_1.length AS listlen, 


-- anker diameter
case
	when stdpd2.posdefID = 1 -- bar
	then srtm_prop_2.diameter
	else srtm_prop_3.diameter
end as diameter,
 
-- anker length
case
	when stdpd2.posdefID = 1 
	then pos_prop_2.length
	else pos_prop_3.length
end as anklen,

-- anker chains
case
	when stdpd2.posdefID = 1 
	then pos_prop_2.chainx
	else pos_prop_3.chainx
end as chainx,
case
	when stdpd2.posdefID = 1 
	then pos_prop_2.chainy
	else pos_prop_3.chainy
end as chainy,

-- ankterm thickness
case
	when stdpd2.posdefID = 1 
	then srtm_prop_3.thickness
	else srtm_prop_2.thickness
end as ancTermThickness, /* TODO thickness of ancer terminator */

-- ankterm width/length
case
	when stdpd2.posdefID = 1 
	then pos_prop_3.width
	else pos_prop_2.width
end as ancTermVolume, /* TODO volume (width or diameter) of ancer terminator */ 

-- ankterm Type
/* дополнительный элемент анкера
NONE:0, 
RECT:1, 
CIRCLE:2 
RECT_INTER:3 - переходная пластина

mcID = 14 плашка (усиление анкера)
mcID = 17 переходная для нерж.ст.
*/
case
	when stdpd2.posdefID = 1 -- поз номер 2 (stdpd2) - арматура (posdefID 1)
	then 

		CASE
			When pos3.mcID = 14 and pos_prop_3.width IS not NULL Then 1
			When pos3.mcID = 14 and pos_prop_3.diameter IS not NULL Then 2
			When pos3.mcID = 17 and pos_prop_3.width IS not NULL Then 3
			--When ...
			Else 0
		END

	else 

		CASE
			When pos2.mcID = 14 and pos_prop_2.width IS not NULL Then 1
			When pos2.mcID = 14 and pos_prop_2.diameter IS not NULL Then 2
			When pos2.mcID = 17 and pos_prop_2.width IS not NULL Then 3
			--When ...
			Else 0
		END

end as ancTermType 


FROM            dbo.view_part2 

INNER JOIN                         dbo.position AS pos1 ON dbo.view_part2.partID = pos1.partID and pos1.posNumber=1
INNER JOIN                         dbo.position AS pos2 ON dbo.view_part2.partID = pos2.partID and pos2.posNumber=2
LEFT JOIN                          dbo.position AS pos3 ON dbo.view_part2.partID = pos3.partID and pos3.posNumber=3

INNER JOIN                         dbo.sortament srtm1 ON pos1.srtmID = srtm1.srtmID 
INNER JOIN                         dbo.r_standard_posdef stdpd1 ON srtm1.stdposdefID = stdpd1.relID 
LEFT OUTER JOIN                    dbo.r_sortament_property srtm_prop_1 ON pos1.srtmID = srtm_prop_1.srtmID 
LEFT OUTER JOIN                    dbo.r_position_property pos_prop_1 ON pos1.posID = pos_prop_1.posID 

INNER JOIN                         dbo.sortament srtm2 ON pos2.srtmID = srtm2.srtmID 
INNER JOIN                         dbo.r_standard_posdef stdpd2 ON srtm2.stdposdefID = stdpd2.relID 
LEFT OUTER JOIN                    dbo.r_sortament_property srtm_prop_2 ON pos2.srtmID = srtm_prop_2.srtmID 
LEFT OUTER JOIN                    dbo.r_position_property pos_prop_2 ON pos2.posID = pos_prop_2.posID

LEFT JOIN                         dbo.sortament srtm3 ON pos3.srtmID = srtm3.srtmID 
LEFT JOIN                         dbo.r_standard_posdef stdpd3 ON srtm3.stdposdefID = stdpd3.relID 
LEFT OUTER JOIN                    dbo.r_sortament_property srtm_prop_3 ON pos3.srtmID = srtm_prop_3.srtmID 
LEFT OUTER JOIN                    dbo.r_position_property pos_prop_3 ON pos3.posID = pos_prop_3.posID

WHERE        
(dbo.view_part2.deleted = 0) -- not deleted
AND (pos1.mcID != 16) -- гнутая пластина аля уголок уходит во вьюху уголков
AND (pos1.posNumber = 1) 
AND (stdpd1.posdefID = 2 OR stdpd1.posdefID = 8) -- pos1 only plate
AND 
(
 -- pos2 bar, pos3 plate
((stdpd2.posdefID = 1) AND (stdpd3.posdefID = 2 OR stdpd3.posdefID = 8 OR stdpd3.posdefID IS NULL))
OR
 -- pos2 plate, pos3 bar
((stdpd3.posdefID = 1) AND (stdpd2.posdefID = 2 OR stdpd2.posdefID = 8 OR stdpd2.posdefID IS NULL))
)

--=====================================
--AND catID=45878 -- закладные лаэс 2006 бл 3 4 
--=====================================

GO
