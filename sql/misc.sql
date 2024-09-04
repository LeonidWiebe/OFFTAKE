/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [aecosim].[dbo].[o_Building]

  --SELECT distinct [bldFIreClass]    FROM [aecosim].[dbo].[o_Building]

  




/*
  insert into [aecosim].[dbo].[o_Building] ([bldKKS],[bldFIreClass]) 
  select left(bld_kks,10),left(fire_dng_class,10)  from [10.36.69.19].[HHKV_1].[dbo].[bld_charact] where row_status !='D'
*/

/*
UPDATE
    b
SET
    b.[bldSafetyClass] = d.saf_class
    ,b.[bldFIreClass] = left(d.fire_dng_class,10)
FROM
    [aecosim].[dbo].[o_Building] AS b
    INNER JOIN [10.36.69.19].[HHKV_1].[dbo].[bld_charact] AS d
        on b.bldKKS = d.bld_kks
*/


/*

обновление bldID в o_Building

UPDATE
    b
SET
    b.pwFolderID = d.bldID
    --,b.[bldFIreClass] = left(d.fire_dng_class,10)
FROM
    [aecosim].[dbo].[o_Building] AS b
    INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS d
        on b.bldKKS = d.bldName where d.project_name='Hanhikivi'
*/


/*
обновление значения Doc2_autp_avl в i_Space

UPDATE [aecosim].[dbo].[i_Space] set Doc2_autp_avl = 0;


UPDATE
    s
SET
    s.[Doc2_autp_avl] = 
CASE 
	when CHARINDEX('yes', d.autp_avl) > 0 THEN 1
	when CHARINDEX('no', d.autp_avl) > 0 THEN -1
	ELSE 0
END
    
FROM
    [aecosim].[dbo].[i_Space] AS s
    INNER JOIN [10.36.69.19].[HHKV_1].[dbo].[room_charact] AS d
        on s.simID = d.simID

*/



select MAX(pMaxZ) from elements where  cattype='ConcreteSlabs' and bldID = 2447
select MAX(pMaxZ) from elements where  bldID = 2447

/*
update b
set b.bldHeight=(select MAX(pMaxZ) from elements where bldID = b.pwFolderID)
from [aecosim].[dbo].[o_Building]  b
    INNER JOIN [aecosim].[dbo].[elements] e
	on b.pwfolderid=e.bldid

*/