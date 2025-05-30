SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[i_ProfileQuantities](
	[simID] [bigint] NOT NULL,
	[PathLength] [float] NULL,
	[CrossSectionArea] [float] NULL,
	[NetVolume] [float] NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_ProfileQuantities] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
