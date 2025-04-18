SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[view_i_NW_FH1_Crushed_Stone_Attributes]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],


dbo.i_CrushedStoneProp.FractionOfAggregate  AS '~Nominal Diameter',
dbo.i_CrushedStoneProp.DesignWorkingLife  AS '~Design working life',
dbo.i_CrushedStoneProp.SafetyClass  AS '~Safety Class',
dbo.i_CrushedStoneProp.SeismicCategory  AS '~Seismic Category',

doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_CrushedStoneProp ON dbo.elements.simID = dbo.i_CrushedStoneProp.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid













GO
