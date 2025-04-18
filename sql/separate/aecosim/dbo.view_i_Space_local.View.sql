SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_Space_local]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
dbo.i_Space.number AS kks, 
dbo.i_Space.label AS [name rus], 
dbo.i_Space.label2 AS [name eng], 
dbo.i_Space.actualGross AS area, 
--dbo.elements.elemVolume AS volume, 
dbo.getTrueVolume(dbo.elements.simID, 1, 2) AS volume, 
dbo.i_Space.AccessArea AS [access area], 
dbo.i_Space.SafetyCanal AS [safety channel], 
dbo.i_Space.NumFireComp AS [kks fire comp], 
dbo.i_Space.SignFireComp AS [kks safety div], 
dbo.i_Space.Doc2_ID,
--dbo.i_Space.ProtectionLevel AS [protection level], 
--dbo.i_Space.SPF_FireLoadGroup AS [fire load group], 
--dbo.i_Space.SPF_FireHazardClass AS [fire hazard class], 
--dbo.i_Space.SPF_Speciality AS speciality, 
--dbo.i_Space.SPF_RadiationSafetyAreaYVLC2 AS [radiation safety area], 
dbo.elements.dtID

FROM         dbo.elements 

INNER JOIN dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID




GO
