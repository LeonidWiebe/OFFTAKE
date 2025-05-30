SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_PPTechnicalMeans](
	[simID] [bigint] NOT NULL,
	[Name] [varchar](25) NULL,
	[AccesID] [varchar](25) NULL,
	[PhysicalDetection] [varchar](25) NULL,
	[SecurityZone] [varchar](25) NULL,
	[Description] [varchar](25) NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_PPTechnicalMeans] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
