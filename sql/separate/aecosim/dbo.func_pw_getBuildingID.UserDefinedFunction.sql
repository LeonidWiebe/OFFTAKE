SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Leonid Vibe
-- Create date: 27/02/2016
-- Description:	функция определения проекта для любой папки
-- =============================================
CREATE FUNCTION [dbo].[func_pw_getBuildingID]
(
	@folderID int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @m_prntID int;
	DECLARE @m_classID int;

	
	
	select 
	@m_prntID = s.o_parentno,
	@m_classID = s.o_classid
	from view_pw_dms_proj s where s.o_projectno = @folderID
	

	IF @m_classID = 1059 return @folderID -- PKS2_building
    IF @m_classID = 1073 return @folderID -- ED_building
	IF @m_classID = 1030 return @folderID -- FH1_building
	IF @m_classID = 1075 return @folderID -- BN_building
	
	-- pw-srv
	--IF @m_classID = 1059 return @folderID -- PKS2_building
	--IF @m_classID = 1073 return @folderID -- ED_building
	--IF @m_classID = 1030 return @folderID -- FH1_building
	--IF @m_classID = 1075 return @folderID -- BN_building
	--IF @m_classID = 1078 return @folderID -- TW_building
	--IF @m_classID = 1081 return @folderID -- SH12_building
	
	-- pwrk
	--IF @m_classID = 1057 return @folderID -- FH1_building
	--IF @m_classID = 1058 return @folderID -- PKS2_building
	--IF @m_classID = 1062 return @folderID -- ED_building
	--IF @m_classID = 1065 return @folderID -- XDP_Building
		
		
	IF @m_prntID = 0 return 0 -- дальше некуда
		
	
	return dbo.func_pw_getBuildingID(@m_prntID)

	
END


--select pw_aep.dbo.getProjName(1897)












GO
