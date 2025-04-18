SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_part_reinsketch](
	[sketchID] [bigint] IDENTITY(1,1) NOT NULL,
	[partID] [bigint] NOT NULL,
	[sketchStartType] [int] NOT NULL,
	[sketchStartAngle] [int] NOT NULL,
	[sketchStartLength] [int] NOT NULL,
	[sketchEndType] [int] NOT NULL,
	[sketchEndAngle] [int] NOT NULL,
	[sketchEndLength] [int] NOT NULL,
	[partNote] [varchar](250) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON
GO
CREATE CLUSTERED INDEX [_dta_index_r_part_reinsketch_c_5_1646628909__K2] ON [dbo].[r_part_reinsketch]
(
	[partID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[r_part_reinsketch] ADD  CONSTRAINT [DF_r_part_reinsketch_partID]  DEFAULT ((0)) FOR [partID]
GO
ALTER TABLE [dbo].[r_part_reinsketch] ADD  CONSTRAINT [DF_r_part_reinsketch_sketchStartType]  DEFAULT ((0)) FOR [sketchStartType]
GO
ALTER TABLE [dbo].[r_part_reinsketch] ADD  CONSTRAINT [DF_r_part_reinsketch_sketchStartAngle]  DEFAULT ((0)) FOR [sketchStartAngle]
GO
ALTER TABLE [dbo].[r_part_reinsketch] ADD  CONSTRAINT [DF_r_part_reinsketch_sketchStartLength]  DEFAULT ((0)) FOR [sketchStartLength]
GO
ALTER TABLE [dbo].[r_part_reinsketch] ADD  CONSTRAINT [DF_r_part_reinsketch_sketchEndType]  DEFAULT ((0)) FOR [sketchEndType]
GO
ALTER TABLE [dbo].[r_part_reinsketch] ADD  CONSTRAINT [DF_r_part_reinsketch_sketchEndAngle]  DEFAULT ((0)) FOR [sketchEndAngle]
GO
ALTER TABLE [dbo].[r_part_reinsketch] ADD  CONSTRAINT [DF_r_part_reinsketch_sketchEndLength]  DEFAULT ((0)) FOR [sketchEndLength]
GO
