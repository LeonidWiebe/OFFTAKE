SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_PKS2_List_Of_Rooms_RU]
AS
SELECT    
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,

LEFT(dbo.i_Space.number, 7) AS [KKS отметки],



CASE 
	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'Зона контролируемого доступа' 
	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'Зона свободного доступа'
	WHEN dbo.i_Space.AccessArea = 'Controlled access area' THEN 'Зона контролируемого доступа' 
	WHEN dbo.i_Space.AccessArea = 'Uncontrolled access area' THEN 'Зона свободного доступа'
	ELSE dbo.i_Space.AccessArea
END AS [AcessArea],



dbo.i_Space.number AS [kks],  
dbo.i_Space.label  AS [name], 
dbo.getZero2(dbo.getTrueArea2(dbo.elements.simID, 0, 2))  AS area,
--dbo.getZero(dbo.getTrueSpaceHeight(dbo.elements.simID, 0, 2)) AS [Average Ceiling Height],
--dbo.getZero(round((dbo.elements.pMaxZ - dbo.elements.pMinZ)* 1e-3, 1)) AS [Ceiling Height],
CASE 
	WHEN dbo.getTrueArea2(dbo.elements.simID, 0, 2) > 0 THEN 
	dbo.getZero2(dbo.getTrueVolume(dbo.elements.simID, 0, 2) / dbo.getTrueArea2(dbo.elements.simID, 0, 2))
	ELSE 
	'караул!'
END AS [Average Ceiling Height],

--CASE 
--	WHEN dbo.i_Space.TopCoatLayer = 'FL1 Epoxy paint' THEN 'FL1'
--	WHEN dbo.i_Space.TopCoatLayer = 'FL2 Self-leveling floors' THEN 'FL2'
--	WHEN dbo.i_Space.TopCoatLayer = 'FL3 Decontaminable self-leveling floors' THEN 'FL3'
--	WHEN dbo.i_Space.TopCoatLayer = 'FL4 Concrete with grinding' THEN 'FL4'
--	WHEN dbo.i_Space.TopCoatLayer = 'FL5 Lining with stainless steel' THEN 'FL5'
--	WHEN dbo.i_Space.TopCoatLayer = 'FL6 Ceramic tiles' THEN 'FL6'
--	WHEN dbo.i_Space.TopCoatLayer = 'FL7 Polyvinylchloride linoleum with thermal insulation base' THEN 'FL7'
--	WHEN dbo.i_Space.TopCoatLayer = 'FL8 Ceramic granite' THEN 'FL8'
--	ELSE dbo.i_Space.TopCoatLayer
--END AS 'Top Coat Layer',

rtrim(left(dbo.i_Space.TopCoatLayer,4)) AS 'Top Coat Layer',

--CASE 
--	WHEN dbo.i_Space.WallInteriorFinish = 'W1 Epoxy paint' THEN 'W1'
--	WHEN dbo.i_Space.WallInteriorFinish = 'W2 Decontaminable epoxy paint' THEN 'W2'
--	WHEN dbo.i_Space.WallInteriorFinish = 'W3 Water-based paint' THEN 'W3'
--	WHEN dbo.i_Space.WallInteriorFinish = 'W4 Acrylic paint' THEN 'W4'
--	WHEN dbo.i_Space.WallInteriorFinish = 'W5 Lining with stainless steel' THEN 'W5'
--	WHEN dbo.i_Space.WallInteriorFinish = 'W6 Ceramic tiles' THEN 'W6'
--	WHEN dbo.i_Space.WallInteriorFinish = 'W6,W3 Ceramic tiles and Water-based paint' THEN 'W6,W3'
--	WHEN dbo.i_Space.WallInteriorFinish = 'W5,W1 Lining with stainless steel and Epoxy paint' THEN 'W5,W1'
--	ELSE dbo.i_Space.WallInteriorFinish
--END AS 'Wall Interior Finish',

CASE 
	WHEN SUBSTRING(dbo.i_Space.WallInteriorFinish,3,1) = ',' THEN LEFT(dbo.i_Space.WallInteriorFinish,5)
	ELSE LEFT(dbo.i_Space.WallInteriorFinish,3)
END AS 'Wall Interior Finish',

--CASE 
--	WHEN dbo.i_Space.CeilInteriorFinish = 'C1 Epoxy paint' THEN 'C1'
--	WHEN dbo.i_Space.CeilInteriorFinish = 'C2 Decontaminable epoxy paint' THEN 'C2'
--	WHEN dbo.i_Space.CeilInteriorFinish = 'C3 Water-based paint' THEN 'C3'
--	WHEN dbo.i_Space.CeilInteriorFinish = 'C4 Acrylic paint' THEN 'C4'
--	WHEN dbo.i_Space.CeilInteriorFinish = 'C5 Lining with stainless steel' THEN 'C5'
--	WHEN dbo.i_Space.CeilInteriorFinish = 'C6 Suspended ceiling' THEN 'C6'
--	WHEN dbo.i_Space.CeilInteriorFinish = 'C6 Suspended ceiling' THEN 'C6'
--	ELSE dbo.i_Space.CeilInteriorFinish
--END AS 'Ceil Interior Finish',

left(dbo.i_Space.CeilInteriorFinish,2) AS 'Ceil Interior Finish',

CASE /*добавил новый атрибут по просьбе архитеткоров в январе 2023*/
	WHEN dbo.i_Space.FloorWaterproofed = 'Waterproofed' THEN 'Да'
	WHEN dbo.i_Space.FloorWaterproofed = 'n/a' THEN 'Нет'
	ELSE dbo.i_Space.FloorWaterproofed
END AS 'Наличие гидроизоляции',

CASE 
	WHEN dbo.i_Space.SPF_FireLoadGroup = '<500' THEN '< 500'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '500>' THEN '500 >'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '500 - 1500' THEN '500-1500'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 500>' THEN '500 >'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' <500' THEN '< 500'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 500 - 1500' THEN '500-1500'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '>1500' THEN '> 1500'
	WHEN dbo.i_Space.SPF_FireLoadGroup = 'от 600 до 1200' THEN '?!!'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '' THEN 'Нет данных'
	ELSE dbo.i_Space.SPF_FireLoadGroup
END AS 'Fire load',


CASE /*вернули строку по просьбе архитекторов группы Пакш в ноябре 2020*/
	WHEN dbo.i_Space.RadiationZone = '3/Zone 2' THEN '3'
	WHEN dbo.i_Space.RadiationZone = '1/Zone 1' THEN '1'
	WHEN dbo.i_Space.RadiationZone = '0/-' THEN '0'
	WHEN dbo.i_Space.RadiationZone = '4/Zone 2' THEN '4'
	WHEN dbo.i_Space.RadiationZone = '2/Zone 1' THEN '2'
	WHEN dbo.i_Space.RadiationZone = '5/Zone 3' THEN '5'
	WHEN dbo.i_Space.RadiationZone = '' THEN 'Нет данных'
	ELSE dbo.i_Space.RadiationZone
END AS 'Radiation zone',


Doc2.safety_class_room AS 'Класс безопасности помещения',

LEFT(dbo.i_Space.number, 5) AS [KKS здания]


FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
LEFT OUTER JOIN [10.36.69.20].[PKS].[dbo].[Room_charact] AS Doc2 ON i_Space.simid = Doc2.simid

--view_i_PKS2_List_Of_Rooms_RU

































GO
