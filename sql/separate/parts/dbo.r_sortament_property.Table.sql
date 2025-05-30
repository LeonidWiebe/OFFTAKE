SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_sortament_property](
	[relID] [bigint] IDENTITY(5277,1) NOT NULL,
	[srtmID] [bigint] NOT NULL,
	[area] [real] NULL,
	[diameter] [real] NULL,
	[height] [real] NULL,
	[horthickness] [real] NULL,
	[masslength] [real] NULL,
	[massunit] [real] NULL,
	[massvolume] [real] NULL,
	[thickness] [real] NULL,
	[verthickness] [real] NULL,
	[width] [real] NULL,
	[radius] [real] NULL,
	[angle] [real] NULL,
	[massarea] [real] NULL,
	[length] [real] NULL,
	[number] [bigint] NULL,
	[article] [bigint] NULL,
	[dopmass] [real] NULL,
	[speedmat] [bigint] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [_dta_index_r_sortament_property_c_5_450100644__K2] ON [dbo].[r_sortament_property]
(
	[srtmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_sortament_property_5_450100644__K2_1_3_4_5_6_7_8_9_10_11_12_14_15_16_17_18_19] ON [dbo].[r_sortament_property]
(
	[srtmID] ASC
)
INCLUDE([relID],[area],[diameter],[height],[horthickness],[masslength],[massunit],[massvolume],[thickness],[verthickness],[width],[radius],[angle],[massarea],[length],[number],[article]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_sortament_property_5_450100644__K2_3_4_5_6_7_8_9_10_11_12_14_15_16_17_18_19] ON [dbo].[r_sortament_property]
(
	[srtmID] ASC
)
INCLUDE([area],[diameter],[height],[horthickness],[masslength],[massunit],[massvolume],[thickness],[verthickness],[width],[radius],[angle],[massarea],[length],[number],[article]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_sortament_property_5_450100644__K2_4] ON [dbo].[r_sortament_property]
(
	[srtmID] ASC
)
INCLUDE([diameter]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_sortament_property_5_450100644__K2_K4_18] ON [dbo].[r_sortament_property]
(
	[srtmID] ASC,
	[diameter] ASC
)
INCLUDE([number]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_sortament_property_5_450100644__K2_K4_K12_K5_K10] ON [dbo].[r_sortament_property]
(
	[srtmID] ASC,
	[diameter] ASC,
	[width] ASC,
	[height] ASC,
	[thickness] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_sortament_property_5_450100644__K2_K4_K5_K12_K10_3_6_7_8_9_11_14_15_16] ON [dbo].[r_sortament_property]
(
	[srtmID] ASC,
	[diameter] ASC,
	[height] ASC,
	[width] ASC,
	[thickness] ASC
)
INCLUDE([area],[horthickness],[masslength],[massunit],[massvolume],[verthickness],[radius],[angle],[massarea]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
