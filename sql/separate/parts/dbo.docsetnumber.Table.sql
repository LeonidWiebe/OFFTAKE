SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[docsetnumber](
	[nmbID] [bigint] IDENTITY(1,1) NOT NULL,
	[projectID] [bigint] NOT NULL,
	[dstID] [bigint] NOT NULL,
	[nmbMask] [varchar](250) NULL,
	[bldLeadSign] [int] NOT NULL,
	[nmbRegex] [varchar](250) NULL,
	[nmbCmnLen] [int] NULL,
	[nmbLevStart] [int] NULL,
	[nmbLevLen] [int] NULL,
	[nmbDigStart] [int] NULL,
	[nmbDigLen] [int] NULL,
	[nmbFieldName] [varchar](150) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[docsetnumber] ADD  CONSTRAINT [DF_docsetnumber_projectID]  DEFAULT ((0)) FOR [projectID]
GO
ALTER TABLE [dbo].[docsetnumber] ADD  CONSTRAINT [DF_docsetnumber_dstID]  DEFAULT ((0)) FOR [dstID]
GO
ALTER TABLE [dbo].[docsetnumber] ADD  CONSTRAINT [DF_docsetnumber_bldLeadSign]  DEFAULT ((0)) FOR [bldLeadSign]
GO
