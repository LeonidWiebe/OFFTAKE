SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[docset](
	[dsID] [bigint] IDENTITY(1,1) NOT NULL,
	[dsNumber] [varchar](200) NOT NULL,
	[dsTypeID] [bigint] NOT NULL,
	[projectID] [bigint] NOT NULL,
	[dsLevel] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON
GO
CREATE CLUSTERED INDEX [_dta_index_docset_c_5_699149536__K1_K2] ON [dbo].[docset]
(
	[dsID] ASC,
	[dsNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[docset] ADD  CONSTRAINT [DF_docset_dsTypeID]  DEFAULT ((0)) FOR [dsTypeID]
GO
ALTER TABLE [dbo].[docset] ADD  CONSTRAINT [DF_docset_projectID]  DEFAULT ((0)) FOR [projectID]
GO
ALTER TABLE [dbo].[docset] ADD  CONSTRAINT [DF_docset_dsLevel]  DEFAULT ((0)) FOR [dsLevel]
GO
