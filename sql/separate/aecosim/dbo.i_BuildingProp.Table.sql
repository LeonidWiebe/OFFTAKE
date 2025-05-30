SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_BuildingProp](
	[simID] [bigint] NOT NULL,
	[BuildingKKS] [varchar](10) NULL,
	[SafetyClass] [varchar](10) NULL,
	[FIreClass] [varchar](10) NULL,
	[pwFolderID] [bigint] NULL,
	[bldHeight] [bigint] NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_BuildingProp] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[i_BuildingProp] ADD  CONSTRAINT [DF_i_BuildingProp_simID]  DEFAULT ((0)) FOR [simID]
GO
