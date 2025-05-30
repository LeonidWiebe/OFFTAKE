SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_LYG_Doors]
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

dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 2)) AS [Высотная отметка],

dbo.i_DoorProperties.Location AS 'Место расположения', 
dbo.i_DoorProperties.FireResistance AS 'Предел огнестойкости', 
dbo.i_DoorProperties.Tightness AS 'Герметичность', 
dbo.i_DoorProperties.RemoteControl AS 'Дистанционный контроль',
dbo.i_DoorProperties.Lock AS 'Блокировка',
dbo.i_DoorProperties.ShockWave AS 'Ударная волна',
dbo.i_DoorProperties.SafetyClass AS 'Класс безопасности',
dbo.i_DoorProperties.SeismicClass AS 'Категория сейсмостойкости',
dbo.i_DoorProperties.OtherFunctions AS 'Прочие особые функции',
dbo.i_DoorProperties.ElectricalDrive AS 'Электропривод',
dbo.i_DoorProperties.Locks AS 'Замки',
dbo.i_DoorProperties.Opening AS 'Открывание',
dbo.i_DoorProperties.DimensionType AS 'Типоразмер двери',
dbo.i_DoorProperties.Material AS 'Материал',

dbo.i_DoorProperties.KKS_Room1 AS 'Код KKS помещения 1',
dbo.i_DoorProperties.KKS_Room2 AS 'Код KKS помещения 2',

round(dbo.i_Dimensions.width * 1e-3, 2, 2) AS [width] ,
round(dbo.i_Dimensions.height * 1e-3, 2, 2) AS [height],
dbo.elements.dtID,


doc.o_filename AS o_filename

FROM         dbo.elements 

INNER JOIN dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID 
LEFT JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid











GO
