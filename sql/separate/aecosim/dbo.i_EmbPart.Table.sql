SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_EmbPart](
	[simID] [bigint] NOT NULL,
	[CatalogName] [varchar](50) NULL,
	[PartCode] [varchar](50) NULL,
	[NuclearSafetyClass] [varchar](50) NULL,
	[SeismicClass] [varchar](50) NULL,
	[DesignWorkingLife] [varchar](50) NULL,
	[ConsequencesClass] [varchar](50) NULL,
	[ExecutionClass] [varchar](50) NULL,
	[ProductionCategory] [varchar](50) NULL,
	[ServiceCategory] [varchar](50) NULL,
	[AtmCorrCategory] [varchar](50) NULL,
	[CoatingSystem] [varchar](50) NULL,
	[DurabilityCoating] [varchar](50) NULL,
	[Drawing] [varchar](150) NULL,
	[Supplier] [varchar](150) NULL,
	[dtID] [bigint] NULL,
	[ReliabilityClass] [nvarchar](50) NULL,
	[FireClass] [nvarchar](50) NULL,
	[Material] [nvarchar](50) NULL,
	[LoadBearing] [nvarchar](50) NULL,
	[Speciality] [varchar](50) NULL,
	[HighMark] [bigint] NULL,
	[PartIdentNumber] [bigint] NULL,
	[PartIdentCode] [varchar](150) NULL,
	[PartID] [bigint] NULL,
 CONSTRAINT [PK_i_EmbPart] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[i_EmbPart] ADD  CONSTRAINT [DF_i_EmbPart_simID]  DEFAULT ((0)) FOR [simID]
GO
