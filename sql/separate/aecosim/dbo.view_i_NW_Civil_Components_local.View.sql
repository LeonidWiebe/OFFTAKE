SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




















CREATE VIEW [dbo].[view_i_NW_Civil_Components_local]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [ObjectName]


FROM         dbo.elements 
















GO
