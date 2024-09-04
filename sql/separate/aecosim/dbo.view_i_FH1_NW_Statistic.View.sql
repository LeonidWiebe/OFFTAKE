SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

























CREATE VIEW [dbo].[view_i_FH1_NW_Statistic]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],

dd.[bldName],
dd.[project_name]


--select [project_name], bldname, [object], COUNT([Object]) as cnt from [aecosim].[dbo].[view_i_FH1_NW_Statistic] where [project_name]='Hanhikivi'  group by bldname,[object],[project_name] order by [project_name], bldname





FROM         dbo.elements 

INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid























GO
