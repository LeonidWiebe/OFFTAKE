SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_clist_callback_part]
AS
SELECT     dbo.part.partName, dbo.position.srtmID, dbo.position.matID, dbo.r_catlist_part.catlistID, dbo.r_catlist_part.relID, dbo.part.partdefID, 
                      dbo.r_catlist_part.objID
FROM         dbo.r_catlist_part INNER JOIN
                      dbo.part ON dbo.r_catlist_part.partID = dbo.part.partID LEFT OUTER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID
WHERE     (dbo.r_catlist_part.objID = 1)

GO
