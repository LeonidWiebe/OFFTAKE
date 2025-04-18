SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_NW_FH1_Building_Attributes]
AS
SELECT 

Titul.[obj_kks] AS 'KKS',
Titul.[Island] AS '~Group of buildings',
Titul.[obj_kks] AS '~Name',
(Titul.[Bld_Name_eng] +' / ' +Titul.[Bld_Name])  AS '~Description',
Titul.[Safe_Class] AS '~Safety class',
Titul.[Seismic] AS '~Seismic category',
Titul.[reliab_class] AS '~Reliability class',
'' AS '~Status',
'CB1' AS '~Configuration baseline',
Fire.fire_dng_class AS '~Fire class of the building', -- берется из таблицы [10.36.69.19].[HHKV_1].[dbo].[bld_charact], заполняется в табл.1 Характеристики зданий
'Stage 2' AS '~Stage'

FROM [10.36.69.19].[HHKV_1].[dbo].[titul_list] AS Titul

Inner JOIN [10.36.69.19].[HHKV_1].[dbo].[bld_charact] AS Fire ON Titul.[obj_kks]=Fire.[bld_kks]

where Fire.[ROW_STATUS] != 'D'








GO
