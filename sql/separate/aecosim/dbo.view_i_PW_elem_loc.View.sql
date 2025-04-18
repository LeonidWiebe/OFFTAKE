SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*


INSERT INTO [dbo].[o_Building] (pwFolderID, bldKKS, prjName,serverID,offsetX,offsetY,offsetZ)
SELECT bldID,bldDir,prjName,2,0,0,0 FROM [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].view_buildings
WHERE len(bldNum) >0 and prjName in ('Tianwan','Xudapu') and bldDir=unitNum+bldNum+bldCode ; 



INSERT INTO [dbo].[o_Building] (pwFolderID, bldKKS, prjName,serverID,offsetX,offsetY,offsetZ)
SELECT bldID,bldDir,prjName,1,0,0,0 FROM [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].view_buildings
WHERE len(bldNum) >0; 

--bldID	prjCode	prjName		bldDir	unitNum	bldNum	bldCode	bldName	bldLevel	bldTable			bldPath
--45571	LN2		Laes2006	10UJA	1		0		UJA		NULL	&&			I_LEN2_BUILDING		ЛАЭС-2006/Блок 1/Ядерный остров/10UJA/

!!!!!!!!!!!!!!!!!!!!!!!!!!
bldID может не быть уникальным
уникальнсть за счет bldID+serverID
!!!!!!!!!!!!!!!!!!!!!!
проверка на уникальность:
SELECT a.*,(select count(*) from o_building b where b.pwfolderid=a.pwFolderID) as cnt
  FROM [aecosim].[dbo].[o_Building] a
order by cnt desc



*/



CREATE VIEW [dbo].[view_i_PW_elem_loc]
AS
SELECT     

--dbo.elements.*, 

 dbo.elements.[simID]
,dbo.elements.[elemID]
,dbo.elements.[pwdocID]
,dbo.elements.[elemguid]
,dbo.elements.[cattype]
,dbo.elements.[catitem]
,dbo.elements.[partdef]
,dbo.elements.[elemVolume]
,dbo.elements.[isexternal]
,dbo.elements.[dtID]
,dbo.elements.[pCentX]
,dbo.elements.[pCentY]
,dbo.elements.[pCentZ]
,dbo.elements.[pMinX]
,dbo.elements.[pMinY]
,dbo.elements.[pMinZ]
,dbo.elements.[pMaxX]
,dbo.elements.[pMaxY]
,dbo.elements.[pMaxZ]
,dbo.elements.[elemarea]
,dbo.elements.[elemvertarea]
,dbo.elements.[elemVolumeMan]
,dbo.elements.[elemareaMan]
,dbo.elements.[elemvertareaMan]
,dbo.elements.[uors]
,dbo.elements.[elemOldID]
,dbo.elements.[bldID]
,dbo.elements.[modID]


,b.bldKKS as bldName
,b.pwFolderID as buildingID
,b.serverID
,d.prjName as project_name
,d.file_path
,d.catID as offt_catID
--,dd.o_original

FROM         dbo.elements 

INNER JOIN dbo.pw_docs d ON dbo.elements.pwdocID = d.pwdocID
INNER JOIN dbo.o_Building b ON d.bldID = b.pwFolderID

where d.deleted=0

GO
