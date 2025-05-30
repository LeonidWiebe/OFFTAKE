SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_xx]
AS
SELECT     TOP (100) PERCENT dbo.usrlist.usrID, dbo.partdef.partdefNameMulti, dbo.part.partName, dbo.part.partDescr, dbo.part.partSheet, 
                      dbo.part.partMainPosEP, dbo.usrlist.partQty, SUM(dbo.position.posCommonMass) AS mass, dbo.usrlist.partSortID, dbo.usrlist.partID, 
                      dbo.partdef.partdefID
FROM         dbo.usrlist INNER JOIN
                      dbo.part ON dbo.usrlist.partID = dbo.part.partID INNER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID INNER JOIN
                      dbo.sortament ON dbo.position.srtmID = dbo.sortament.srtmID LEFT OUTER JOIN
                      dbo.partdef ON dbo.part.partdefID = dbo.partdef.partdefID
GROUP BY dbo.part.partName, dbo.part.partDescr, dbo.part.partSheet, dbo.usrlist.partQty, dbo.usrlist.usrID, dbo.usrlist.partSortID, dbo.part.partMainPosEP, 
                      dbo.partdef.partdefNameMulti, dbo.usrlist.partID, dbo.partdef.partdefID
ORDER BY dbo.usrlist.partSortID
GO
