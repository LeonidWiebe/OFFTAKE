SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO















CREATE VIEW [dbo].[view_i_NW_LYG_Embedded_part_Attributes]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
dbo.i_EmbPart.PartCode AS '~Name',
--dbo.i_EmbPart.LoadBearing AS '~Load bearing',
--dbo.i_EmbPart.Material AS '~Material',
dbo.i_EmbPart.CatalogName AS '~Catalog name',
--dbo.i_EmbPart.NuclearSafetyClass AS '~Safety class',
--dbo.i_EmbPart.SeismicClass AS '~Seismic category',
--dbo.i_EmbPart.ExecutionClass AS '~Execution class',
--dbo.i_EmbPart.ServiceCategory AS '~Service Category',
--dbo.i_EmbPart.ReliabilityClass AS '~Reliability class',
--dbo.i_EmbPart.ConsequencesClass AS '~Consequences class',
--dbo.i_EmbPart.DesignWorkingLife AS '~Design working life',
--dbo.i_EmbPart.AtmCorrCategory AS '~Atmospheric-corrosivity category',
--dbo.i_EmbPart.CoatingSystem AS '~Coating system',
--dbo.i_EmbPart.DurabilityCoating AS '~Durability of coating',
--dbo.i_EmbPart.ProductionCategory AS '~Production Category',
--dbo.i_EmbPart.FireClass AS '~Fire resistance',

--dbo.i_EmbPart.Drawing AS '~Drawing',
--dbo.i_EmbPart.Supplier AS '~Supplier',
 


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_EmbPart ON dbo.elements.simID = dbo.i_EmbPart.simID
INNER JOIN [PWrk.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PWrk.SP.SPBAEP.RU].[pw_aep_con].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid























GO
