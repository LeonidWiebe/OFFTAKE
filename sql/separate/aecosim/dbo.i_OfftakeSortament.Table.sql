SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[i_OfftakeSortament](
	[simID] [bigint] NOT NULL,
	[srtmID] [bigint] NULL,
	[stdpdID] [bigint] NULL,
	[matID] [bigint] NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_OfftakeSortament] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[i_OfftakeSortament] ADD  CONSTRAINT [DF_i_OfftakeSortament_simID]  DEFAULT ((0)) FOR [simID]
GO
