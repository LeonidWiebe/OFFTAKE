SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_NW_FH1_Structure_Properties]
AS
SELECT 
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	
dbo.i_StructProp.StructCode AS '~Name',


dbo.i_StructProp.FC AS '~Fire resistance',

dbo.i_StructProp.DWL AS '~Design working life',
dbo.i_StructProp.BCC AS '~Building consequences class',
dbo.i_StructProp.SRC AS '~Reliability class',
dbo.i_StructProp.NSC AS '~Safety class',
dbo.i_StructProp.SC AS '~Seismic category',
case 
	when dbo.i_StructProp.Firewall IS NULL THEN 'No'
	Else dbo.i_StructProp.Firewall
end AS '~Firewall',


dbo.getTypeElement(dbo.elements.cattype, 
dbo.elements.partdef, 
dbo.elements.catitem) AS [Object],
doc.o_filename

FROM         dbo.elements 
RIGHT OUTER JOIN   dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID
RIGHT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
RIGHT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid

























GO
