SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_NW_Changes]
AS
SELECT (
		SELECT COUNT(*) -----------------------------------rooms
		FROM i_Space 
		where i_Space.number = '' OR i_Space.number = NULL
		) AS Roomcount,
		(
		SELECT COUNT(*)
		FROM dbo.i_Space
		) AS Roomallcount,

		CAST(ROUND((SELECT CAST(COUNT(*) AS numeric) i_Space FROM dbo.i_Space where dbo.i_Space.number = '' OR dbo.i_Space.number = NULL)
		/
		(SELECT COUNT(*) FROM dbo.i_Space) 
		*100, 1)AS decimal(10,1))
		AS '% EMPTY',


		(
		SELECT COUNT(*)------------------------------------doors
		FROM i_DoorProperties
		where i_DoorProperties.KKS = '' OR i_DoorProperties.KKS IS NULL
		) AS Doorcount,
		(
		SELECT COUNT(*)
		FROM i_DoorProperties
		) AS Doorallcount,

		CAST(ROUND((SELECT CAST(COUNT(*) AS numeric) i_DoorProperties FROM i_DoorProperties where i_DoorProperties.KKS = '' OR i_DoorProperties.KKS IS NULL)
		/
		(SELECT COUNT(*) FROM i_DoorProperties)
		*100, 1)AS decimal(10,1))
		AS '% EMPTY1',



		(
		SELECT COUNT(*) ----------------------------------openongs
		FROM i_Opening
		where i_Opening.PartCode = '' OR i_Opening.PartCode IS NULL
		) AS OPcount,
		(
		SELECT COUNT(*)
		FROM i_Opening
		) AS OPallcount,

		CAST(ROUND((SELECT CAST(COUNT(*) AS numeric) i_Opening FROM i_Opening where i_Opening.PartCode = '' OR i_Opening.PartCode IS NULL)
		/
		(SELECT COUNT(*) FROM i_Opening)
		*100, 1)AS decimal(10,1))
		AS '% EMPTY2',

		(
		SELECT COUNT(*) ----------------------------------Parts
		FROM i_EmbPart
		where i_EmbPart.PartCode = '' OR i_EmbPart.PartCode IS NULL
		) AS Partscount,
		(
		SELECT COUNT(*)
		FROM i_EmbPart
		) AS Partsallcount,

		CAST(ROUND((SELECT CAST(COUNT(*) AS numeric) i_EmbPart FROM i_EmbPart where i_EmbPart.PartCode = '' OR i_EmbPart.PartCode IS NULL)
		/
		(SELECT COUNT(*) FROM i_EmbPart)
		*100, 1)AS decimal(10,1))
		AS '% EMPTY3',

		(
		SELECT COUNT(*)
		FROM i_StructProp
		where i_StructProp.StructCode = '' OR i_StructProp.StructCode IS NULL
		) AS Structscount,

		(
		SELECT COUNT(*)
		FROM i_StructProp
		) AS Structsallcount,


		CAST(ROUND((SELECT CAST(COUNT(*) AS numeric) i_StructProp FROM i_StructProp where i_StructProp.StructCode = '' OR i_StructProp.StructCode IS NULL)
		/
		(SELECT COUNT(*) FROM i_StructProp)
		*100, 1)AS decimal(10,1))
		AS '% EMPTY4',
		(
		SELECT COUNT(*) ---------------------------------Windows
		FROM i_WindowProperties
		where i_WindowProperties.KKS = '' OR i_WindowProperties.KKS IS NULL
		) AS Windowscount,
		(
		SELECT COUNT(*)
		FROM i_WindowProperties
		) AS Windowsallcount,

		CAST(ROUND((SELECT CAST(COUNT(*) AS numeric) i_WindowProperties FROM i_WindowProperties where i_WindowProperties.KKS = '' OR i_WindowProperties.KKS IS NULL)
		/
		(SELECT COUNT(*) FROM i_WindowProperties)
		*100, 1)AS decimal(10,1))
		AS '% EMPTY5'
		
	


FROM         dbo.elements


LEFT JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
inner JOIN  dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID
LEFT JOIN  dbo.i_Opening ON dbo.elements.simID = dbo.i_Opening.simID
LEFT JOIN  dbo.i_EmbPart ON dbo.elements.simID = dbo.i_EmbPart.simID
LEFT JOIN  dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID
LEFT JOIN  dbo.i_WindowProperties ON dbo.elements.simID = dbo.i_WindowProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid





























GO
