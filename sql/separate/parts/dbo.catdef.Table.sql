SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[catdef](
	[catdefID] [bigint] IDENTITY(1,1) NOT NULL,
	[catdefName] [varchar](250) NOT NULL,
	[isDocSet] [bit] NOT NULL,
	[upLevel] [int] NOT NULL,
	[partdefID] [bigint] NOT NULL,
	[speedKey] [varchar](10) NULL,
	[simKey] [varchar](50) NULL,
 CONSTRAINT [PK_catdef] PRIMARY KEY CLUSTERED 
(
	[catdefID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[catdef] ADD  CONSTRAINT [DF_catdef_isDocSet]  DEFAULT ((0)) FOR [isDocSet]
GO
ALTER TABLE [dbo].[catdef] ADD  CONSTRAINT [DF_catdef_upLevel]  DEFAULT ((0)) FOR [upLevel]
GO
ALTER TABLE [dbo].[catdef] ADD  CONSTRAINT [DF_catdef_partdefID]  DEFAULT ((0)) FOR [partdefID]
GO
