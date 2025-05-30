SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_part_kks](
	[kksID] [bigint] IDENTITY(1,1) NOT NULL,
	[kksSys] [varchar](5) NOT NULL,
	[kksNum] [int] NOT NULL,
	[projectID] [bigint] NOT NULL,
	[partID] [bigint] NOT NULL,
	[formrow] [int] NOT NULL,
	[formcol] [int] NOT NULL,
 CONSTRAINT [PK_kks] PRIMARY KEY CLUSTERED 
(
	[kksID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[r_part_kks] ADD  CONSTRAINT [DF_kks_kksNum]  DEFAULT ((0)) FOR [kksNum]
GO
ALTER TABLE [dbo].[r_part_kks] ADD  CONSTRAINT [DF_kks_projectID]  DEFAULT ((0)) FOR [projectID]
GO
ALTER TABLE [dbo].[r_part_kks] ADD  CONSTRAINT [DF_r_part_kks_partID]  DEFAULT ((0)) FOR [partID]
GO
ALTER TABLE [dbo].[r_part_kks] ADD  CONSTRAINT [DF_r_part_kks_row]  DEFAULT ((0)) FOR [formrow]
GO
ALTER TABLE [dbo].[r_part_kks] ADD  CONSTRAINT [DF_r_part_kks_col]  DEFAULT ((0)) FOR [formcol]
GO
