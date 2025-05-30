SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_NW_FH1_Room_Attributes]
AS
SELECT   
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
dbo.i_Space.number AS 'Oder',	
dbo.i_Space.number AS '~Name',
dbo.i_Space.label2 +' / '+dbo.i_Space.label  AS '~Description',


-- забор кодов из таблицы отсеков - Вибе Л. 11.03.2021
CASE
 WHEN fc.fcCode is NULL Then dbo.i_Space.NumFireComp
 ELSE fc.fcCode  -- если определен в таблице отсеков то ставим код оттуда
END AS '~KKS code of fire compartment',
--dbo.i_Space.NumFireComp AS '~KKS code of fire compartment',
--fc.fcCode as fcCodeID,

CASE 
	WHEN dbo.i_Space.AccessArea = 'CA' THEN 'Controlled area'
	WHEN dbo.i_Space.AccessArea = 'SA' THEN 'Supervised area'
	WHEN dbo.i_Space.AccessArea = 'CAA' THEN 'Controlled area'
	ELSE dbo.i_Space.AccessArea
END AS '~Access area',

'Из Doc2 -->' AS Doc2,
--dbo.i_Space.RadiationZone AS '~Radiation zone',

Doc2.ra_avl AS '~Radiation zone',

Doc2.ra_avi_ppr AS '~Radiation zone at PPM',
Doc2.fire_load AS '~Fire load category',

----CASE 
----	WHEN dbo.i_Space.SPF_FireLoadGroup = '<600' THEN '< 600'
----	WHEN dbo.i_Space.SPF_FireLoadGroup = '600>' THEN '600 >'
----	WHEN dbo.i_Space.SPF_FireLoadGroup = '600-1200' THEN '600 - 1200'
----	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 600>' THEN '600 >'
----	WHEN dbo.i_Space.SPF_FireLoadGroup = ' <600' THEN '< 600'
----	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 600 - 1200' THEN '600 - 1200'
----	WHEN dbo.i_Space.SPF_FireLoadGroup = '>1200' THEN '> 1200'
----	ELSE dbo.i_Space.SPF_FireLoadGroup
----END AS '~Fire load category',
--dbo.getFireLoadGroup(dbo.i_Space.SPF_FireLoadGroup) as [~Fire load category],

'Из AECOsim -->' AS AECOsim,
dbo.i_Space.SPF_Speciality AS '~Responsible discipline',
dbo.i_Space.SafetyCanal AS '~Safety division',
--dbo.i_Space.SPF_FireHazardClass AS '~Fire hazard class',

'Из Doc2 -->' AS '_Doc2',
Doc2.risk_class_rack AS '~Fire hazard class',
Doc2.fire_udeln_calc AS '~Fire load per unit area for the room',

--CASE 
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'отсутсвует' THEN 'no'
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'отсутствует ()' THEN 'no'
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'отсутствует' THEN 'no'
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'комбинированный (combine)' THEN 'yes'
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'комбинированный ( combine)' THEN 'yes'
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Дым (smoke); Тепло (warm)' THEN 'yes'
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Дым (smoke)' THEN 'yes'
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Тепло (warm)' THEN 'yes'
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Дым (smoke); Пламя (flame)' THEN 'yes'
--	WHEN dbo.i_Space.SPF_TypeOfDetectors = 'Пламя (flame)' THEN 'yes'
--	ELSE dbo.i_Space.SPF_TypeOfDetectors
--END AS [~Availability of automatic fire detection system],

CASE 
	WHEN Doc2.aps_avl = 'да (yes)' THEN 'yes'
	WHEN Doc2.aps_avl = 'нет (no)' THEN 'no'
	ELSE Doc2.aps_avl
END AS [~Availability of automatic fire detection system],

--CASE 
--	WHEN dbo.i_Space.SPF_AvailabilityOfFAS = 'нет (no)' THEN 'no'
--	WHEN dbo.i_Space.SPF_AvailabilityOfFAS = 'да (yes)' THEN 'yes'
--	ELSE dbo.i_Space.SPF_AvailabilityOfFAS
--END AS [~Availability of fire alarm system],

CASE 
	WHEN Doc2.soue_avl = 'нет (no)' THEN 'no'
	WHEN Doc2.soue_avl = 'да (yes)' THEN 'yes'
	ELSE Doc2.soue_avl
END AS [~Availability of alarm and evacuation control system],

