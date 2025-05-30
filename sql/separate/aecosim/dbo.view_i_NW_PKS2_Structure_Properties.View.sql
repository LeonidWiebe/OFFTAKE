SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_NW_PKS2_Structure_Properties]
AS
SELECT 
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	


----Подправел ошибку архитеторов 13.04.2018
--CASE 
--WHEN dbo.i_StructProp.FC = 'R120' Then 'R180'
--Else dbo.i_StructProp.FC
--END AS '~Fire Class',
dbo.i_StructProp.FC AS '~Fire resistance rating',

--dbo.i_StructProp.DWL AS '~Design Working Life',
--dbo.i_StructProp.BCC AS '~Building Consequences Class',
--dbo.i_StructProp.SRC AS '~Reliability Class',
dbo.i_StructProp.NSC AS '~Safety class',
dbo.i_StructProp.SC AS '~Seismic category',

dbo.getTypeElement(dbo.elements.cattype, 
dbo.elements.partdef, 
dbo.elements.catitem) AS [Object],
doc.o_filename

FROM         dbo.elements 
RIGHT OUTER JOIN   dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID
RIGHT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
RIGHT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid

























GO
