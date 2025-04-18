SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_pw_dms_stor]
AS
SELECT 
	[o_storno],
	[o_storname],
	[o_stordesc],
	[o_node],
	[o_path],
	[o_protocol],
	'//pw-srv.sp.spbaep.ru/pwfiles/' as srvpath
FROM [pw-srv.sp.spbaep.ru].[pw_aep].[dbo].[dms_stor]
union
SELECT
	[o_storno],
	[o_storname],
	[o_stordesc],
	[o_node],
	[o_path],
	[o_protocol],
	'//pwrk.sp.spbaep.ru/pwfiles/' as srvpath
FROM [pwrk.sp.spbaep.ru].[pw_aep_con].[dbo].[dms_stor]


GO
