SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ms_pen_type](
	[ptID] [bigint] IDENTITY(8,1) NOT NULL,
	[ptName] [varchar](50) NULL,
	[ptDescription] [varchar](250) NULL,
	[ptIdentifier] [varchar](1) NULL,
	[ptSeparator] [varchar](1) NULL,
	[ptParameters] [varchar](250) NULL,
	[ptIsCell] [bit] NULL,
 CONSTRAINT [PK_ms_pentype] PRIMARY KEY CLUSTERED 
(
	[ptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
