SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_pdset_posdef](
	[relID] [bigint] IDENTITY(1,1) NOT NULL,
	[pdsID] [bigint] NOT NULL,
	[posdefID] [bigint] NOT NULL,
	[relNameAlt] [varchar](250) NULL,
	[relDrawName] [bit] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[r_pdset_posdef] ADD  CONSTRAINT [DF_r_pdset_posdef_pdsID]  DEFAULT ((0)) FOR [pdsID]
GO
ALTER TABLE [dbo].[r_pdset_posdef] ADD  CONSTRAINT [DF_r_pdset_posdef_posdefID]  DEFAULT ((0)) FOR [posdefID]
GO
