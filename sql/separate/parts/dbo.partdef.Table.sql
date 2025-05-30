SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[partdef](
	[partdefID] [bigint] IDENTITY(14,1) NOT NULL,
	[partdefName] [varchar](100) NOT NULL,
	[partdefNameMulti] [varchar](100) NULL,
	[partdefUsePositions] [bit] NOT NULL,
	[parentID] [bigint] NOT NULL,
	[partdefSort] [int] NOT NULL,
	[kksDiv] [varchar](2) NULL,
	[pdsID] [bigint] NOT NULL,
 CONSTRAINT [PK_partdef] PRIMARY KEY CLUSTERED 
(
	[partdefID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[partdef] ADD  CONSTRAINT [DF_partdef_partdefUsePositions]  DEFAULT ((0)) FOR [partdefUsePositions]
GO
ALTER TABLE [dbo].[partdef] ADD  CONSTRAINT [DF_partdef_parentID]  DEFAULT ((0)) FOR [parentID]
GO
ALTER TABLE [dbo].[partdef] ADD  CONSTRAINT [DF_partdef_partdefSort]  DEFAULT ((0)) FOR [partdefSort]
GO
ALTER TABLE [dbo].[partdef] ADD  CONSTRAINT [DF_partdef_pdsID]  DEFAULT ((0)) FOR [pdsID]
GO
