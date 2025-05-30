SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_StrainDT](
	[simID] [bigint] NOT NULL,
	[KKScode] [varchar](50) NULL,
	[NameEN] [varchar](150) NULL,
	[NameRU] [varchar](150) NULL,
	[SurfaceMeasurement] [varchar](50) NULL,
	[DirectionMeasurement] [varchar](50) NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_StrainDT] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[i_StrainDT] ADD  CONSTRAINT [DF_i_StrainDT_simID]  DEFAULT ((0)) FOR [simID]
GO
