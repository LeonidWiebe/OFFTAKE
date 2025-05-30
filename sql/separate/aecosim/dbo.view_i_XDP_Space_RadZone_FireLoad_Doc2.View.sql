SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_XDP_Space_RadZone_FireLoad_Doc2]
AS
SELECT     

dbo.elements.simID, 
--dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemOldID, 
dd.[o_docguid] as docguid,
dbo.elements.dtID, 

sp.number as kks,

r.ra_avl,
r.category_final,

r.If_uchastok

--dd.project_name, 
--dd.deleted

FROM         dbo.elements 

INNER JOIN dbo.i_Space sp ON dbo.elements.simID = sp.simID

INNER JOIN [10.36.69.85].[XZS].[dbo].[room_charact] AS r on dbo.elements.simID = r.simid
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id


WHERE r.If_uchastok = 'Помещение'
--в room_charact есть не только помещения, но и участки помещений с теми же кодами и simid. 
--По требованиям норм пожарной безопасности, одно помещение может быть разбито на несколько участков, поэтому нужно такое ограничение во вьюхе.




GO
