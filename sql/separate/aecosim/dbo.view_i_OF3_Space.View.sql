SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE VIEW [dbo].[view_i_OF3_Space]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
dbo.i_Space.Doc2_ID,
dbo.i_Space.number AS kks, 
dbo.i_Space.label AS [name rus], 
dbo.i_Space.label2 AS [name eng], 
--dbo.getTrueArea(dbo.i_Space.actualGross, dbo.elements.elemarea)  AS 'area',
dbo.getTrueArea2(dbo.elements.simID, 1, 2)  AS 'area',
dbo.getTrueVolume(dbo.elements.simID, 1, 2) AS volume, 
dbo.i_Space.AccessArea AS [access area], 
dbo.i_Space.SafetyCanal AS [safety channel], 

dbo.i_Space.NumFireComp AS [fire comp number], 
dbo.i_Space.SignFireComp AS [fire comp sign], 
dbo.i_Space.ProtectionLevel AS [protection level], 
dbo.i_Space.SPF_FireLoadGroup AS [fire load group], -- getFireLoadGroup?
dbo.i_Space.SPF_FireHazardClass AS [fire hazard class], 
dbo.i_Space.SPF_Speciality AS speciality, 
dbo.i_Space.SPF_RadiationSafetyAreaYVLC2 AS [radiation safety area], 

dbo.elements.dtID, 

dd.project_name, 
dd.bldName, 
dd.deleted

FROM         dbo.elements 

INNER JOIN dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id










GO
