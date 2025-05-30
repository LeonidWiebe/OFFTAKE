SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_FH1_EmbPart_Wise_Group3]
AS
SELECT 
      el.simID
      ,elemID
      ,pwdocID
      ,[catitem]
      ,ep.catalogname
      ,ep.partcode
      ,[pCentX]
      ,[pCentY]
      ,[pCentZ]
      ,[pMinX]
      ,[pMinY]
      ,[pMinZ]
      ,[pMaxX]
      ,[pMaxY]
      ,[pMaxZ]
	  ,dbo.getEmbSection([pCentZ],[pCentX],NULL,NULL,NULL,NULL,[pCentY],NULL) AS Combo

  FROM [dbo].[elements] el
  left outer join dbo.i_EmbPart ep on ep.simid=el.simID 
  where cattype='EmbeddedPart'





GO
