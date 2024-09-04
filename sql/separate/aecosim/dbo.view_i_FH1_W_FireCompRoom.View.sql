SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_FH1_W_FireCompRoom]
AS
SELECT        
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.elemOldID, 
dbo.elements.pwdocID, 
fc1.fcID as fcID,
--dbo.elements.cattype, 
--dbo.elements.catitem, 
i_Space.label as [room name], 
i_Space.number as [room code], 
fc1.fcCode as [fc code],
'EI'+cast(fc1.fcFireRes as varchar) AS [fire res]
--i_Space.NumFireComp2 as fc2,
--,dd.project_name
FROM    dbo.elements        
INNER JOIN dbo.i_Space ON i_Space.simID = dbo.elements.simID

LEFT OUTER JOIN dbo.o_FireComp fc1 ON fc1.fcID = dbo.i_Space.fcID and dbo.i_Space.fcID>0
LEFT OUTER JOIN dbo.o_FireComp fc2 ON fc2.fcCode = dbo.i_Space.NumFireComp and dbo.i_Space.fcID=0

--INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id

--where fc1.fcID is not null

--group by i_Space.NumFireComp








GO
