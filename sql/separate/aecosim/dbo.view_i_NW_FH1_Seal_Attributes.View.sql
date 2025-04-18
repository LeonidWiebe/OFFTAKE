SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_NW_FH1_Seal_Attributes]
AS
SELECT  
	e.elemID AS elemID,     
	e.simID AS simID, 
	e.pwdocID AS pwdocID, 
	e.elemguid AS elemguid, 
	e.dtID AS dtID, 

CASE
	WHEN e.cattype = 'EmbeddedPart' THEN  p.PartCode
	WHEN e.cattype = 'Opening' THEN  o.PartCode
END  as [Name],
	
dbo.i_SealAttributes.WaterTight AS '~Water tight',
dbo.i_SealAttributes.AirTight AS '~Air tight',
dbo.i_SealAttributes.RadiationProtect AS '~Radiation protect',
dbo.i_SealAttributes.SealFireResistance AS '~Fire resistance',



dbo.getTypeElement(e.cattype, e.partdef, e.catitem) AS [Object],
doc.o_filename AS o_filename


FROM  dbo.elements e
LEFT JOIN   dbo.i_EmbPart p ON e.simID = p.simID
LEFT JOIN   dbo.i_Opening o ON e.simID = o.simID
INNER JOIN   dbo.i_SealAttributes ON e.simID = dbo.i_SealAttributes.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON e.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid























GO
