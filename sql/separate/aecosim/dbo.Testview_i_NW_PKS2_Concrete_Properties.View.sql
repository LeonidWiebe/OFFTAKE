SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[Testview_i_NW_PKS2_Concrete_Properties]
AS
SELECT  
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	
dbo.getConcrSecName (dbo.i_Wall.Width, dbo.i_Slab.Thickness, dbo.i_StructuralFramingCommon.sectionname)	AS '~Element Section',
	
dbo.i_ConcreteProperties.C AS '~Material',
dbo.i_ConcreteProperties.G AS '~Volume Weight',
--dbo.i_ConcreteProperties.D AS '~Density',
dbo.getTrueVolume(dbo.elements.simID, 0, 3) AS '~Volume, м3',

dbo.getConcrSecName (dbo.i_Wall.Width, dbo.i_Slab.Thickness, '') AS 'Section',


dbo.getArmTon(SUBSTRING(dd.bldName, 3, 3)
			,dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem)
			,dbo.getConcrType (dbo.i_Wall.Type, dbo.i_Slab.Type)
			,dbo.elements.isexternal
			,dbo.getTrueVolume(dbo.elements.simID, 0, 3)) 
AS 'Ton',
CASE 
When dbo.getTrueVolume(dbo.elements.simID, 0, 3) >0 Then
(dbo.getArmTon(SUBSTRING(dd.bldName, 3, 3)
			,dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem)
			,dbo.getConcrType (dbo.i_Wall.Type, dbo.i_Slab.Type)
			,dbo.elements.isexternal
			,dbo.getTrueVolume(dbo.elements.simID, 0, 3)) )/dbo.getTrueVolume(dbo.elements.simID, 0, 3)
	Else 0
END AS 'Proc',

SUBSTRING(dd.bldName, 3, 3) AS Building,

CASE
 When dbo.i_Slab.Type is null Then dbo.i_wall.Type
 ELSE dbo.i_Slab.Type
 END AS 'Type',

dbo.elements.isexternal AS 'isexternal',

--dbo.i_ConcreteProperties.MM AS '~Manufacturing Metod',
--dbo.i_ConcreteProperties.EC AS '~Execution Class',
dbo.i_ConcreteProperties.RC AS '~Reinforcement Class',
--dbo.i_ConcreteProperties.WT AS '~Is Watertight',


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_ConcreteProperties ON dbo.elements.simID = dbo.i_ConcreteProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
LEFT JOIN dbo.i_StructuralFramingCommon ON dbo.elements.simID = dbo.i_StructuralFramingCommon.simID
LEFT JOIN   dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
LEFT OUTER JOIN dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID
WHERE dd.project_name = 'Paks-2' 






GO