CASE 
	WHEN Doc2.autp_avl = 'нет (no)' THEN 'no'
	WHEN Doc2.autp_avl = 'да (yes)' THEN 'yes'
	ELSE Doc2.autp_avl
END AS [~Availability of automatic fire extinguishing system],

--CASE 
--	WHEN dbo.i_Space.SPF_FireFightAgent = 'Вода (water)' THEN 'water'
--	WHEN dbo.i_Space.SPF_FireFightAgent = 'Газ (gas)' THEN 'gas'
--	WHEN dbo.i_Space.SPF_FireFightAgent = 'Пена (foam)' THEN 'foam'
--	WHEN dbo.i_Space.SPF_FireFightAgent = 'отсутствует' THEN 'no'
--	ELSE dbo.i_Space.SPF_FireFightAgent
--END AS [~Fire-fighting agent],

CASE 
	WHEN Doc2.autp_type = 'Вода (water)' THEN 'water'
	WHEN Doc2.autp_type = 'Газ (gas)' THEN 'gas'
	WHEN Doc2.autp_type = 'Пена (foam)' THEN 'foam'
	WHEN Doc2.autp_type = 'отсутствует' THEN 'N/A'
	ELSE Doc2.autp_type
END AS [~Type of fire extinguishing agent in automatic fire extinguishing system],

--CASE 
--	WHEN dbo.i_Space.ProtectionLevel = 'отсутствует' THEN '1'
--	ELSE dbo.i_Space.ProtectionLevel
--END AS [~Protection level],

--CASE 
--	WHEN Doc2.def_lvl_rack = 'отсутствует' THEN 'N/A'
--	ELSE Doc2.def_lvl_rack
--END AS [~Protection level],

'Из AECOsim -->' AS '_AECOsim',

-- dbo.i_Space.SPF_FireClassRating AS [~Fire resistance rating, EI (REI, EI-M etc) for walls/fire compartment filling],

--CASE 
--	WHEN dbo.i_Space.SPF_FireClassRating = '60' THEN '60/60'
--	WHEN dbo.i_Space.SPF_FireClassRating = '90' THEN '60/90'
--	WHEN dbo.i_Space.SPF_FireClassRating = '120' THEN '60/180'
--	ELSE ''
--	END AS [~Fire rating FC:penetrations],

--'60/' + dbo.i_Space.SPF_FireClassRating AS [~Fire rating FC:penetrations], 

--CASE 
--	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN 'N/A'
--	ELSE 'REI-M120'
--END AS [~Fire resistance rating for walls of safety division], 
--Переделано по заданию Беляева. Атрибут теперь забирается из DOC2 (15.04.2021)

--CASE 
--	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN 'N/A'
--	ELSE '180/180'
--END AS [~Fire rating SD:penetrations],

'Из Doc2 -->' AS 'Doc2_',

Doc2.fire_res_lmt AS '~Fire resistance rating for walls of safety division', 
-- Атрибут забирается из DOC2 по просьбе Беляева (15.04.2021)

Doc2.fire_calc AS '~Full fire load in the room',
--Doc2.fire_udeln_calc AS '~Specific area fire load in the room, MJ/m2',

CASE 
	WHEN Doc2.soue_type = 'комбинированный (combine)' THEN 'combine'
	WHEN Doc2.soue_type = 'звук (sound)' THEN 'sound'
	WHEN Doc2.soue_type = 'звук (sound) ' THEN 'sound'
	WHEN Doc2.soue_type = 'отсутствует' THEN 'no'
	WHEN Doc2.soue_type = 'отсутсвует' THEN 'no'
	WHEN Doc2.soue_type = 'звук (sound); свет (light)' THEN 'sound, light'
	WHEN Doc2.soue_type = 'комбинированный (combine); отсутствует' THEN 'combine'
	WHEN Doc2.soue_type = 'комбинированный' THEN 'combine'
	ELSE Doc2.soue_type 
--END AS '~Type of annuncator (notify)',
END AS '~Annunciator type of alarm and evacuation control system',

