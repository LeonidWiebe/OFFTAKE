SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_FH1_SP3D_Room_Change]
AS
SELECT     
dbo.elements.simID
,dbo.elements.elemID 
,dbo.elements.pwdocID

,SUBSTRING (dbo.i_Space.number,0,6) AS 'Building'
,SUBSTRING (dbo.i_Space.number,0,8) AS 'Level'
,dbo.i_Space.number AS kks
--,DATEADD(s, dbo.elements.dtID, '1970-01-01 00:00:00') AS 'Date'
,SPKKS.ItemName
,SPKKS.oid
,round(SPrange.[xmin] * 1000, 0) AS [SP_xmin]
,dbo.elements.[pMinX]
,abs(round(SPrange.[xmin] * 1000, 0) - dbo.elements.[pMinX]) AS [dXmin]
,round(SPrange.[ymin] * 1000, 0) AS [SP_ymin]
,dbo.elements.[pMinY]
,abs(round(SPrange.[ymin] * 1000, 0)-dbo.elements.[pMinY]) AS [dYmin]
,round(SPrange.[zmin] * 1000, 0) AS [SP_zmin]
,dbo.elements.[pMinZ]
,abs(round(SPrange.[zmin] * 1000, 0)-dbo.elements.[pMinZ]) AS [dZmin]
,round(SPrange.[xmax] * 1000, 0) AS [SP_xmax]
,dbo.elements.[pMaxX]
,abs(round(SPrange.[xmax] * 1000, 0) - dbo.elements.[pMaxX]) AS [dXmax]
,round(SPrange.[ymax] * 1000, 0) AS [SP_ymax]
,dbo.elements.[pMaxY]
,abs(round(SPrange.[ymax] * 1000, 0) - dbo.elements.[pMaxY]) AS [dYmax]
,round(SPrange.[zmax] * 1000, 0) AS [SP_zmax]
,dbo.elements.[pMaxZ]
,abs(round(SPrange.[zmax] * 1000, 0) - dbo.elements.[pMaxZ]) AS [dZmax]
,round(SPVolume.VL, 2) AS 'SP_Volume'
,dbo.getTrueVolume(dbo.elements.simID, 0, 2) AS 'Volume'
,abs((round(SPVolume.VL*100, 0) - round(dbo.getTrueVolume(dbo.elements.simID, 0, 2)*100, 0))/100) AS 'dVolume'
,doc.o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
LEFT JOIN [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_MDB].[dbo].[JNamedItem] AS SPKKS ON  dbo.i_Space.number COLLATE SQL_Latin1_General_CP1_CI_AS = SPKKS.ItemName
LEFT JOIN [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_RDB].[dbo].[JRange] AS SPrange ON SPKKS.oid = SPrange.Oid
LEFT JOIN [dbo].[view_i_FH1_SP3D_Room_Vol] AS SPVolume ON SPVolume.KKS = dbo.i_Space.number COLLATE SQL_Latin1_General_CP1_CI_AS
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
Where dd.project_name = 'Hanhikivi' AND dd.deleted = 0 AND SUBSTRING (CAST(SPKKS.oid AS nvarchar (36)),0,9) = '00011178' AND  abs(round(SPrange.[xmin] * 1000, 0) - dbo.elements.[pMinX]) > 5
OR dd.project_name = 'Hanhikivi' AND dd.deleted = 0 AND SUBSTRING (CAST(SPKKS.oid AS nvarchar (36)),0,9) = '00011178' AND   abs(round(SPrange.[ymin] * 1000, 0)-dbo.elements.[pMinY]) > 5
OR dd.project_name = 'Hanhikivi' AND dd.deleted = 0 AND SUBSTRING (CAST(SPKKS.oid AS nvarchar (36)),0,9) = '00011178' AND   abs(round(SPrange.[zmin] * 1000, 0)-dbo.elements.[pMinZ]) > 5
OR dd.project_name = 'Hanhikivi' AND dd.deleted = 0 AND SUBSTRING (CAST(SPKKS.oid AS nvarchar (36)),0,9) = '00011178' AND   abs(round(SPrange.[xmax] * 1000, 0) - dbo.elements.[pMaxX]) > 5
OR dd.project_name = 'Hanhikivi' AND dd.deleted = 0 AND SUBSTRING (CAST(SPKKS.oid AS nvarchar (36)),0,9) = '00011178' AND   abs(round(SPrange.[ymax] * 1000, 0) - dbo.elements.[pMaxY]) > 5
OR dd.project_name = 'Hanhikivi' AND dd.deleted = 0 AND SUBSTRING (CAST(SPKKS.oid AS nvarchar (36)),0,9) = '00011178' AND   abs(round(SPrange.[zmax] * 1000, 0) - dbo.elements.[pMaxZ]) > 5
OR dd.project_name = 'Hanhikivi' AND dd.deleted = 0 AND SUBSTRING (CAST(SPKKS.oid AS nvarchar (36)),0,9) = '00011178' AND   abs((round(SPVolume.VL*100, 0) - round(dbo.getTrueVolume(dbo.elements.simID, 0, 2)*100, 0))/100) > 5

GO
