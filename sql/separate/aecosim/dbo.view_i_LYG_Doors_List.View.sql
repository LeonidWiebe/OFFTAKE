SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_LYG_Doors_List]
AS
SELECT   
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
dbo.i_DoorProperties.KKS, 
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

dbo.i_DoorProperties.KKS_Room1 AS 'Код KKS помещения 1',
dbo.i_DoorProperties.KKS_Room2 AS 'Код KKS помещения 2',

--round(dbo.i_Dimensions.width * 1e-3, 2, 2) AS [width] ,
--round(dbo.i_Dimensions.height * 1e-3, 2, 2) AS [height],

CAST(round(dbo.i_Dimensions.width * 1e-3, 2, 2) as nvarchar ) + ' x ' + CAST(round(dbo.i_Dimensions.height * 1e-3, 2, 2) as nvarchar ) as 'Размер проема',
dbo.elements.dtID,

doc.o_filename AS o_filename

FROM         dbo.elements 

INNER JOIN dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID 
LEFT JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid


GO
