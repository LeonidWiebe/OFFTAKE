SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_NW_Civil_Components_local_nwdtree]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 


		
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [ObjectName],

[dbo].[getLevel](doc.dmsstatus) AS level1,

doc.dmsstatus AS filename1,

[dbo].[getKKS_tree](dbo.i_Space.number,
					dbo.i_DoorProperties.KKS,
					dbo.i_Opening.PartCode,					
					dbo.i_StructProp.StructCode,
					dbo.i_EmbPart.PartCode,
					dbo.i_WindowProperties.KKS,
					dbo.i_Well.Name, -- дописали Покуль и Григорьев 19.05.2022
					dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem),
					i_StrainDT.KKScode,i_StrainStress.KKScode,doc.dmsstatus,dbo.elements.catitem) AS '~KKS code'


FROM         dbo.elements

LEFT JOIN   dbo.i_StrainDT ON dbo.elements.simID = dbo.i_StrainDT.simID
LEFT JOIN   dbo.i_StrainStress ON dbo.elements.simID = dbo.i_StrainStress.simID
LEFT JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
LEFT JOIN  dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID
LEFT JOIN  dbo.i_Opening ON dbo.elements.simID = dbo.i_Opening.simID
LEFT JOIN  dbo.i_EmbPart ON dbo.elements.simID = dbo.i_EmbPart.simID
LEFT JOIN  dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID
LEFT JOIN  dbo.i_WindowProperties ON dbo.elements.simID = dbo.i_WindowProperties.simID
LEFT JOIN  dbo.i_Well ON dbo.elements.simID = dbo.i_Well.simID -- дописали Покуль и Григорьев 19.05.2022
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[aep_docdata] AS doc ON dd.o_docguid = doc.docguid

UNION 
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 


		
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [ObjectName],

[dbo].[getLevel](Cdoc.dmsstatus) AS level1,

Cdoc.dmsstatus AS filename1,

[dbo].[getKKS_tree](dbo.i_Space.number,
					dbo.i_DoorProperties.KKS,
					dbo.i_Opening.PartCode,					
					dbo.i_StructProp.StructCode,
					dbo.i_EmbPart.PartCode,
					dbo.i_WindowProperties.KKS,
					dbo.i_Well.Name, -- дописали Покуль и Григорьев 19.05.2022
					dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem),
					i_StrainDT.KKScode,i_StrainStress.KKScode,Cdoc.dmsstatus,dbo.elements.catitem) AS '~KKS code'


FROM         dbo.elements

LEFT JOIN   dbo.i_StrainDT ON dbo.elements.simID = dbo.i_StrainDT.simID
LEFT JOIN   dbo.i_StrainStress ON dbo.elements.simID = dbo.i_StrainStress.simID
LEFT JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
LEFT JOIN  dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID
LEFT JOIN  dbo.i_Opening ON dbo.elements.simID = dbo.i_Opening.simID
LEFT JOIN  dbo.i_EmbPart ON dbo.elements.simID = dbo.i_EmbPart.simID
LEFT JOIN  dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID
LEFT JOIN  dbo.i_WindowProperties ON dbo.elements.simID = dbo.i_WindowProperties.simID
LEFT JOIN  dbo.i_Well ON dbo.elements.simID = dbo.i_Well.simID -- дописали Покуль и Григорьев 19.05.2022
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS Cdd ON dbo.elements.pwdocID = Cdd.id
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[aep_docdata] AS Cdoc ON Cdd.o_docguid = Cdoc.docguid


GO
