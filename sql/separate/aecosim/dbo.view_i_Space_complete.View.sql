SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- делаем выгрузку всех данных для док2




CREATE VIEW [dbo].[view_i_Space_complete]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
dbo.i_Space.number AS kks, 
dbo.i_Space.label AS [name rus], 
dbo.i_Space.label2 AS [name eng], 
--dbo.i_Space.actualGross AS area, 
dbo.getTrueArea2(dbo.elements.simID, 1, 0) AS area,
--dbo.elements.elemVolume AS volume, 
dbo.getTrueVolume(dbo.elements.simID, 1, 2) AS volume, 
dbo.i_Space.AccessArea AS [access area], 
dbo.i_Space.SafetyCanal AS [safety channel], 

--dbo.i_Space.NumFireComp AS [fire comp number], 
--dbo.i_Space.SignFireComp AS [fire comp sign], 
--dbo.i_Space.ProtectionLevel AS [protection level], 
--dbo.i_Space.SPF_FireLoadGroup AS [fire load group], 
--dbo.i_Space.SPF_FireHazardClass AS [fire hazard class], 
dbo.i_Space.SPF_Speciality AS [Speciality], 
--dbo.i_Space.SPF_RadiationSafetyAreaYVLC2 AS [radiation safety area], 

case when rp.rfirediv is not null then (select plValue from parts.dbo.propertylist where plID = rp.rfirediv) end as [KKS Fire Div],
case when rp.rfirecomp is not null then (select plValue from parts.dbo.propertylist where plID = rp.rfirecomp) end as [KKS Fire Comp],
case when rp.rfireload is not null then (select plValue from parts.dbo.propertylist where plID = rp.rfireload) end as [Fire Load],
case when rp.rfirehaz is not null then (select plValue from parts.dbo.propertylist where plID = rp.rfirehaz) end as [Fire Hazard],
case when rp.rradzone is not null then (select plValue from parts.dbo.propertylist where plID = rp.rradzone) end as [Rad Zone],
case when rp.rprotectlev is not null then (select plValue from parts.dbo.propertylist where plID = rp.rprotectlev) end as [Protection Level],
rp.rfiredivres as [Fire Res Div], -- varchar
rp.rfirecompres as [Fire Res Comp], -- varchar
rp.rfextnum as [Fire Ext Number], -- bigint
case when rp.rfexttype is not null then (select plValue from parts.dbo.propertylist where plID = rp.rfexttype) end as [Fire Ext Type],
rp.rfextmass as [Fire Ext Weight], -- real

parts.dbo.[getPropListValue](dbo.i_Space.simID, 48) as [System Name], -- rsysname
parts.dbo.[getPropListValue](dbo.i_Space.simID, 54) as [Detector Type], -- rdettype
parts.dbo.[getPropListValue](dbo.i_Space.simID, 55) as [Annuncator Type], -- rannuntype
parts.dbo.[getPropListValue](dbo.i_Space.simID, 56) as [ExtSubst Type], -- rextsubst
parts.dbo.[getPropListValue](dbo.i_Space.simID, 57) as [FireVent Type], -- rfirevent

dbo.elements.dtID, 

dd.project_name, 
dd.deleted

FROM         dbo.elements 

INNER JOIN dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id

left outer join parts.dbo.r_room_property as rp on dbo.elements.simID = rp.roomID




GO
