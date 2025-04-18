SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[view_i_NW_SH12_Room_Attributes]
AS
SELECT   
 
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 

dbo.i_Space.number AS '~KKS код',
dbo.i_Space.label  AS '~Наименование',
dbo.i_Space.AccessArea  AS '~Зона доступа',
dbo.i_Space.FireClass  AS '~Кат. произв. по взрывной, взр/пожар и пожарн. опасности',
dbo.i_Space.SPAS_03 AS '~Категория помещения по СП АС-03',

dbo.getTrim(dbo.getTrueArea2(dbo.elements.simID, 0, 1))  AS '~Площадь помещения, м2',
dbo.getTrueVolume(dbo.elements.simID, 0, 1) AS '~Объем помещения, м3', 


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid








	









GO
