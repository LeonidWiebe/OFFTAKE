SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[docsetsign](
	[dssID] [bigint] IDENTITY(1,1) NOT NULL,
	[dssSymbol] [varchar](50) NOT NULL,
	[dssDataType] [bigint] NOT NULL,
	[dssChars] [int] NOT NULL,
	[dssTable] [varchar](150) NULL,
	[dssField] [varchar](50) NULL,
 CONSTRAINT [PK_docsetsign] PRIMARY KEY CLUSTERED 
(
	[dssID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[docsetsign] ADD  CONSTRAINT [DF_docsetsign_dssDataType]  DEFAULT ((0)) FOR [dssDataType]
GO
ALTER TABLE [dbo].[docsetsign] ADD  CONSTRAINT [DF_docsetsign_dssChars]  DEFAULT ((0)) FOR [dssChars]
GO
