SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_ReinConcreteProperties](
	[simID] [bigint] NOT NULL,
	[C] [varchar](50) NULL,
	[G] [varchar](50) NULL,
	[D] [varchar](50) NULL,
	[FR] [varchar](50) NULL,
	[FCC] [varchar](50) NULL,
	[EC] [varchar](50) NULL,
	[RC] [varchar](50) NULL,
	[dtID] [bigint] NULL,
	[Class] [nvarchar](50) NULL,
	[F] [nvarchar](50) NULL,
	[W] [nvarchar](50) NULL,
	[DWL] [nvarchar](50) NULL,
 CONSTRAINT [PK_i_ReinConcreteProperties] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
