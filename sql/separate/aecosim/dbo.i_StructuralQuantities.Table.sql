SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_StructuralQuantities](
	[simID] [bigint] NOT NULL,
	[Length] [varchar](50) NULL,
	[AreaCrossSection] [varchar](50) NULL,
	[VolumeNet] [varchar](50) NULL,
	[dtID] [bigint] NULL,
	[AreaCrossSectionModeled] [nvarchar](50) NULL,
 CONSTRAINT [PK_i_StructuralQuantities] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
