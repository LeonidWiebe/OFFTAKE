SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[view_i_FH1_List_Of_Rooms_RU]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,

LEFT(dbo.i_Space.number, 7) AS [KKS отметки],

dbo.i_Space.number AS [KKS код помещения],

CASE 
	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'Зона контролируемого доступа'
	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'Зона свободного доступа'
	ELSE dbo.i_Space.AccessArea
END AS [Зона доступа],


  
dbo.i_Space.label AS [Наименование помещения], 
dbo.getTrueArea2(dbo.elements.simID, 0, 1) AS Площадь,

--CASE 
--	WHEN dbo.i_Space.SPF_FireLoadGroup in ('&lt;600','&lt; 600','<600') THEN '< 600'
--	WHEN dbo.i_Space.SPF_FireLoadGroup in ('600 - 1200',' 600 - 1200')THEN '600-1200'
--	WHEN dbo.i_Space.SPF_FireLoadGroup In ('&gt;1200','&gt; 1200') THEN '> 1200'
--	WHEN dbo.i_Space.SPF_FireLoadGroup = 'от 600 до 1200' THEN '?!!'
--	WHEN dbo.i_Space.SPF_FireLoadGroup = '' THEN 'Нет данных'
--	ELSE dbo.i_Space.SPF_FireLoadGroup
--END AS 'Пожарная нагрузка',
dbo.getFireLoadGroup(dbo.i_Space.SPF_FireLoadGroup) as [Пожарная нагрузка],

CASE 
	WHEN dbo.i_Space.RadiationZone = '3/Zone 2' THEN '3'
	WHEN dbo.i_Space.RadiationZone = '1/Zone 1' THEN '1'
	WHEN dbo.i_Space.RadiationZone = '0/-' THEN '0'
	WHEN dbo.i_Space.RadiationZone = '4/Zone 2' THEN '4'
	WHEN dbo.i_Space.RadiationZone = '2/Zone 1' THEN '2'
	WHEN dbo.i_Space.RadiationZone = '5/Zone 3' THEN '5'
	WHEN dbo.i_Space.RadiationZone = '' THEN 'Нет данных'
	ELSE dbo.i_Space.RadiationZone
END AS 'Зона радиации',

CASE 
	WHEN dbo.i_Space.WallInteriorFinish = 'W1 Epoxy paint' THEN 'W1'
	WHEN dbo.i_Space.WallInteriorFinish = 'W2 Decontaminable epoxy paint' THEN 'W2'
	WHEN dbo.i_Space.WallInteriorFinish = 'W3 Water-based paint' THEN 'W3'
	WHEN dbo.i_Space.WallInteriorFinish = 'W4 Acrylic paint' THEN 'W4'
	WHEN dbo.i_Space.WallInteriorFinish = 'W5 Lining with stainless steel' THEN 'W5'
	WHEN dbo.i_Space.WallInteriorFinish = 'W6 Ceramic tiles' THEN 'W6'
	WHEN dbo.i_Space.WallInteriorFinish = 'W6,W3 Ceramic tiles and Water-based paint' THEN 'W6,W3'
	WHEN dbo.i_Space.WallInteriorFinish = 'W5,W1 Lining with stainless steel and Epoxy paint' THEN 'W5,W1'
	ELSE dbo.i_Space.WallInteriorFinish
END AS 'Стены',

CASE 
	WHEN dbo.i_Space.TopCoatLayer = 'FL1 Epoxy paint' THEN 'FL1'
	WHEN dbo.i_Space.TopCoatLayer = 'FL2 Self-leveling floors' THEN 'FL2'
	WHEN dbo.i_Space.TopCoatLayer = 'FL3 Self-leveling floors' THEN 'FL3'
	WHEN dbo.i_Space.TopCoatLayer = 'FL4 Concrete with grinding' THEN 'FL4'
	WHEN dbo.i_Space.TopCoatLayer = 'FL5 Lining with stainless steel' THEN 'FL5'
	WHEN dbo.i_Space.TopCoatLayer = 'FL6 Ceramic tiles' THEN 'FL6'
	WHEN dbo.i_Space.TopCoatLayer = 'FL7 Polyvinylchloride linoleum with thermal insulation base' THEN 'FL7'
	WHEN dbo.i_Space.TopCoatLayer = 'FL8 Ceramic granite' THEN 'FL8'
	ELSE dbo.i_Space.TopCoatLayer
END AS 'Пол',


CASE 
	WHEN dbo.i_Space.CeilInteriorFinish = 'C1 Epoxy paint' THEN 'C1'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C2 Decontaminable epoxy paint' THEN 'C2'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C3 Water-based paint' THEN 'C3'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C4 Acrylic paint' THEN 'C4'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C5 Lining with stainless steel' THEN 'C5'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C6 Suspended ceiling' THEN 'C6'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C6 Suspended ceiling' THEN 'C6'
	ELSE dbo.i_Space.CeilInteriorFinish
END AS 'Потолок',

--dbo.getTrueSpaceHeight(dbo.elements.simID, 0, 2) AS [Высота помещения],
dbo.getZero(round((dbo.elements.pMaxZ - dbo.elements.pMinZ)* 1e-3, 1)) AS [Высота помещения],
LEFT(dbo.i_Space.number, 5) AS [KKS здания]


FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID















GO
