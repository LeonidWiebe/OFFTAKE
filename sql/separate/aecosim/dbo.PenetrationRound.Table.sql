SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PenetrationRound](
	[ID] [bigint] NOT NULL,
	[FlangeType] [nchar](10) NULL,
	[DiametrType] [nchar](10) NULL,
	[FlangeThick] [nchar](10) NULL,
	[FlangeWidth] [nchar](10) NULL,
	[PipeDiametr] [nchar](10) NULL,
	[PipeThick] [nchar](10) NULL,
 CONSTRAINT [PK_PenetrationRound] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
