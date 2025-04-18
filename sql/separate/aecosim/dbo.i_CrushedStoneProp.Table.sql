SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_CrushedStoneProp](
	[simID] [bigint] NOT NULL,
	[dtID] [bigint] NULL,
	[VolumeWeight] [nvarchar](50) NULL,
	[FractionOfAggregate] [nvarchar](50) NULL,
	[DesignWorkingLife] [nvarchar](50) NULL,
	[SafetyClass] [nvarchar](10) NULL,
	[SeismicCategory] [varchar](10) NULL,
 CONSTRAINT [PK_i_CrushedStoneProp] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
