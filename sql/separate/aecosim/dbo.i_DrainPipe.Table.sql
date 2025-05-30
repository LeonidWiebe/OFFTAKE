SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_DrainPipe](
	[simID] [bigint] NOT NULL,
	[dtID] [bigint] NULL,
	[Material] [varchar](255) NULL,
	[NominalDiameter] [nvarchar](50) NULL,
	[CircumferentialStiffness] [nvarchar](50) NULL,
	[Perforated] [nvarchar](10) NULL,
	[SafetyClass] [nvarchar](10) NULL,
	[SeismicCategory] [varchar](10) NULL,
 CONSTRAINT [PK_i_DrainPipe] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