CASE 
	WHEN Doc2.aps_type = 'отсутсвует' THEN 'no'
	WHEN Doc2.aps_type = 'отсутствует ()' THEN 'no'
	WHEN Doc2.aps_type = 'отсутствует' THEN 'no'
	WHEN Doc2.aps_type = 'комбинированный (combine)' THEN 'combine'
	WHEN Doc2.aps_type = 'комбинированный ( combine)' THEN 'combine'
	WHEN Doc2.aps_type = 'Дым (smoke); Тепло (warm)' THEN 'smoke, warm'
	WHEN Doc2.aps_type = 'Дым (smoke)' THEN 'smoke'
	WHEN Doc2.aps_type = 'Тепло (warm)' THEN 'warm'
	WHEN Doc2.aps_type = 'Дым (smoke); Пламя (flame)' THEN 'smoke, flame'
	WHEN Doc2.aps_type = 'Пламя (flame)' THEN 'flame'
	ELSE Doc2.aps_type
END AS [~Type of AFDS detector],

CASE 
	WHEN Doc2.pdz_avl= 'нет (no)' THEN 'no'
	WHEN Doc2.pdz_avl = 'да (yes)' THEN 'yes'
	WHEN Doc2.pdz_avl is NULL THEN ' '
	ELSE Doc2.pdz_avl 
--END AS [~Availability of fire ventilation system],
END AS [~Availability of smoke protection system],

CASE 
	WHEN Doc2.pdz_type = 'отсутствует' THEN 'N/A'
	WHEN Doc2.pdz_type = 'вытяжка (Smoke and heat remove)' THEN 'smoke and heat remove'
	WHEN Doc2.pdz_type = 'вытяжка (Smoke and heat remove); отсутствует' THEN 'smoke and heat remove'
	WHEN Doc2.pdz_type = 'подпор (air pressure)' THEN 'air pressure'
	WHEN Doc2.pdz_type = 'вытяжка (Smoke and heat remove); подпор (air pressure)' THEN 'smoke and heat remove, air pressure'
	ELSE Doc2.pdz_type
--END AS [~Type of fire ventilation system],
END AS [~Type of smoke protection system],

CASE 
	WHEN Doc2.fireext_avl= 'нет (no)' THEN 'no'
	WHEN Doc2.fireext_avl = 'да (yes)' THEN 'yes'
	ELSE Doc2.fireext_avl 
END AS [~Availability of fire extinguishers],

Doc2.fireext_qnt AS '~Number of fire extinguishers',

CASE 
	WHEN Doc2.fireext_otv_type = 'отсутствует' THEN 'N/A'
	WHEN Doc2.fireext_otv_type  = 'Газ (spray)' THEN 'spray'
	WHEN Doc2.fireext_otv_type  = 'Порошок (dry powder)' THEN 'dry powder'
	WHEN Doc2.fireext_otv_type  = 'Вода (water)' THEN 'water'
	WHEN Doc2.fireext_otv_type  = 'Пена (foam)' THEN 'foam'
	WHEN Doc2.fireext_otv_type  = 'Газ (spray); Порошок (dry powder)' THEN 'spray, dry powder'
	ELSE Doc2.fireext_otv_type 
END AS [~Type of extinguishing agent],

Doc2.fireext_otv_mass AS '~Weight of extinguishing agent',

CASE 
	WHEN Doc2.dkd= 'нет (no)' THEN 'no'
	WHEN Doc2.dkd = 'да (yes)' THEN 'yes'
	ELSE Doc2.dkd 
END AS [~Availability of sensor for continuous monitoring of doors and hatches position in safety division],

--CASE 
--	WHEN Doc2.fire_class= 'Класс E' THEN 'Class E'
--	WHEN Doc2.fire_class = 'Класс A' THEN 'Class A'
--	WHEN Doc2.fire_class = 'Класс B' THEN 'Class B'
--	WHEN Doc2.fire_class = 'Класс F' THEN 'Class F'
--	WHEN Doc2.fire_class = 'Отсутствует' THEN 'N/A'
--	ELSE Doc2.fire_class 
--END AS '~Fire class',

DOC2.ATEX_zone AS '~Explosion hazard zone',

-- Doc2.Internal_flooding_zone AS '~Internal flooding zone',

Doc2.nois AS '~Noise level',

Doc2.Noise_level_zone AS '~Noise level zone',

 -- Floor Area
dbo.getTrueArea2(dbo.elements.simID, 0, 2)  AS '~Floor area',

 -- Ceiling Area
dbo.getTrueArea2(dbo.elements.simID, 0, 2)  AS '~Ceiling area',

-- Vertical Area
dbo.getTrueVertArea(dbo.elements.simID, 0, 2) as '~Wall area',

