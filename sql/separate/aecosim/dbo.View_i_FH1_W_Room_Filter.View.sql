SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[View_i_FH1_W_Room_Filter]
AS
SELECT     
e.simID, 
e.elemID, 
e.pwdocID, 
e.cattype, 
e.catitem, 
e.bldID, 
s.fcID,
s.number, 
s.roomID,
dd.project_name,
dd.bldName,
dd.o_filename,
LEFT(s.number,7) as qwe,
case when CHARINDEX(LEFT(s.number,7),dd.o_filename)>0 then '1' else '0' end as ex

FROM dbo.elements e

INNER JOIN dbo.i_Space s ON e.simID = s.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON e.pwdocID = dd.id

where project_name='Hanhikivi' and bldName='10UKD'


GO
