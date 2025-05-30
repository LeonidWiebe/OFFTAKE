SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_NW_FH1_Electrical_Attributes]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.cattype, 
dbo.i_Electrical.WIDTH, 
dbo.i_Electrical.TRADE_WIDTH, 
dbo.i_Electrical.HEIGHT, 
dbo.i_Electrical.TRADE_HEIGHT, 
dbo.i_Electrical.LENGTH, 
dbo.i_Electrical.DESCRIPTION, 
dbo.i_Electrical.MANUFACTURER, 
dbo.i_Electrical.NuclearSafetyClass AS '~Safety class', 
dbo.i_Electrical.SeismicClass AS '~Seismic class', 
dbo.i_Electrical.Train AS '~Train number', 
dbo.i_Electrical.DesignWorkingLife,
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename

FROM         dbo.elements 

INNER JOIN dbo.i_Electrical ON dbo.elements.simID = dbo.i_Electrical.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid



GO
