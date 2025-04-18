SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_NW_Door_ALL_Attributes]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
dbo.i_DoorProperties.KKS AS '~KKS code',
'Door' AS '~Name',
'' AS '~Type of structure',
'' AS '~Status',
'' AS '~Safety class',
'' AS '~Functional safety class',
'' AS '~Structural safety class',
'' AS '~Seismic category',
'' AS '~Quality assurance category',
 round(dbo.i_Dimensions.width * 1e-2, 0,2) AS '~Width', 
 round(dbo.i_Dimensions.height * 1e-2, 0,2) AS '~Height',
'' AS '~Lifetime, not less than',
'' AS '~Mean time between failures (MTBF), not less than',
'' AS '~Operating efficiency factor, not less than',
'' AS '~Availability factor, not less than',
'' AS '~Specified period of storage prior to putting into operation',
'' AS '~Weight',
'' AS '~Note',

CASE 
	WHEN dbo.i_DoorProperties.FireResistance IS NULL THEN '-'
	WHEN dbo.i_DoorProperties.FireResistance = 'не требуется' THEN 'N/A'
	ELSE dbo.i_DoorProperties.FireResistance
END AS '~Fire resistance',
--dbo.i_DoorProperties.OpeningCode AS '~KKS Code',
'' AS '~Maximum mounting assembly mass, not more than',
 round(dbo.i_Dimensions.width * 1e-2, 0,2) AS '~Structural width', 
 round(dbo.i_Dimensions.height * 1e-2, 0,2) AS '~Structural height',
 '' AS '~Door leaf',
 '' AS '~Door swing',
 '' AS '~Door type',
 '' AS '~Material',
 '' AS '~Magnitude of the shock wave',
 '' AS '~Radiation protection',
 '' AS '~Chemical protection',
 '' AS '~Smoke-gastightness',
 '' AS '~Waterproof',
 '' AS '~Internal/External',
 '' AS '~Lock type',
 '' AS '~Sensor of alarm system',
 '' AS '~Lock-out sensor',
 '' AS '~Position sensor',
 '' AS '~Panic system',
 '' AS '~Door closer',
 '' AS '~Limiter',
 '' AS '~Thermal insulation',
 '' AS '~Description (RUS)',
 '' AS '~Safety division',
 '' AS '~Climatic conditions for stationary use by EN 60721',
 '' AS '~Climatic conditions for storage by EN 60721',
 '' AS '~Maintenance intervals',
 '' AS '~Distance from noise source to measuring point',
 '' AS '~Task category',
 '' AS '~Safety functions',
 '' AS '~The duration of the equipment (process)',
 '' AS '~Main technical characteristics' ,







dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID

INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID















GO
