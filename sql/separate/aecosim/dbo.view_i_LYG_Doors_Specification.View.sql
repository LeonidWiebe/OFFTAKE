SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_LYG_Doors_Specification]
AS
SELECT   
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
dbo.i_DoorProperties.KKS AS KKS,
dbo.getLYG_Door_Mark(dbo.i_DoorProperties.Location,
						dbo.i_DoorProperties.FireResistance,
						dbo.i_DoorProperties.Tightness,
						dbo.i_DoorProperties.RemoteControl,
						dbo.i_DoorProperties.Lock,
						dbo.i_DoorProperties.ShockWave,
						dbo.i_DoorProperties.SafetyClass,
						dbo.i_DoorProperties.SeismicClass,
						dbo.i_DoorProperties.OtherFunctions,
						dbo.i_DoorProperties.ElectricalDrive,
						dbo.i_DoorProperties.Locks,
						dbo.i_DoorProperties.Opening,
						dbo.i_DoorProperties.DimensionType,
						dbo.i_DoorProperties.Material,
						dbo.elements.catitem) 
						AS 'Марка двери',
dbo.elements.dtID,

case
	--Пример
	-- колонна как стена
	--when dbo.elements.cattype like '%column%' and dbo.elements.pMinZ >= 4800 then 'Надземная часть'
	-- балка как плита
	--when dbo.elements.cattype like '%beam%' and dbo.elements.pMaxZ > 4800 then 'Надземная часть'
	
	--when dbo.elements.pMinZ >=0 then 'Надземная часть' -- неверный вариант
	when LEN(KKS)<>12 then 'Недопустимый KKS!'
	when CAST( SUBSTRING(KKS, 6, 2) AS INT ) < 90 then 'Надземная часть'
	else 'Подземная часть'
end
	AS elemLevel,
--dbo.elements.pMinZ as elemLevel,

doc.o_filename AS o_filename

FROM         dbo.elements 

INNER JOIN dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID 
LEFT JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid


GO
