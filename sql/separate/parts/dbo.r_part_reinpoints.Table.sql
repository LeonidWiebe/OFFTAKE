SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_part_reinpoints](
	[rpID] [bigint] IDENTITY(1,1) NOT NULL,
	[partID] [bigint] NOT NULL,
	[posID] [bigint] NOT NULL,
	[x] [bigint] NOT NULL,
	[y] [bigint] NOT NULL,
	[z] [bigint] NOT NULL,
	[xd] [real] NOT NULL,
	[yd] [real] NOT NULL,
	[zd] [real] NOT NULL,
	[isMain] [bit] NOT NULL,
	[isOk] [bit] NOT NULL,
	[xs] [real] NOT NULL,
	[ys] [real] NOT NULL,
	[zs] [real] NOT NULL,
	[isSketchOk] [bit] NOT NULL,
	[xa] [bigint] NOT NULL,
	[ya] [bigint] NOT NULL,
	[za] [bigint] NOT NULL,
	[isCont] [bit] NOT NULL,
	[onArc] [bit] NOT NULL,
 CONSTRAINT [PK_r_part_reinpoints_2] PRIMARY KEY CLUSTERED 
(
	[rpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_part_reinpoints_5_1166627199__K2_1_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19] ON [dbo].[r_part_reinpoints]
(
	[partID] ASC
)
INCLUDE([rpID],[posID],[x],[y],[z],[xd],[yd],[zd],[isMain],[isOk],[xs],[ys],[zs],[isSketchOk],[xa],[ya],[za],[isCont]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_part_reinpoints_5_1166627199__K2_1_3_4_5_6_7_8_9_10_11_16_17_18] ON [dbo].[r_part_reinpoints]
(
	[partID] ASC
)
INCLUDE([rpID],[posID],[x],[y],[z],[xd],[yd],[zd],[isMain],[isOk],[xa],[ya],[za]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_part_reinpoints_5_1166627199__K2_K1_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20] ON [dbo].[r_part_reinpoints]
(
	[partID] ASC,
	[rpID] ASC
)
INCLUDE([posID],[x],[y],[z],[xd],[yd],[zd],[isMain],[isOk],[xs],[ys],[zs],[isSketchOk],[xa],[ya],[za],[isCont],[onArc]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_partID]  DEFAULT ((0)) FOR [partID]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_posID]  DEFAULT ((0)) FOR [posID]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_x]  DEFAULT ((0)) FOR [x]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_y]  DEFAULT ((0)) FOR [y]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_z]  DEFAULT ((0)) FOR [z]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_xd]  DEFAULT ((0)) FOR [xd]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_yd]  DEFAULT ((0)) FOR [yd]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_zd]  DEFAULT ((0)) FOR [zd]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_isMain]  DEFAULT ((0)) FOR [isMain]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_2_isOk]  DEFAULT ((1)) FOR [isOk]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_xs]  DEFAULT ((0)) FOR [xs]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_ys]  DEFAULT ((0)) FOR [ys]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_zs]  DEFAULT ((0)) FOR [zs]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_isSketchOk]  DEFAULT ((0)) FOR [isSketchOk]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_xa]  DEFAULT ((0)) FOR [xa]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_ya]  DEFAULT ((0)) FOR [ya]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_za]  DEFAULT ((0)) FOR [za]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_isCont]  DEFAULT ((0)) FOR [isCont]
GO
ALTER TABLE [dbo].[r_part_reinpoints] ADD  CONSTRAINT [DF_r_part_reinpoints_onArc]  DEFAULT ((0)) FOR [onArc]
GO
