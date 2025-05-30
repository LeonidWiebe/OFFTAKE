SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_FH1_Space_Building_Permit]
AS
SELECT     

elements.simID 
,elements.elemID 
,elements.pwdocID
,elements.bldID 
,elements.cattype

,dd.bldName
,dd.o_filename

,i_Space.number
,i_Space.label2

 -- Floor Area
--,dbo.getTrueArea2(dbo.elements.simID, 0, 2)  AS 'Floor area'
--,CAST(dbo.getTrueArea2(dbo.elements.simID, 0, 1) AS nvarchar)  AS 'Floor area'
-- Изменил Решетников ИО, по запросу от Павлова Станислава А. (для помещений площадью менее 15м выводить один знак после запятой, для остальных округлять до целого)
,case
	when dbo.getTrueArea2(dbo.elements.simID, 0, 2)>15 then CAST(dbo.getTrueArea2(dbo.elements.simID, 0, 0) AS nvarchar)
	else CAST(dbo.getTrueArea2(dbo.elements.simID, 0, 1) AS nvarchar)
end
	AS 'Floor area'

,CAST(dbo.getTrueSpaceHeight(dbo.elements.simID, 0, 2)*1000 AS nvarchar) AS [Ceiling Height]

FROM dbo.elements

INNER JOIN dbo.i_Space ON elements.simID = i_Space.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON elements.pwdocID = dd.id
--INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid -- Нужна ли эта строка?

WHERE dd.project_name = 'Hanhikivi'










GO
