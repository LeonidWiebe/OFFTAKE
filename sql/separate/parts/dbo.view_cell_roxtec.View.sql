SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_cell_roxtec]
AS
SELECT     dbo.ms_cell_library.clID, dbo.ms_cell_library.clName, dbo.ms_cell_library.clFileName, dbo.ms_cell_roxtec.cellID AS mslink, 
                      dbo.ms_cell_roxtec.cellName, RTRIM(LTRIM(STR(dbo.ms_cell_roxtec.frameHeight))) + 'x' + RTRIM(LTRIM(STR(dbo.ms_cell_roxtec.frameWidth))) 
                      AS cellSize
FROM         dbo.ms_cell_library INNER JOIN
                      dbo.ms_cell_roxtec ON dbo.ms_cell_library.clID = dbo.ms_cell_roxtec.clID
GO
