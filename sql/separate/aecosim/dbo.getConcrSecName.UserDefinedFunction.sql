SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 30.08.2019
-- Description:	Получение Названия сечения для железобетонных элементов
--select dbo.getConcrSecName ('@Wall_Width', '@Slab_Thickness', '@StructuralFramingCommon_sectionname')
-- =============================================
CREATE FUNCTION [dbo].[getConcrSecName] 
(
	@Wall_Width bigint,
	@Slab_Thickness  bigint,
	@StructuralFramingCommon_sectionname  varchar(50)
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @OutString   nvarchar(50)


	IF @Wall_Width is not null
		SET @OutString = CAST(@Wall_Width * 0.01 AS int)
	
	ELSE IF @Slab_Thickness is not null
		SET @OutString =CAST(@Slab_Thickness * 0.01 AS int)

	ELSE IF @StructuralFramingCommon_sectionname  is not null AND @StructuralFramingCommon_sectionname like '%x%' OR @StructuralFramingCommon_sectionname like '%X%'
		SET @OutString = @StructuralFramingCommon_sectionname 
	ELSE IF @StructuralFramingCommon_sectionname  is not null AND @StructuralFramingCommon_sectionname not like '%x%' OR @StructuralFramingCommon_sectionname not like '%X%'
	 SET @OutString = @StructuralFramingCommon_sectionname + 'x' + @StructuralFramingCommon_sectionname
	
	
	Else SET @OutString = '-'


	RETURN @OutString

END
--select dbo.getConcrSecName (NUll, Null, '600x600')

GO
