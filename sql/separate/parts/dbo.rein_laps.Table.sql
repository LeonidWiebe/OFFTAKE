SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rein_laps](
	[lapID] [bigint] IDENTITY(1,1) NOT NULL,
	[projectID] [bigint] NOT NULL,
	[betonID] [bigint] NOT NULL,
	[armclassID] [bigint] NOT NULL,
	[diameter] [int] NOT NULL,
	[lapValue] [int] NOT NULL,
	[direction] [int] NOT NULL,
	[maxlen] [bigint] NOT NULL,
	[bend_work] [int] NOT NULL,
	[bend_free] [int] NOT NULL,
	[muft] [bigint] NOT NULL,
	[srtmID] [bigint] NOT NULL,
	[matID] [bigint] NOT NULL,
	[bendrad] [bigint] NOT NULL,
 CONSTRAINT [PK_rein_laps] PRIMARY KEY CLUSTERED 
(
	[lapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_projectID]  DEFAULT ((0)) FOR [projectID]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_betonID]  DEFAULT ((0)) FOR [betonID]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_armclassID]  DEFAULT ((0)) FOR [armclassID]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_diameter]  DEFAULT ((0)) FOR [diameter]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_lapValue]  DEFAULT ((0)) FOR [lapValue]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_direction]  DEFAULT ((0)) FOR [direction]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_maxlen]  DEFAULT ((11700)) FOR [maxlen]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_bend_work]  DEFAULT ((0)) FOR [bend_work]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_bend_free]  DEFAULT ((0)) FOR [bend_free]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_muft]  DEFAULT ((0)) FOR [muft]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_srtmID]  DEFAULT ((0)) FOR [srtmID]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_matID]  DEFAULT ((0)) FOR [matID]
GO
ALTER TABLE [dbo].[rein_laps] ADD  CONSTRAINT [DF_rein_laps_bendrad]  DEFAULT ((0)) FOR [bendrad]
GO
