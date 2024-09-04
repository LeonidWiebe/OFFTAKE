SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_ObjectDimension](
	[simID] [bigint] NOT NULL,
	[dtID] [bigint] NULL,
	[UnitWidth] [varchar](50) NULL,
	[UnitHeight] [varchar](50) NULL,
	[UnitLenght] [varchar](50) NULL,
 CONSTRAINT [PK_i_ObjectDimensions] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
