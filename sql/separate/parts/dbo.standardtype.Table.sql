SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[standardtype](
	[stdTypeID] [bigint] IDENTITY(8,1) NOT NULL,
	[stdTypeName] [varchar](50) NOT NULL,
	[stdTypePosition] [int] NOT NULL,
	[stdTypeDevision] [varchar](50) NOT NULL,
	[stdTypeFromLeft] [bit] NOT NULL,
 CONSTRAINT [PK_StandardType] PRIMARY KEY CLUSTERED 
(
	[stdTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[standardtype] ADD  DEFAULT ((0)) FOR [stdTypePosition]
GO
ALTER TABLE [dbo].[standardtype] ADD  DEFAULT ('_') FOR [stdTypeDevision]
GO
ALTER TABLE [dbo].[standardtype] ADD  DEFAULT ((1)) FOR [stdTypeFromLeft]
GO
