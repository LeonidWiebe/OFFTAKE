SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_Space_Fire_EN]
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
	WHEN dbo.i_Space.SafetyCanal is NULL THEN '?!!'
	ELSE '00'
END AS [Safety Division],


dbo.i_Space.NumFireComp AS [KKS code of Fire Compartment],  

dbo.i_Space.number AS [KKS code of room],  


dbo.i_Space.label2 AS [Name of room], 


-- dbo.i_Space.actualGross * 1e-10 AS area,
--dbo.getTrueArea(round(dbo.i_Space.actualGross * 1e-10, 1, 1) ,round(dbo.elements.elemarea * 1e-10, 1, 1))  AS [Area, m2],
dbo.getTrueArea2(dbo.elements.simID, 0, 2) AS [Area, m2],

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
END AS 'Specific fire load value', -- getFireLoadGroup?



CASE 
	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'CA'
	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'SA'
	WHEN dbo.i_Space.AccessArea = 'CAA' THEN 'CA'
	WHEN dbo.i_Space.AccessArea = '' THEN '?!!'
	ELSE dbo.i_Space.AccessArea
END AS [Acess area],

CASE 
	WHEN dbo.i_Space.SPF_FireHazardClass = '1' THEN '1'
	WHEN dbo.i_Space.SPF_FireHazardClass = '2' THEN '2'
	ELSE '?!!'
END AS [Fire hazard class],

CASE 
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'отсутсвует' THEN 'no'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'отсутствует ()' THEN 'no'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'отсутствует' THEN 'no'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'комбинированный (combine)' THEN 'yes'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'комбинированный ( combine)' THEN 'yes'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Дым (smoke); Тепло (warm)' THEN 'yes'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Дым (smoke)' THEN 'yes'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Тепло (warm)' THEN 'yes'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Дым (smoke); Пламя (flame)' THEN 'yes'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Пламя (flame)' THEN 'yes'
	WHEN dbo.i_Space.SPF_TypeOfDetectors = '' THEN '?!!'
	WHEN dbo.i_Space.SPF_TypeOfDetectors is NULL THEN '?!!'
	ELSE dbo.i_Space.SPF_TypeOfDetectors
END AS [Availability of fire detection system],

CASE 
	WHEN left(dbo.i_Space.SPF_AvailabilityOfFAS,3) = 'нет' THEN 'no'
	WHEN left(dbo.i_Space.SPF_AvailabilityOfFAS,2) = 'да' THEN 'yes'
	WHEN dbo.i_Space.SPF_AvailabilityOfFAS = '' THEN '?!!'
	WHEN dbo.i_Space.SPF_AvailabilityOfFAS = NULL THEN '?!!'
	ELSE dbo.i_Space.SPF_AvailabilityOfFAS
END AS [Availability of fire alarm system],

CASE 
	WHEN left(dbo.i_Space.SPF_AvailOfAFFP,3) = 'нет' THEN 'no'
	WHEN left(dbo.i_Space.SPF_AvailOfAFFP,2) = 'да' THEN 'yes'
	WHEN dbo.i_Space.SPF_AvailOfAFFP = '' THEN '?!!'
	WHEN dbo.i_Space.SPF_AvailOfAFFP = NULL THEN '?!!'
	ELSE dbo.i_Space.SPF_AvailOfAFFP
END AS [Availability of AFFP],


CASE 
	WHEN dbo.i_Space.SPF_FireFightAgent = 'Вода (water)' THEN 'water'
	WHEN dbo.i_Space.SPF_FireFightAgent = 'Газ (gas)' THEN 'gas'
	WHEN dbo.i_Space.SPF_FireFightAgent = 'Пена (foam)' THEN 'foam'
	WHEN dbo.i_Space.SPF_FireFightAgent = NULL THEN '?!!'
	WHEN dbo.i_Space.SPF_FireFightAgent = '' THEN '?!!'
	WHEN dbo.i_Space.SPF_FireFightAgent = 'отсутствует' THEN 'no'
	WHEN left(dbo.i_Space.SPF_FireFightAgent,3) = 'Нет' THEN 'no'
	ELSE dbo.i_Space.SPF_FireFightAgent
END AS [Fire-fighting agent],

CASE 
	WHEN dbo.i_Space.ProtectionLevel = 'отсутствует' THEN '1'
	WHEN dbo.i_Space.ProtectionLevel = '' THEN '?!!'
	WHEN dbo.i_Space.ProtectionLevel = NULL THEN '?!!'
	ELSE dbo.i_Space.ProtectionLevel
END AS [Protection level],

CASE 
	WHEN dbo.i_Space.SPF_FireClassRating = '60' THEN '60'
	WHEN dbo.i_Space.SPF_FireClassRating = '90' THEN '90'
	WHEN dbo.i_Space.SPF_FireClassRating = '120' THEN '120'
	ELSE '?!!'
END AS [Fire rating FC:wall, slab],


'60/' + dbo.i_Space.SPF_FireClassRating AS [Fire rating FC:penetrations], 

CASE 
	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN '-'
	ELSE '120'
END AS [Fire rating SD:wall, slab],

CASE 
	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN '-'
	ELSE '120/120'
END AS [Fire rating SD:penetrations]



FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID













GO
