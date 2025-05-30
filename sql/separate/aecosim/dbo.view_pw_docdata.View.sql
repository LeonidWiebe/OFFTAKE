SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_pw_docdata]
AS
SELECT     
	dbo.pw_docdata.ID, 
	dms_stor.o_storname, 
	dms_stor.o_path, 
	dms_proj.o_projectname AS folderName, 
	dms_proj.o_projectcode, 
	dms_doc.o_itemname, 	                      
	dms_doc.o_original, 
	dms_stor.srvpath + dms_proj.o_projectcode + '/' + dms_doc.o_filename AS file_path, 
    dbo.pw_docdata.deleted, 
    dbo.func_pw_getProjectName(dms_proj.o_projectno) AS project_name, 
    dms_doc.o_docguid, 
    CONVERT(varchar, dms_doc.o_fupdatetime, 121) AS o_fupdatetime,-- ez 2017-07-06 synchronisation -------    
    CONVERT(varchar, dbo.pw_docdata.deleted)  + '#' + CONVERT(varchar, dms_doc.o_fupdatetime, 121) as cs,
    dbo.pw_docdata.last_state,
    dbo.pw_docdata.counter,
    dbo.pw_docdata.queue,
    dbo.pw_docdata.nwcheck,
	dbo.pw_docdata.dmsstatus as old_file_name,
	dbo.func_pw_getBuildingID(dms_proj.o_projectno) as bldID,
	dbo.func_pw_getBuildingName(dms_proj.o_projectno) as bldName,
	dms_doc.o_applno,
	CASE 
		WHEN dbo.pw_docdata.last_state = '' THEN CONVERT(varchar, pw_docdata.dt_change, 121)
		ELSE CONVERT(varchar, dms_doc.o_fupdatetime, 121)
	END AS colsort
FROM         dbo.pw_docdata

INNER JOIN view_pw_dms_doc AS dms_doc ON dms_doc.o_docguid = dbo.pw_docdata.docguid 
INNER JOIN view_pw_dms_proj AS dms_proj ON dms_doc.o_projectno = dms_proj.o_projectno 
INNER JOIN view_pw_dms_stor AS dms_stor ON dms_doc.o_storno = dms_stor.o_storno

WHERE CONVERT(varchar, dbo.pw_docdata.deleted)  + '#' + CONVERT(varchar, dms_doc.o_fupdatetime, 121) != last_state
AND (dbo.pw_docdata.counter < 6)
AND (dbo.pw_docdata.nwcheck = 0 OR (dbo.pw_docdata.nwcheck = 1 AND dbo.pw_docdata.deleted = 0)) -- чтобы не отрабатывало событие на изменение когда галка на файле снята
--AND dbo.pw_docdata.ID in (select ivalue from dbo.pw_docdata_test) -- больше не занимать очередь






GO
