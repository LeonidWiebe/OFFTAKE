SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_BackfillProperties](
	[simID] [bigint] NOT NULL,
	[BackfillMaterial] [varchar](50) NULL,
	[BackfillVolumeWeight] [varchar](50) NULL,
	[BackfillFractionOfAggregate] [varchar](50) NULL,
	[DesignWorkingLife] [varchar](50) NULL,
	[BuildingConsequencesClass] [varchar](50) NULL,
	[ReliabilityClass] [varchar](50) NULL,
	[SeismicClass] [varchar](50) NULL,
	[dtID] [bigint] NULL,
	[SafetyClass] [nvarchar](50) NULL,
 CONSTRAINT [PK_i_BackfillProperties] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
