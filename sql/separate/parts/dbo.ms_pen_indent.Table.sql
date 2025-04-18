SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ms_pen_indent](
	[indentID] [bigint] IDENTITY(8,1) NOT NULL,
	[indentWidth] [real] NOT NULL,
	[indentHeight] [real] NOT NULL,
	[indentDepth] [real] NOT NULL,
	[pendiamID] [bigint] NOT NULL,
 CONSTRAINT [PK_indent] PRIMARY KEY CLUSTERED 
(
	[indentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
