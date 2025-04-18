SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

















CREATE VIEW [dbo].[view_i_PKS2_Building_Level]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,

CASE
	WHEN LEFT(dbo.i_Space.number, 5) = '50UJB' THEN '50UJA'
	ELSE LEFT(dbo.i_Space.number, 5)
END AS [KKS здания],


LEFT(dbo.i_Space.number, 7) AS [KKS отметки],


dd.o_projectcode, 
dd.o_filename,
dd.o_original,
dd.deleted,
dd.project_name

   



FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
 JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] as dd ON dbo.elements.pwdocID = dd.id












GO
