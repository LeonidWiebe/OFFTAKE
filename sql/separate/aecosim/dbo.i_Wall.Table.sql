SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_Wall](
	[simID] [bigint] NOT NULL,
	[Curved] [varchar](50) NULL,
	[Width] [bigint] NULL,
	[Height] [bigint] NULL,
	[Type] [varchar](50) NULL,
	[dtID] [bigint] NULL,
	[AreaLeftNet] [real] NULL,
	[AreaRightNet] [real] NULL,
	[AreaLeftGross] [real] NULL,
	[AreaRightGross] [real] NULL,
	[LengthCenter] [real] NULL,
 CONSTRAINT [PK_i_Wall3] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
