SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Leonid Vibe
-- Create date: 27/02/2016
-- Description:	функция определения проекта для любой папки
-- =============================================
CREATE FUNCTION [dbo].[func_pw_getBuildingName]
(
	@folderID int
)
RETURNS varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @m_parentID int;
	DECLARE @m_projname varchar(50);
	DECLARE @m_classID int;

	
	
	select 
	@m_parentID = s.o_parentno,
	@m_projname = s.o_projectname,
	@m_classID = s.o_classid
	from view_pw_dms_proj s where s.o_projectno = @folderID
	

	IF @m_classID = 1059 return @m_projname-- PKS2_building
    IF @m_classID = 1073 return @m_projname-- ED_building
	IF @m_classID = 1030 return @m_projname-- FH1_building
	IF @m_classID = 1075 return @m_projname-- BN_building
		
	IF @m_parentID = 0 -- дальше некуда
		return ''
	
	return dbo.func_pw_getBuildingName(@m_parentID)

	
END


--select pw_aep.dbo.func_pw_getBuildingName(1897)











GO
