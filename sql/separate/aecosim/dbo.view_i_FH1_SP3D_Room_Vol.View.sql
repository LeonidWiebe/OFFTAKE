SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_FH1_SP3D_Room_Vol]
AS
SELECT     
SUBSTRING (JNamedItem.ItemName,0,12) AS KKS,
COUNT(SPVolume.Volume) AS Col,
CASE
	When (ROUND(SUM(SPVolume.Volume)/2,2) - ROUND(MAX(SPVolume.Volume),2)) < 0 OR COUNT(SPVolume.Volume) = 1  THEN ROUND(SUM(SPVolume.Volume),2)
	ELSE ROUND(SUM(SPVolume.Volume)/2,2)
 END AS VL
from [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_MDB].[dbo].[JNamedItem] AS JNamedItem
LEFT JOIN [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_RDB].[dbo].[JVolume] AS SPVolume ON SPVolume.oid = JNamedItem.Oid
Where SUBSTRING (CAST(JNamedItem.oid AS nvarchar (36)),0,9) = '00011178'
--AND SUBSTRING (JNamedItem.ItemName,0,12) IN ( '10UKA94R142','10UKA94R231','10UKA94R314','10UKA99R211','10UKA31R132')
Group by  SUBSTRING (JNamedItem.ItemName,0,12)

--  SELECT     
--JNamedItem.ItemName AS KKS,
--ROUND(SPVolume.Volume,2) AS VL
--from [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_MDB].[dbo].[JNamedItem] AS JNamedItem
--LEFT JOIN [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_RDB].[dbo].[JVolume] AS SPVolume ON SPVolume.oid = JNamedItem.Oid
--Where SUBSTRING (CAST(JNamedItem.oid AS nvarchar (36)),0,9) = '00011178'
--AND SUBSTRING (JNamedItem.ItemName,0,12) IN ( '10UKA94R142','10UKA94R231','10UKA94R314','10UKA99R211','10UKA31R132')
--ORder by kks


GO
