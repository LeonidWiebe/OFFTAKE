SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[i_EmbLoadB](
	[simID] [bigint] NOT NULL,
	[Q] [real] NULL,
	[FX] [real] NULL,
	[FY] [real] NULL,
	[FZ] [real] NULL,
	[MX] [real] NULL,
	[MY] [real] NULL,
	[MZ] [real] NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_EmbLoadB] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[i_EmbLoadB] ADD  CONSTRAINT [DF_i_EmbLoadB_simID]  DEFAULT ((0)) FOR [simID]
GO
