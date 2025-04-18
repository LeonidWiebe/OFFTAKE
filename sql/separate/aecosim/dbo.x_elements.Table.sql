SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[x_elements](
	[simID] [bigint] NULL,
	[elemID] [bigint] NULL,
	[pwdocID] [bigint] NULL,
	[elemguid] [varchar](50) NULL,
	[cattype] [varchar](200) NULL,
	[catitem] [varchar](200) NULL,
	[partdef] [varchar](200) NULL,
	[elemVolume] [real] NULL,
	[isexternal] [bit] NULL,
	[dtID] [bigint] NULL,
	[pCentX] [bigint] NULL,
	[pCentY] [bigint] NULL,
	[pCentZ] [bigint] NULL,
	[pMinX] [bigint] NULL,
	[pMinY] [bigint] NULL,
	[pMinZ] [bigint] NULL,
	[pMaxX] [bigint] NULL,
	[pMaxY] [bigint] NULL,
	[pMaxZ] [bigint] NULL,
	[elemarea] [bigint] NULL,
	[elemvertarea] [bigint] NULL,
	[elemVolumeMan] [real] NULL,
	[elemareaMan] [real] NULL,
	[elemvertareaMan] [real] NULL,
	[uors] [bigint] NULL,
	[elemOldID] [bigint] NULL,
	[bldID] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
