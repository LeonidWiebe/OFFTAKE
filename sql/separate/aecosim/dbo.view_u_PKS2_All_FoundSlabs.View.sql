SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_u_PKS2_All_FoundSlabs]
AS
SELECT     
--e.pwdocID,
e.elemID,
--dd.project_name as prjname,
--dd.o_filename as filepath
'//pwx.sp.spbaep.ru/sync/'+dd.old_file_name + '.dgn' as filepath,
dd.bldname as bldname
FROM         dbo.elements e
inner join i_Slab s on e.simID=s.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON e.pwdocID = dd.id

where dd.deleted = 0 
and e.cattype like '%Slab%'
and s.Type = 'Foundation'
and e.partdef like '%Hydro%'
and dd.project_name='Paks-2'

--group by 
--dd.bldname, 
--pwdocID,
--dd.project_name, 
--dd.o_filename,
--dd.old_file_name

--having  dd.project_name='Paks-2'










GO
