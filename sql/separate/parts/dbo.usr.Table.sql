SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usr](
	[usrID] [bigint] IDENTITY(259,1) NOT NULL,
	[usrLogin] [varchar](50) NOT NULL,
	[usrFName] [varchar](50) NULL,
	[usrName] [varchar](50) NULL,
	[usrOName] [varchar](50) NULL,
	[projectID] [bigint] NULL,
	[groupID] [bigint] NULL,
	[depID] [bigint] NULL,
	[compName] [varchar](150) NULL,
	[usrPartFilter] [varchar](100) NULL,
	[usrCatalogID] [bigint] NULL,
	[usrTime] [datetime] NULL,
	[usrTrusted] [bit] NULL,
	[usedNative] [bit] NULL,
	[pdsID] [bigint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[usr] ADD  DEFAULT ((0)) FOR [usrTrusted]
GO
ALTER TABLE [dbo].[usr] ADD  CONSTRAINT [DF_usr_pdsID]  DEFAULT ((0)) FOR [pdsID]
GO
