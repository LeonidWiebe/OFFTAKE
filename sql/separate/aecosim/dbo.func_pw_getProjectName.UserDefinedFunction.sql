SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Leonid Vibe
-- Create date: 27/02/2016
-- Description:	функция определения проекта для любой папки
-- =============================================
CREATE FUNCTION [dbo].[func_pw_getProjectName]
(
	@folderID int
)
RETURNS varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @m_pparentID int;
	DECLARE @m_parentID int;
	DECLARE @m_projname varchar(50);

	
	select 
	@m_parentID = s.o_parentno,
	@m_projname = s.o_projectname
	from view_pw_dms_proj s where s.o_projectno = @folderID
	
	select 
	@m_pparentID = s.o_parentno
	from view_pw_dms_proj s where s.o_projectno = @m_parentID
	
	
	if @m_pparentID = 0 -- folder 'Projects'
		return @m_projname
	
	return dbo.func_pw_getProjectName(@m_parentID)

	
END


--select pw_aep.dbo.func_pw_getProjectName(1897)









GO
