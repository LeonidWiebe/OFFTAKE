SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_LYG_Space]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
dbo.i_Space.Doc2_ID,
dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 1)) AS [Level],

CASE 
	WHEN len(dd.bldname)=5 and len(dbo.i_Space.number)=11 and right(dd.bldname,3)!='UJA' THEN dd.bldname + right(dbo.i_Space.number,6) -- 71UCB49R311
	ELSE dbo.i_Space.number
END AS kks,

dbo.i_Space.number AS kks_from_table, 

dbo.i_Space.label2 AS [name rus], 
dbo.i_Space.label AS [name eng], 

-- Ceiling Height
dbo.getTrueSpaceHeight(dbo.elements.simID, 0, 2) AS 'Ceiling Height',
dbo.i_Space.heightMan as heightMan,

-- Floor Area
dbo.getzero2(dbo.getTrueArea2(dbo.elements.simID, 0, 2))  AS 'Floor Area',
dbo.elements.elemareaMan AS FloorAreaManual,

-- Vertical Area
dbo.getTrueVertArea(dbo.elements.simID, 0, 2) as 'Vertical Area',
dbo.elements.elemvertareaMan as VertAreaManual,

round(convert(real,dbo.i_space.perimeter) / dbo.elements.uors, 1) as [Perimeter],

dbo.getTrueVolume(dbo.elements.simID, 0, 2) AS volume,
dbo.elements.elemVolumeMan AS volumeMan,

dbo.i_RoomAttributes.AccessArea AS [access area], 
--dbo.i_RoomAttributes.SafetyTrain AS [safety train], -- исключен потому что этот атрибут должен приходить из Док2
dbo.i_RoomAttributes.Speciality AS [speciality], 
dbo.i_Space.NumFireComp AS [fire comp number], 
--dbo.i_RoomAttributes.FireLoadGroup AS [fire load group],  -- исключен потому что этот атрибут должен приходить из Док2
dbo.i_RoomAttributes.FinishingGroup AS [Finishing Group],

CASE 
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S1' THEN 'S-P1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S2' THEN 'S-P2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S3' THEN 'S-P3'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4' THEN 'S-P4'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S5' THEN 'S-P5'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/1' THEN 'S-P4/1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/2' THEN 'S-P4/2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F1' THEN 'F-P1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F2' THEN 'F-P2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F3' THEN 'F-P3'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F4' THEN 'F-P4'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F5' THEN 'F-P5'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F6' THEN 'F-P6'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F7' THEN 'F-P7'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F8' THEN 'F-P8'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F9' THEN 'F-P9'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'A1' THEN 'A-P1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = '-' THEN ' нет отделки'
	ELSE dbo.i_RoomAttributes.FinishingGroup + ' Не корректные данные'
END AS 'Внутренняя отделка пола',


CASE 
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S1' THEN 'S-C1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S2' THEN 'S-C2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S3' THEN 'S-C3'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4' THEN 'S-C4'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S5' THEN 'S-C5'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/1' THEN 'S-C4/1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/2' THEN 'S-C4/2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F1' THEN 'F-C1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F2' THEN 'F-C2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F3' THEN 'F-C3'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F4' THEN 'F-C4'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F5' THEN 'F-C5'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F6' THEN 'F-C6'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F7' THEN 'F-C7'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F8' THEN 'F-C8'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F9' THEN 'F-C9'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'A1' THEN 'A-C1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = '-' THEN ' нет отделки'
	ELSE dbo.i_RoomAttributes.FinishingGroup + ' Не корректные данные'
END AS 'Внутренняя отделка потолка',

CASE 
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S1' THEN 'S-W1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S2' THEN 'S-W2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S3' THEN 'S-W3'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4' THEN 'S-W4'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S5' THEN 'S-W5'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/1' THEN 'S-W4/1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/2' THEN 'S-W4/2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F1' THEN 'F-W1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F2' THEN 'F-W2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F3' THEN 'F-W3'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F4' THEN 'F-W4'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F5' THEN 'F-W5'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F6' THEN 'F-W6'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F7' THEN 'F-W7'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F8' THEN 'F-W8'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F9' THEN 'F-W9'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'A1' THEN 'A-W1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = '-' THEN ' нет отделки'
	ELSE dbo.i_RoomAttributes.FinishingGroup + ' Не корректные данные'
END AS 'Внутренняя отделка стен',

-- Изменил внутреннюю отделку стен в зависимости от финишинг груп
--CASE 
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S1' THEN 'F-W1'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S2' THEN 'F-W2'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S3' THEN 'F-W3'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4' THEN 'F-W4'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S5' THEN 'F-W5'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/1' THEN 'F-W4/1'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/2' THEN 'F-W4/2'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F1' THEN 'F-W1'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F2' THEN 'F-W2'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F3' THEN 'F-W3'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F4' THEN 'F-W4'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F5' THEN 'F-W5'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F6' THEN 'F-W6'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F7' THEN 'F-W7'
--	WHEN dbo.i_RoomAttributes.FinishingGroup = 'F8' THEN 'F-W8'
--	ELSE dbo.i_RoomAttributes.FinishingGroup + ' Не корректные данные'
--END AS 'Внутренняя отделка стен',

dbo.i_RoomAttributes.KKSFireZone AS [KKS code of fire zone], 

dbo.elements.dtID, 

dd.project_name, 
dd.deleted,
dd.bldname as bld_kks_code,
dd.old_file_name as file_path

FROM         dbo.elements 

INNER JOIN dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
left JOIN dbo.i_RoomAttributes ON dbo.elements.simID = dbo.i_RoomAttributes.simID








GO
