SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[o_Building](
	[simID] [bigint] IDENTITY(1,1) NOT NULL,
	[bldKKS] [varchar](10) NULL,
	[bldSafetyClass] [varchar](10) NULL,
	[bldFIreClass] [varchar](10) NULL,
	[pwFolderID] [bigint] NULL,
	[bldHeight] [bigint] NULL,
	[dtID] [bigint] NULL,
	[serverID] [bigint] NOT NULL,
	[prjName] [varchar](50) NULL,
	[offsetX] [bigint] NOT NULL,
	[offsetY] [bigint] NOT NULL,
	[offsetZ] [bigint] NOT NULL,
 CONSTRAINT [PK_o_Building] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[o_Building] ADD  CONSTRAINT [DF_o_Building_serverID]  DEFAULT ((1)) FOR [serverID]
GO
ALTER TABLE [dbo].[o_Building] ADD  CONSTRAINT [DF_o_Building_dwgX]  DEFAULT ((0)) FOR [offsetX]
GO
ALTER TABLE [dbo].[o_Building] ADD  CONSTRAINT [DF_o_Building_dwgY]  DEFAULT ((0)) FOR [offsetY]
GO
ALTER TABLE [dbo].[o_Building] ADD  CONSTRAINT [DF_o_Building_dwgZ]  DEFAULT ((0)) FOR [offsetZ]
GO
