SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ms_radial_section](
	[mslink] [bigint] IDENTITY(2,1) NOT NULL,
	[rsName] [varchar](250) NULL,
	[rsCenterX] [real] NULL,
	[rsCenterY] [real] NULL,
	[rsCenterZ] [real] NULL,
	[rsRadiusInner] [real] NULL,
	[rsRadiusOuter] [real] NULL,
	[rsRadiusDraw] [real] NULL,
	[rsHeight] [real] NULL,
	[rsStartAngle] [real] NULL,
	[rsSweepAngle] [real] NULL,
 CONSTRAINT [PK_ms_radial_section] PRIMARY KEY CLUSTERED 
(
	[mslink] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
