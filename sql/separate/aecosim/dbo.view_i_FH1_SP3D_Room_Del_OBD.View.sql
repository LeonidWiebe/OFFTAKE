SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_FH1_SP3D_Room_Del_OBD]
AS
SELECT    
SUBSTRING (JNamedItem.ItemName,0,6) AS 'Building' 
,SUBSTRING (JNamedItem.ItemName,0,8) AS 'Level' 
,JNamedItem.ItemName
--,i_Space.number
,JNamedItem2.Oid
from [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_MDB].[dbo].[JNamedItem] AS JNamedItem
LEFT JOIN aecosim.dbo.i_Space AS i_Space ON JNamedItem.ItemName = i_Space.number COLLATE SQL_Latin1_General_CP1_CI_AS
LEFT JOIN [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_MDB].[dbo].[JNamedItem] AS JNamedItem2 ON JNamedItem.ItemName = JNamedItem2.ItemName
Where JNamedItem.IIDforTypeString = '246DA09F-F7FD-4D49-A13E-D9C4123E82BA' AND LEN(JNamedItem.ItemName)= 11 
AND i_Space.number is Null 
AND SUBSTRING (CAST(JNamedItem2.oid AS nvarchar (36)),0,9) = '00011178'
GO
