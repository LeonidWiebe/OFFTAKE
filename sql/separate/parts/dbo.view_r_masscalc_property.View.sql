SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_r_masscalc_property]
 AS

SELECT     

dbo.masscalc.mcName, 
dbo.r_masscalc_property.mcID, 
dbo.masscalc.calcID, 
dbo.property.propName, 
dbo.property.propID

FROM         dbo.r_masscalc_property 

LEFT OUTER JOIN dbo.property ON dbo.r_masscalc_property.propID = dbo.property.propID 
LEFT OUTER JOIN dbo.masscalc ON dbo.r_masscalc_property.mcID = dbo.masscalc.mcID


--SELECT     dbo.masscalc.mcName, dbo.r_masscalc_property.mcID, dbo.masscalc.calcID, dbo.property.propName, dbo.property.propID
--FROM         dbo.r_masscalc_property LEFT OUTER JOIN
--dbo.property ON dbo.r_masscalc_property.propID = dbo.property.propID LEFT OUTER JOIN
--dbo.masscalc ON dbo.r_masscalc_property.mcID = dbo.masscalc.mcID


GO
