SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Penetration](
	[ID] [bigint] NOT NULL,
	[FlangeType] [numeric](18, 0) NULL,
	[DiametrType] [numeric](18, 0) NULL,
	[FlangeThick] [real] NULL,
	[FlangeWidth] [real] NULL,
	[PipeDiametr] [real] NULL,
	[PipeThick] [real] NULL,
 CONSTRAINT [PK_Penetration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
