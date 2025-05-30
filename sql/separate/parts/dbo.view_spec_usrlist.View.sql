SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_usrlist]
AS
SELECT     TOP (100) PERCENT dbo.usrlist.usrID, dbo.usrlist.partQty, SUM(dbo.position.posCommonMass) AS mass, dbo.usrlist.partSortID, dbo.usrlist.partID, 
                      dbo.part.partdefID
FROM         dbo.usrlist INNER JOIN
                      dbo.part ON dbo.usrlist.partID = dbo.part.partID INNER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID
GROUP BY dbo.usrlist.partQty, dbo.usrlist.usrID, dbo.usrlist.partSortID, dbo.usrlist.partID, dbo.part.partdefID
GO
