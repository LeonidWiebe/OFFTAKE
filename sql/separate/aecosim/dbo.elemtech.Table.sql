SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[elemtech](
	[simID] [bigint] IDENTITY(1,1) NOT NULL,
	[elemID] [bigint] NOT NULL,
	[pwdocID] [bigint] NOT NULL,
	[dtID] [bigint] NULL,
	[oid] [varchar](50) NOT NULL,
	[class] [varchar](200) NOT NULL,
	[name] [varchar](300) NOT NULL,
	[sppath] [varchar](500) NULL,
	[pCentX] [bigint] NOT NULL,
	[pCentY] [bigint] NOT NULL,
	[pCentZ] [bigint] NOT NULL,
	[pMinX] [bigint] NOT NULL,
	[pMinY] [bigint] NOT NULL,
	[pMinZ] [bigint] NOT NULL,
	[pMaxX] [bigint] NOT NULL,
	[pMaxY] [bigint] NOT NULL,
	[pMaxZ] [bigint] NOT NULL,
	[uors] [bigint] NOT NULL,
 CONSTRAINT [PK_elemtech] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_pCentX]  DEFAULT ((0)) FOR [pCentX]
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_pCentY]  DEFAULT ((0)) FOR [pCentY]
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_pCentZ]  DEFAULT ((0)) FOR [pCentZ]
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_pMinX]  DEFAULT ((0)) FOR [pMinX]
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_pMinY]  DEFAULT ((0)) FOR [pMinY]
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_pMinZ]  DEFAULT ((0)) FOR [pMinZ]
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_pMaxX]  DEFAULT ((0)) FOR [pMaxX]
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_pMaxY]  DEFAULT ((0)) FOR [pMaxY]
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_pMaxZ]  DEFAULT ((0)) FOR [pMaxZ]
GO
ALTER TABLE [dbo].[elemtech] ADD  CONSTRAINT [DF_elemtech_uors]  DEFAULT ((0)) FOR [uors]
GO
