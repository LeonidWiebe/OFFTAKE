SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_catalog](
	[catID] [bigint] IDENTITY(367,1) NOT NULL,
	[catName] [varchar](250) NULL,
	[deleted] [bit] NULL,
	[catTypeID] [bigint] NOT NULL,
	[catlistID] [bigint] NOT NULL,
	[forTesting] [bit] NOT NULL,
	[catUnif] [bit] NOT NULL,
	[catOpen] [bit] NOT NULL,
	[dsDrawingsID] [bigint] NOT NULL,
	[dsPartListID] [bigint] NOT NULL,
	[catStatus] [int] NOT NULL,
	[dsLev] [int] NULL,
	[dsNum] [int] NULL,
	[catdefID] [bigint] NOT NULL,
	[specID] [bigint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON
GO
CREATE CLUSTERED INDEX [_dta_index_i_catalog_c_5_261575970__K1] ON [dbo].[i_catalog]
(
	[catID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_catalog_5_261575970__K1_2] ON [dbo].[i_catalog]
(
	[catID] ASC
)
INCLUDE([catName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_catalog_5_261575970__K1_2_3_4_5_6_7_8] ON [dbo].[i_catalog]
(
	[catID] ASC
)
INCLUDE([catName],[deleted],[catTypeID],[catlistID],[forTesting],[catUnif],[catOpen]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_catalog_5_261575970__K1_K3_2_4_5_6_7_8_9_10] ON [dbo].[i_catalog]
(
	[catID] ASC,
	[deleted] ASC
)
INCLUDE([catName],[catTypeID],[catlistID],[forTesting],[catUnif],[catOpen],[dsDrawingsID],[dsPartListID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_catalog_5_261575970__K3_1_2] ON [dbo].[i_catalog]
(
	[deleted] ASC
)
INCLUDE([catID],[catName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_catalog_5_261575970__K3_K1] ON [dbo].[i_catalog]
(
	[deleted] ASC,
	[catID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_catalog_5_261575970__K3_K4_K6_K7_K1_2_5_8_9_10] ON [dbo].[i_catalog]
(
	[deleted] ASC,
	[catTypeID] ASC,
	[forTesting] ASC,
	[catUnif] ASC,
	[catID] ASC
)
INCLUDE([catName],[catlistID],[catOpen],[dsDrawingsID],[dsPartListID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_catalog_5_261575970__K4_K1] ON [dbo].[i_catalog]
(
	[catTypeID] ASC,
	[catID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_catalog_5_261575970__K5_1] ON [dbo].[i_catalog]
(
	[catlistID] ASC
)
INCLUDE([catID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_catalog_5_261575970__K9_K1] ON [dbo].[i_catalog]
(
	[dsDrawingsID] ASC,
	[catID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[i_catalog] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[i_catalog] ADD  DEFAULT ((1)) FOR [catTypeID]
GO
ALTER TABLE [dbo].[i_catalog] ADD  DEFAULT ((0)) FOR [catlistID]
GO
ALTER TABLE [dbo].[i_catalog] ADD  DEFAULT ((0)) FOR [forTesting]
GO
ALTER TABLE [dbo].[i_catalog] ADD  DEFAULT ((0)) FOR [catUnif]
GO
ALTER TABLE [dbo].[i_catalog] ADD  CONSTRAINT [DF_i_catalog_catOpen]  DEFAULT ((1)) FOR [catOpen]
GO
ALTER TABLE [dbo].[i_catalog] ADD  CONSTRAINT [DF_i_catalog_dsDrawingsID]  DEFAULT ((0)) FOR [dsDrawingsID]
GO
ALTER TABLE [dbo].[i_catalog] ADD  CONSTRAINT [DF_i_catalog_dsPartListID]  DEFAULT ((0)) FOR [dsPartListID]
GO
ALTER TABLE [dbo].[i_catalog] ADD  CONSTRAINT [DF_i_catalog_catStatus]  DEFAULT ((0)) FOR [catStatus]
GO
ALTER TABLE [dbo].[i_catalog] ADD  CONSTRAINT [DF_i_catalog_catdefID]  DEFAULT ((0)) FOR [catdefID]
GO
ALTER TABLE [dbo].[i_catalog] ADD  CONSTRAINT [DF_i_catalog_specID]  DEFAULT ((0)) FOR [specID]
GO
