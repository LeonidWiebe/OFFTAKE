SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_FH1_Concrete_Walls]
AS
SELECT     
	
	dd.project_name,
	dd.bldname as [bldname],
	dbo.elements.cattype,
	dbo.i_StructProp.StructCode	AS [Civil Code],
	dbo.i_Wall.Width / 100 as Width,
	dbo.i_StructProp.FC	AS [Fire Res],
	dbo.i_Wall.Width * dbo.i_Wall.LengthCenter / 10000000000 as WallArea
	
FROM         dbo.elements 



LEFT OUTER JOIN dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID -- INNER JOIN
LEFT OUTER JOIN dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id

where project_name='Hanhikivi' and cattype = 'ConcreteWalls'


--order by bldname,[Civil Code]













GO
