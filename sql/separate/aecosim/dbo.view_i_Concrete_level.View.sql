SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[view_i_Concrete_level]
AS

SELECT     
dbo.elements.simID, 
dbo.elements.pwdocID, 
--LEFT(dbo.[i_StructProp].StructCode, 7) AS codelevel
LEFT(dbo.getConcLevel(doc.dmsstatus, PWRKdoc.dmsstatus, dbo.i_StructProp.StructCode), 7) AS codelevel

FROM         dbo.elements

LEFT OUTER JOIN dbo.i_StructProp 		ON dbo.[i_StructProp].simID = dbo.elements.simID
LEFT OUTER JOIN dbo.i_ConcreteProperties ON dbo.i_ConcreteProperties.simID = dbo.elements.simID
LEFT OUTER JOIN dbo.i_ConcreteExposure	ON dbo.i_ConcreteExposure.simID = dbo.elements.simID
LEFT OUTER JOIN dbo.i_Stair_Common	ON dbo.i_Stair_Common.simID = dbo.elements.simID


LEFT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
LEFT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[aep_docdata] AS doc ON dd.o_docguid = doc.docguid

LEFT OUTER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS PWRKdd ON dbo.elements.pwdocID = PWRKdd.id
LEFT OUTER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[aep_docdata] AS PWRKdoc ON PWRKdd.o_docguid = PWRKdoc.docguid

--WHERE LEN(isnull(dbo.[i_StructProp].StructCode,''))>0
WHERE LEN(isnull(dbo.getConcLevel(doc.dmsstatus, PWRKdoc.dmsstatus, dbo.i_StructProp.StructCode),''))>0

AND dbo.elements.cattype like '%concrete%' 
or dbo.i_Stair_Common.FlightPartDef like '%concrete%'









GO
