SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_FH1_Room_in_one_table]
AS
SELECT   
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
dbo.i_Space.number AS 'Oder',	
dbo.i_Space.number AS '~KKS code',
dbo.i_Space.label2 AS '~Room name EN',
dbo.i_Space.label AS '~Room name RU',

CASE
 WHEN dbo.i_Space.NumFireComp = 'Отсутствует/missing' Then 'Missing'
 ELSE dbo.i_Space.NumFireComp
END AS '~KKS of Fire Compartment',

CASE 
	WHEN dbo.i_Space.AccessArea = 'CA' THEN 'Controlled area'
	WHEN dbo.i_Space.AccessArea = 'SA' THEN 'Supervised area'
	WHEN dbo.i_Space.AccessArea = 'CAA' THEN 'Controlled area'
	ELSE dbo.i_Space.AccessArea
END AS '~Acess Area',


Doc2.ra_avl AS '~Radiation zone',

Doc2.ra_avi_ppr AS '~Radiation zone/PM',



--CASE 
--	WHEN dbo.i_Space.SPF_FireLoadGroup in ('&lt;600','&lt; 600','<600') THEN '< 600'
--	WHEN dbo.i_Space.SPF_FireLoadGroup in ('600 - 1200',' 600 - 1200')THEN '600-1200'
--	WHEN dbo.i_Space.SPF_FireLoadGroup In ('&gt;1200','&gt; 1200') THEN '> 1200'
--	WHEN dbo.i_Space.SPF_FireLoadGroup = 'от 600 до 1200' THEN '?!!'
--	WHEN dbo.i_Space.SPF_FireLoadGroup = '' THEN 'Нет данных'
--	ELSE dbo.i_Space.SPF_FireLoadGroup
--END AS '~Fire load group',
dbo.getFireLoadGroup(dbo.i_Space.SPF_FireLoadGroup) as [~Fire load group],


dbo.i_Space.SPF_Speciality AS '~Specialty',
dbo.i_Space.SafetyCanal AS '~Safety division',
dbo.i_Space.SPF_FireHazardClass AS '~Fire hazard class',




CASE 
	WHEN Doc2.aps_avl = 'да (yes)' THEN 'yes'
	WHEN Doc2.aps_avl = 'нет (no)' THEN 'no'
	ELSE Doc2.aps_avl
END AS [~Availability of automatic fire detection system],


CASE 
	WHEN Doc2.soue_avl = 'нет (no)' THEN 'no'
	WHEN Doc2.soue_avl = 'да (yes)' THEN 'yes'
	ELSE Doc2.soue_avl
END AS [~Availability of alarm and evacuation control system],

CASE 
	WHEN Doc2.autp_avl = 'нет (no)' THEN 'no'
	WHEN Doc2.autp_avl = 'да (yes)' THEN 'yes'
	ELSE Doc2.autp_avl
END AS [~Availability of automatic fire-fighting unit],



CASE 
	WHEN Doc2.autp_type = 'Вода (water)' THEN 'water'
	WHEN Doc2.autp_type = 'Газ (gas)' THEN 'gas'
	WHEN Doc2.autp_type = 'Пена (foam)' THEN 'foam'
	WHEN Doc2.autp_type = 'отсутствует' THEN 'N/A'
	ELSE Doc2.autp_type
END AS [~Type of fire extinguishing agent in automatic fire-fighting unit],



CASE 
	WHEN Doc2.def_lvl_rack = 'отсутствует' THEN 'N/A'
	ELSE Doc2.def_lvl_rack
END AS [~Protection level],


CASE 
	WHEN dbo.i_Space.SPF_FireClassRating = '60' THEN '60'
	WHEN dbo.i_Space.SPF_FireClassRating = '90' THEN '90'
	WHEN dbo.i_Space.SPF_FireClassRating = '120' THEN '180'
	ELSE ''
END AS [~Fire rating FC:wall, slab],

CASE 
	WHEN dbo.i_Space.SPF_FireClassRating = '60' THEN '60/60'
	WHEN dbo.i_Space.SPF_FireClassRating = '90' THEN '60/90'
	WHEN dbo.i_Space.SPF_FireClassRating = '120' THEN '60/180'
	ELSE ''
	END AS [~Fire rating FC:penetrations],



CASE 
	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN 'N/A'
	ELSE '180'
END AS [~Fire rating SD:wall, slab],

CASE 
	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN 'N/A'
	ELSE '180/180'
END AS [~Fire rating SD:penetrations],


Doc2.fire_calc AS '~Full fire load in the room, MJ',
Doc2.fire_udeln_calc AS '~Specific area fire load in the room, MJ/m2',

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

END AS [~Availability of smoke protecticon system],

CASE 
	WHEN Doc2.pdz_type = 'отсутствует' THEN 'N/A'
	WHEN Doc2.pdz_type = 'вытяжка (Smoke and heat remove)' THEN 'smoke and heat remove'
	WHEN Doc2.pdz_type = 'вытяжка (Smoke and heat remove); отсутствует' THEN 'smoke and heat remove'
	WHEN Doc2.pdz_type = 'подпор (air pressure)' THEN 'air pressure'
	WHEN Doc2.pdz_type = 'вытяжка (Smoke and heat remove); подпор (air pressure)' THEN 'smoke and heat remove, air pressure'
	ELSE Doc2.pdz_type

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
END AS [~Type of extinguishing substance],

Doc2.fireext_otv_mass AS '~Weight of extinguishing substance, kg',

CASE 
	WHEN Doc2.dkd= 'нет (no)' THEN 'no'
	WHEN Doc2.dkd = 'да (yes)' THEN 'yes'
	ELSE Doc2.dkd 
END AS [~Presence of the gauge of constant control of position of doors and hatches in a safety compartment],

 


CASE 
	WHEN Doc2.fire_class= 'Класс E' THEN 'Class E'
	WHEN Doc2.fire_class = 'Класс A' THEN 'Class A'
	WHEN Doc2.fire_class = 'Класс B' THEN 'Class B'
	WHEN Doc2.fire_class = 'Класс F' THEN 'Class F'
	WHEN Doc2.fire_class = 'Отсутствует' THEN 'N/A'
	ELSE Doc2.fire_class 
END AS '~Fire class',


DOC2.ATEX_zone AS '~ATEX zone',

Doc2.Internal_flooding_zone AS '~Internal flooding zone',

Doc2.Noise_level_zone AS '~Noise level zone',

dbo.i_Space.WallInteriorFinish AS 'Walls',

dbo.i_Space.TopCoatLayer AS 'Floor',

dbo.i_Space.CeilInteriorFinish AS 'Ceiling',

--dbo.getTrueSpaceHeight(dbo.elements.simID, 0, 2) AS [Room Height],
dbo.getZero(dbo.getTrueSpaceHeight(dbo.elements.simID, 0, 2)) AS [Room Height],
--dbo.getZero(round((dbo.elements.pMaxZ - dbo.elements.pMinZ)* 1e-3, 1)) AS [Room Height],

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename,
dd.project_name,
dd.deleted




FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
LEFT JOIN [10.36.69.19].[HHKV_1].[dbo].[room_charact] AS Doc2 ON i_Space.number = Doc2.room





















GO
