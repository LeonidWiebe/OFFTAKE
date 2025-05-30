SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_Dimensions](
	[simID] [bigint] NOT NULL,
	[width] [varchar](50) NULL,
	[height] [varchar](50) NULL,
	[dtID] [bigint] NULL,
	[CWWidth] [varchar](50) NULL,
	[CWHeight] [varchar](50) NULL,
	[FrameDepth] [varchar](50) NULL,
	[FrameThickness] [varchar](50) NULL,
	[VertMullSpacing] [varchar](50) NULL,
	[HorzMullSpacing] [varchar](50) NULL,
	[MullionDepth] [varchar](50) NULL,
	[MullionThickness] [varchar](50) NULL,
	[RoughOpeningOffset] [varchar](50) NULL,
 CONSTRAINT [PK_i_Dimensions] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
