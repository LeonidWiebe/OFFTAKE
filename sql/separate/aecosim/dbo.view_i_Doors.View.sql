SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_Doors]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
dbo.elements.cattype, 
dbo.elements.catitem, 
dbo.elements.partdef, 
dbo.elements.isexternal, 
dbo.i_DoorProperties.KKS, 
round(dbo.i_Dimensions.width * 1e-2, 2, 2) AS [width] ,
round(dbo.i_Dimensions.height * 1e-2, 2, 2) AS [height],
dbo.elements.dtID

FROM         dbo.elements 

INNER JOIN dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID 
INNER JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID



GO
