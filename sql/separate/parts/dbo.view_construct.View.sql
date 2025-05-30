SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_construct]
AS
SELECT     dbo.ms_construct.constructID AS mslink, dbo.posdef.posdefName, dbo.ms_construct.constructName, dbo.ms_construct.constructLength, 
                      dbo.standardtype.stdTypeName, dbo.standard.stdNumber, dbo.standard.stdName
FROM         dbo.ms_construct INNER JOIN
                      dbo.standard ON dbo.ms_construct.stdID = dbo.standard.stdID INNER JOIN
                      dbo.standardtype ON dbo.standard.stdTypeID = dbo.standardtype.stdTypeID LEFT OUTER JOIN
                      dbo.posdef ON dbo.ms_construct.posdefID = dbo.posdef.posdefID
GO
