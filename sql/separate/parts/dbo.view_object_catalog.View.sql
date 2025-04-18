SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_object_catalog]
AS
SELECT        dbo.r_object_catalog.ID, dbo.i_catalog.catName, dbo.r_object_catalog.objectID, dbo.i_catalog.catID, dbo.i_catalog.deleted, dbo.i_catalog.catTypeID, dbo.i_catalog.forTesting, dbo.i_catalog.catUnif, dbo.i_catalog.catOpen, 
                         dbo.i_catalog.catlistID, dbo.r_object_catalog.objID, dbo.object.objName, dbo.i_catalog.dsDrawingsID, dbo.i_catalog.dsPartListID, dbo.i_catalog.catStatus, dbo.i_catalog.dsLev, dbo.i_catalog.dsNum, dbo.docset.dsNumber, 
                         dbo.i_catalog.catdefID, dbo.i_catalog.specID
FROM            dbo.r_object_catalog INNER JOIN
                         dbo.i_catalog ON dbo.r_object_catalog.catalogID = dbo.i_catalog.catID INNER JOIN
                         dbo.object ON dbo.r_object_catalog.objID = dbo.object.objID LEFT OUTER JOIN
                         dbo.docset ON dbo.i_catalog.dsDrawingsID = dbo.docset.dsID
GO
