SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_object_catalog_pw_LN2P]
AS

SELECT  

(select COUNT(*) from view_object_catalog voc1 where voc1.objID = 7 and voc1.deleted = 0 and voc1.objectID = dbo.i_catalog.catID) as catcnt,
(select COUNT(*) from catlist where catlist.catid = dbo.i_catalog.catID and catlist.deleted=0) as lstcnt,

1 as prjID,--dbo.getProjID(7, dbo.i_catalog.catID) as prjID, --LEN2

dbo.i_catalog.catName, 
dbo.i_catalog.catID, 
dbo.i_catalog.deleted, 
dbo.i_catalog.catTypeID, 
dbo.i_catalog.forTesting, 
dbo.i_catalog.catUnif, 
dbo.i_catalog.catOpen, 
dbo.i_catalog.catlistID,
--dbo.i_catalog.dsDrawingsID, 
--dbo.i_catalog.dsPartListID, 
dbo.i_catalog.catStatus, 
--dbo.i_catalog.dsLev, 
--dbo.i_catalog.dsNum, 
--dbo.i_catalog.catdefID, 
--dbo.i_catalog.specID,

--dbo.i_catalog.pwfolderID,

--dbo.r_object_catalog.ID as relID, 
--dbo.r_object_catalog.objectID, 
27 as objID,--dbo.r_object_catalog.objID, 

'pwbld' as objName,--dbo.object.objName,

CASE
	WHEN ISNULL(dbo.i_catalog.catID,'')='' Then 'pwfolder'
	ELSE 'catalog'
END AS image, 

dd.[dsID]
,dd.[bldid] as objectID
,dd.[bldname]
,dd.[o_projectname]
,dd.[o_projectdesc]
,dd.[o_credatetime]
,dd.[PROJECT_PackageCod]
,dd.[PROJECTTYPEID] as prjTypeID
,dd.[PROJECT_DocumentMainTitleRus]
,dd.[PROJECT_DocumentMainTitleRus_2]
,dd.[PROJECT_DocumentMainTitleRus_3]
,dd.[PROJECT_DocumentMainTitleRus_4]
,dd.[PROJECT_PROJECTNAME_RU]


FROM            dbo.r_object_catalog 

INNER JOIN dbo.i_catalog ON dbo.r_object_catalog.catalogID = dbo.i_catalog.catID 
INNER JOIN dbo.object ON dbo.r_object_catalog.objID = dbo.object.objID 

RIGHT JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].view_docsets_LEN2 AS dd ON dbo.i_catalog.dsDrawingsID = dd.dsID



GO
