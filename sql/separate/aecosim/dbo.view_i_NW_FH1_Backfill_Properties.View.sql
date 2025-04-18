SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_NW_FH1_Backfill_Properties]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
dbo.i_BackfillProperties.BackfillMaterial AS '~Material',
dbo.i_BackfillProperties.BackfillVolumeWeight AS '~Volume weight',
dbo.i_BackfillProperties.BackfillFractionOfAggregate AS '~Fraction of aggregate',
dbo.i_BackfillProperties.DesignWorkingLife AS '~Design working life',
dbo.i_BackfillProperties.BuildingConsequencesClass AS '~Building consequences class',
dbo.i_BackfillProperties.ReliabilityClass AS '~Reliability class',
dbo.i_BackfillProperties.SafetyClass AS '~Safety class',
dbo.i_BackfillProperties.SeismicClass AS '~Seismic class',

doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_BackfillProperties ON dbo.elements.simID = dbo.i_BackfillProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
















GO
