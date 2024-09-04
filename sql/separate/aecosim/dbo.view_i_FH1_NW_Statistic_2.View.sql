SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_FH1_NW_Statistic_2]
AS
SELECT 


[dbo].[view_i_FH1_NW_Statistic].[project_name], 
[dbo].[view_i_FH1_NW_Statistic].bldname, 
[dbo].[view_i_FH1_NW_Statistic].[object], 
C_EX.[~Carbonation corrosion] AS CC




from [dbo].[view_i_FH1_NW_Statistic]

--INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
--INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid

INNER JOIN dbo.view_i_NW_Concrete_Exposure_Classes AS C_EX ON [dbo].[view_i_FH1_NW_Statistic].[elemID] = C_EX.[elemID]



















GO
