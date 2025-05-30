SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[i_OfftakePosProp](
	[simID] [bigint] NOT NULL,
	[area] [real] NULL,
	[diameter] [real] NULL,
	[height] [real] NULL,
	[length] [real] NULL,
	[radius] [real] NULL,
	[radiusinn] [real] NULL,
	[radiusout] [real] NULL,
	[segment] [real] NULL,
	[thickness] [real] NULL,
	[width] [real] NULL,
	[diaminn] [real] NULL,
	[diamout] [real] NULL,
	[volume] [real] NULL,
	[lenmin] [real] NULL,
	[lenmax] [real] NULL,
	[lenmid] [real] NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_OfftakePosProp] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[i_OfftakePosProp] ADD  CONSTRAINT [DF_i_OfftakePosProp]  DEFAULT ((0)) FOR [simID]
GO