dbo.getTrueVolume(dbo.elements.simID, 0, 2) AS '~Volume',

--Doc2.Internal_flooding_zone AS '~Internal flooding zone',
--Doc2.Noise_level_zone AS '~Noise level zone',
--dbo.getTrueVolume(dbo.elements.simID, 0, 3) AS '~Volume, m3',
CASE 
	WHEN dbo.i_Space.TopCoatLayer = 'FL1 Epoxy paint' THEN 'Epoxy paint'
	WHEN dbo.i_Space.TopCoatLayer = 'FL2 Decontaminable self-leveling floors' THEN 'Decontaminable self-leveling floors'
	WHEN dbo.i_Space.TopCoatLayer = 'FL3 Self-leveling floors' THEN 'Self-leveling floors'
	WHEN dbo.i_Space.TopCoatLayer = 'FL4 Concrete with grinding' THEN 'Concrete with grinding'
	WHEN dbo.i_Space.TopCoatLayer = 'FL5 Lining with stainless steel' THEN 'Lining with stainless steel'
	WHEN dbo.i_Space.TopCoatLayer = 'FL6 Ceramic tiles' THEN 'Ceramic tiles'
	WHEN dbo.i_Space.TopCoatLayer = 'FL7 Polyvinylchloride linoleum with thermal insulation base' THEN 'Polyvinylchloride linoleum with thermal insulation base'
	WHEN dbo.i_Space.TopCoatLayer = 'FL8 Ceramic granite' THEN 'Ceramic granite'
	ELSE dbo.i_Space.TopCoatLayer
END AS '~Interior floor finishing',

CASE 
	WHEN dbo.i_Space.CeilInteriorFinish = 'C1 Epoxy paint' THEN 'Epoxy paint'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C2 Decontaminable epoxy paint' THEN 'Decontaminable epoxy paint'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C3 Water-based paint' THEN 'Water-based paint'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C4 Acrylic paint' THEN 'Acrylic paint'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C5 Lining with stainless steel' THEN 'Lining with stainless steel'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C6 Suspended ceiling' THEN 'Suspended ceiling'
	ELSE dbo.i_Space.CeilInteriorFinish
END AS '~Interior ceiling finishing',


CASE 
	WHEN dbo.i_Space.WallInteriorFinish = 'W1 Epoxy paint' THEN 'Epoxy paint'
	WHEN dbo.i_Space.WallInteriorFinish = 'W2 Decontaminable epoxy paint' THEN 'Decontaminable epoxy paint'
	WHEN dbo.i_Space.WallInteriorFinish = 'W3 Water-based paint' THEN 'Water-based paint'
	WHEN dbo.i_Space.WallInteriorFinish = 'W4 Acrylic paint' THEN 'Acrylic paint'
	WHEN dbo.i_Space.WallInteriorFinish = 'W5 Lining with stainless steel' THEN 'Lining with stainless steel'
	WHEN dbo.i_Space.WallInteriorFinish = 'W6 Ceramic tiles' THEN 'Ceramic tiles'
	WHEN dbo.i_Space.WallInteriorFinish = 'W6,W3 Ceramic tiles and Water-based paint' THEN 'Ceramic tiles and Water-based paint'
	WHEN dbo.i_Space.WallInteriorFinish = 'W5,W1 Lining with stainless steel and Epoxy paint' THEN 'Lining with stainless steel and Epoxy paint'
	ELSE dbo.i_Space.WallInteriorFinish
END AS '~Interior wall finishing',

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],

-- временная вставка 
--CASE 
--	WHEN dd.bldName = '10UKD' THEN 'FH1_10UKD_Rooms.dgn'
--	ELSE doc.o_filename
--END AS [o_filename]
-- вместо
doc.o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_Space 
ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd 
ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc 
ON dd.o_docguid = doc.o_docguid
LEFT JOIN [10.36.69.19].[HHKV_1].[dbo].[room_charact] AS Doc2 
-- ON i_Space.number = Doc2.room - Покуль 29.03.2021: заменила эту строчку на следующую, чтобы помещения не дублировались и синхронизировались по simID.
ON dbo.elements.simID = Doc2.simid


-- забор кодов из таблицы отсеков - Вибе Л. 11.03.2021
LEFT OUTER JOIN dbo.o_FireComp fc ON fc.fcID = dbo.i_Space.fcID

-- where number like '10ukc00r111' - Запрос для проверки







GO
