SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_element_params]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 

dbo.getTrueArea2(dbo.elements.simID, 0, 2) AS ElementArea,
dbo.getTrueVertArea(dbo.elements.simID, 0, 2) AS ElementVertArea,
dbo.getTrueVolume(dbo.elements.simID, 0, 2) AS ElementVolume,
dbo.getTrueSpaceHeight(dbo.elements.simID, 0, 2) AS SpaceHeight,
NULL as Dummy

FROM         dbo.elements 





GO
