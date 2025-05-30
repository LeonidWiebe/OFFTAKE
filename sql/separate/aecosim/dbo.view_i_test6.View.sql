SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_test6]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.i_Space.number as [kks], 
--dbo.i_Space.label as [name rus], 
--dbo.i_Space.label2 as [name emg], 
dbo.i_Space.label + ' / ' + dbo.i_Space.label as [name], 
dbo.i_Space.actualGross * 1e-10 AS area,
'm^2' as aa,
dbo.elements.elemVolume * 1e-15 AS volume, 
'm^3' as bb,
case 
	when dbo.i_Space.AccessArea = 'CA' then 'Contro'
	when dbo.i_Space.AccessArea = 'SA' then 'Safety'
	else '-'
end as [acc],
'Generic' as cc,
LEFT(dbo.i_Space.number, 7) as [level]
FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID







GO
