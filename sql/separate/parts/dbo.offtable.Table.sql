SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[offtable](
	[offtID] [bigint] IDENTITY(1,1) NOT NULL,
	[objectID] [bigint] NOT NULL,
	[objID] [bigint] NOT NULL,
	[partdefName] [varchar](250) NULL,
	[srtmName] [varchar](50) NULL,
	[matName] [varchar](150) NULL,
	[mass] [real] NOT NULL,
	[qty] [real] NOT NULL,
	[partdefID] [bigint] NOT NULL,
	[srtmID] [bigint] NOT NULL,
	[matID] [bigint] NOT NULL,
	[changes] [int] NOT NULL,
 CONSTRAINT [PK_offtable] PRIMARY KEY CLUSTERED 
(
	[offtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [_dta_index_offtable_5_615673241__K3_K2_K10_K9_K11_1_7_8_12] ON [dbo].[offtable]
(
	[objID] ASC,
	[objectID] ASC,
	[srtmID] ASC,
	[partdefID] ASC,
	[matID] ASC
)
INCLUDE([offtID],[mass],[qty],[changes]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[offtable] ADD  CONSTRAINT [DF_offtable_objectID]  DEFAULT ((0)) FOR [objectID]
GO
ALTER TABLE [dbo].[offtable] ADD  CONSTRAINT [DF_offtable_objID]  DEFAULT ((0)) FOR [objID]
GO
ALTER TABLE [dbo].[offtable] ADD  CONSTRAINT [DF_offtable_mass]  DEFAULT ((0)) FOR [mass]
GO
ALTER TABLE [dbo].[offtable] ADD  CONSTRAINT [DF_offtable_qty]  DEFAULT ((0)) FOR [qty]
GO
ALTER TABLE [dbo].[offtable] ADD  CONSTRAINT [DF_offtable_partdefID]  DEFAULT ((0)) FOR [partdefID]
GO
ALTER TABLE [dbo].[offtable] ADD  CONSTRAINT [DF_offtable_srtmID]  DEFAULT ((0)) FOR [srtmID]
GO
ALTER TABLE [dbo].[offtable] ADD  CONSTRAINT [DF_offtable_matID]  DEFAULT ((0)) FOR [matID]
GO
ALTER TABLE [dbo].[offtable] ADD  CONSTRAINT [DF_offtable_changes]  DEFAULT ((0)) FOR [changes]
GO
