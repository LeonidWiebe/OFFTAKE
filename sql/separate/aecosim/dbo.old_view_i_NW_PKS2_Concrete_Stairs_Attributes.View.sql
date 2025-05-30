SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


























CREATE VIEW [dbo].[old_view_i_NW_PKS2_Concrete_Stairs_Attributes]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 

'В Navis--->' AS 'Navis',	
'Concrete Stair' AS '~Name',
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Type],

dbo.getComposition((dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem)), dbo.i_ConcreteProperties.C, dbo.i_ConcreteProperties.G , dbo.i_ConcreteExposure.XC, dbo.i_ConcreteExposure.XD, dbo.i_ConcreteExposure.XS, dbo.i_ConcreteExposure.XF, dbo.i_ConcreteExposure.XA) AS '~Composition (Material)',
dbo.i_ConcreteProperties.RC AS '~Reinforcement Class',
dbo.i_StructProp.FC AS '~Fire Class',

'Из AECOsim--->' AS 'AECOsim',
dbo.i_ConcreteProperties.C AS 'Concrete',
dbo.i_ConcreteProperties.G AS 'Volume weight',
dbo.i_ConcreteExposure.XC AS 'Carbonation corrosion',
dbo.i_ConcreteExposure.XD AS 'Chlorides corrosion',
dbo.i_ConcreteExposure.XS AS 'Sea water corrosion',
dbo.i_ConcreteExposure.XF AS 'Freeze Thaw attack',
dbo.i_ConcreteExposure.XA AS 'Chemical attack',	


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_ConcreteExposure ON dbo.elements.simID = dbo.i_ConcreteExposure.simID
INNER JOIN   dbo.i_ConcreteProperties ON dbo.elements.simID = dbo.i_ConcreteProperties.simID
INNER JOIN   dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid






















GO
