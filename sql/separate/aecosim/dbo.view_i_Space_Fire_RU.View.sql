SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_Space_Fire_RU]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,

LEFT(dbo.i_Space.number, 5) AS [KKS здания],

CASE 
	WHEN dbo.i_Space.SafetyCanal = '1' THEN '01'
	WHEN dbo.i_Space.SafetyCanal = '2' THEN '02'
	WHEN dbo.i_Space.SafetyCanal = '3' THEN '03'
	WHEN dbo.i_Space.SafetyCanal = '4' THEN '04'
	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN '-'
	WHEN dbo.i_Space.SafetyCanal = '' THEN '?!!'
	WHEN dbo.i_Space.SafetyCanal = 'NULL' THEN '?!!'
	ELSE '00'
END AS [Безопасный отсек],

dbo.i_Space.NumFireComp AS [KKS код пожарного отсека],  


dbo.i_Space.number AS [KKS код помещения],  


dbo.i_Space.label AS [Название помещения], 


-- dbo.i_Space.actualGross * 1e-10 AS area,
--dbo.getTrueArea(round(dbo.i_Space.actualGross * 1e-10, 1, 1) ,round(dbo.elements.elemarea * 1e-10, 1, 1)) AS [Площадь, м2],
dbo.getTrueArea2(dbo.elements.simID, 0, 2) AS [Площадь, м2],

CASE 
	WHEN dbo.i_Space.SPF_FireLoadGroup = '<600' THEN '< 600'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '600>' THEN '600 >'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '600 - 1200' THEN '600-1200'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 600>' THEN '600 >'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' <600' THEN '< 600'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 600 - 1200' THEN '600-1200'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '>1200' THEN '> 1200'
	WHEN dbo.i_Space.SPF_FireLoadGroup = 'от 600 до 1200' THEN '?!!'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '' THEN '?!!'
	ELSE dbo.i_Space.SPF_FireLoadGroup
END AS 'Удельная пожарная нагрузка', -- getFireLoadGroup?



CASE 
	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'ЗКД'
	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'ЗСД'
	WHEN dbo.i_Space.AccessArea = 'CAA' THEN 'ЗКД'
	WHEN dbo.i_Space.AccessArea = 'SA' THEN 'ЗСД'
	WHEN dbo.i_Space.AccessArea = '' THEN '?!!'
	ELSE dbo.i_Space.AccessArea
END AS [Зона доступа],

CASE 
	WHEN dbo.i_Space.SPF_FireHazardClass = '1' THEN '1'
	WHEN dbo.i_Space.SPF_FireHazardClass = '2' THEN '2'
	ELSE '?!!'
END AS [Класс риска],

CASE 
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'отсутсвует' THEN 'нет'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'отсутствует ()' THEN 'нет'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'отсутствует' THEN 'нет'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'комбинированный (combine)' THEN 'да'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'комбинированный ( combine)' THEN 'да'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Дым (smoke); Тепло (warm)' THEN 'да'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Тепло (warm)' THEN 'да'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Дым (smoke)' THEN 'да'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Дым (smoke); Пламя (flame)' THEN 'да'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Пламя (flame)' THEN 'да'
	WHEN left(dbo.i_Space.SPF_TypeOfDetectors,3) = 'нет' THEN 'нет'
	WHEN left(dbo.i_Space.SPF_TypeOfDetectors,2) = 'да' THEN 'да'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'no' THEN 'нет'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'yes' THEN 'да'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = '' THEN '?!!'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = NULL THEN '?!!'
	ELSE dbo.i_Space.SPF_TypeOfDetectors
END AS [Наличие АПС],

CASE 
	WHEN left(dbo.i_Space.SPF_AvailabilityOfFAS,3) = 'нет' THEN 'нет'
	WHEN left(dbo.i_Space.SPF_AvailabilityOfFAS,2) = 'да' THEN 'да'
	WHEN dbo.i_Space.SPF_AvailabilityOfFAS = 'yes' THEN 'да'
	WHEN dbo.i_Space.SPF_AvailabilityOfFAS = 'no' THEN 'нет'
	WHEN dbo.i_Space.SPF_AvailabilityOfFAS = '' THEN '?!!'
	WHEN dbo.i_Space.SPF_AvailabilityOfFAS is NULL THEN '?!!'
	ELSE dbo.i_Space.SPF_AvailabilityOfFAS
END AS [Наличие СОУЭ],

CASE 
	WHEN left(dbo.i_Space.SPF_AvailOfAFFP,3) = 'нет' THEN 'нет'
	WHEN left(dbo.i_Space.SPF_AvailOfAFFP,2) = 'да' THEN 'да'
	WHEN dbo.i_Space.SPF_AvailOfAFFP = '' THEN '?!!'
	WHEN dbo.i_Space.SPF_AvailOfAFFP = NULL THEN '?!!'
	ELSE dbo.i_Space.SPF_AvailOfAFFP
END AS [Наличие АУПТ],


CASE 
	WHEN dbo.i_Space.SPF_FireFightAgent = 'Вода (water)' THEN 'вода'
	WHEN dbo.i_Space.SPF_FireFightAgent = 'Газ (gas)' THEN 'газ'
	WHEN dbo.i_Space.SPF_FireFightAgent = 'Пена (foam)' THEN 'пена'
	WHEN dbo.i_Space.SPF_FireFightAgent IS NULL  THEN '?!!'
	WHEN dbo.i_Space.SPF_FireFightAgent = '' THEN '?!!'
	WHEN dbo.i_Space.SPF_FireFightAgent = 'отсутствует' THEN 'нет'
	WHEN dbo.i_Space.SPF_FireFightAgent = 'Нет (No)' THEN 'нет'
	ELSE dbo.i_Space.SPF_FireFightAgent
END AS [Тип ОТВ],

CASE 
	WHEN dbo.i_Space.ProtectionLevel = 'отсутствует' THEN '1'
	WHEN dbo.i_Space.ProtectionLevel = '' THEN '?!!'
	WHEN dbo.i_Space.ProtectionLevel = NULL THEN '?!!'
	ELSE dbo.i_Space.ProtectionLevel
END AS [Уровень защиты],

CASE 
	WHEN dbo.i_Space.SPF_FireClassRating = '60' THEN '60'
	WHEN dbo.i_Space.SPF_FireClassRating = '90' THEN '90'
	WHEN dbo.i_Space.SPF_FireClassRating = '120' THEN '120'
	ELSE '?!!'
END AS [Предел огнестойкости ПО:стены, плиты],


'60/' + dbo.i_Space.SPF_FireClassRating AS [Предел огнестойкости ПО:проемы], 

CASE 
	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN '-'
	ELSE '120'
END AS [Предел огнестойкости БО:стены, плиты],

CASE 
	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN '-'
	ELSE '120/120'
END AS [Предел огнестойкости БО:проемы]



FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID















GO
