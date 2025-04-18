SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 30.08.2019
-- Description: Получение типа элмента (фундаментная плита, фундамент под оборудование)
--select dbo.getConcrType ('@Wall_Width', '@Slab_Thickness')
-- =============================================
CREATE FUNCTION [dbo].[getConcrType] 
(
	@Wall_Type varchar (50),
	@Slab_Type  varchar (50)

)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @OutString   nvarchar(50)


	IF @Wall_Type is not null
		SET @OutString = @Wall_Type
	
	ELSE IF @Slab_Type is not null
		SET @OutString = @Slab_Type

	RETURN @OutString

END


GO
