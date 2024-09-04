SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_FH1_SP3D_Room_Name]
AS
SELECT 
SA.oid
,nm.ItemName
FROM [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_MDB].[dbo].[JDArea] sa
join [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_MDB].[dbo].[XSpaceHierarchy] x1 on x1.oiddestination=sa.oid
join [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_MDB].[dbo].[JDSpaceFolder] sf on sf.oid=x1.oidorigin
join [HNH-SP3D.SP.SPBAEP.RU].[HnhNPP_MDB].[dbo].[JNamedItem] nm on nm.oid=sa.oid






GO
