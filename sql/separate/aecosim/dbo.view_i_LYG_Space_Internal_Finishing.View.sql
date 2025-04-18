SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[view_i_LYG_Space_Internal_Finishing]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
dbo.i_Space.Doc2_ID,
dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 1)) AS [Level],
CASE 
	WHEN dbo.elements.pMinZ < 0 THEN 'Подземная часть'
	ELSE 'Надземная часть'
END AS 'Расположение',

dbo.i_Space.number AS kks, 

dbo.getTrueSpaceHeight(dbo.elements.simID, 0, 2) AS [Ceiling Height],

dbo.getzero2(dbo.getTrueArea2(dbo.elements.simID, 0, 2))  AS 'Floor area',

dbo.getzero2(dbo.getTrueArea2(dbo.elements.simID, 0, 2))  AS 'Ceiling area',

dbo.getTrueVertArea(dbo.elements.simID, 0, 2) as 'Wall Area',

dbo.i_RoomAttributes.FinishingGroup AS [Group of internal finishing],

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
END AS 'Floor coating',


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
END AS 'Ceiling coating',

CASE 
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S1' THEN 'F-W1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S2' THEN 'F-W2'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S3' THEN 'F-W3'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4' THEN 'F-W4'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S5' THEN 'F-W5'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/1' THEN 'F-W4/1'
	WHEN dbo.i_RoomAttributes.FinishingGroup = 'S4/2' THEN 'F-W4/2'
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
END AS 'Wall coating',

dbo.elements.dtID, 

dd.project_name,
dd.bldID
--dd.deleted

FROM         dbo.elements 

INNER JOIN dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
left JOIN dbo.i_RoomAttributes ON dbo.elements.simID = dbo.i_RoomAttributes.simID










GO
