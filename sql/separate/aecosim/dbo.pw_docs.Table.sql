SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pw_docs](
	[pwdocID] [bigint] NOT NULL,
	[serverID] [int] NOT NULL,
	[file_path] [varchar](500) NOT NULL,
	[deleted] [bit] NOT NULL,
	[bldID] [bigint] NOT NULL,
	[prjName] [varchar](50) NULL,
	[catID] [bigint] NOT NULL,
 CONSTRAINT [PK_pw_docs] PRIMARY KEY CLUSTERED 
(
	[pwdocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[pw_docs] ADD  CONSTRAINT [DF_pw_docs_pwdocID]  DEFAULT ((0)) FOR [pwdocID]
GO
ALTER TABLE [dbo].[pw_docs] ADD  CONSTRAINT [DF_pw_docs_serverID]  DEFAULT ((1)) FOR [serverID]
GO
ALTER TABLE [dbo].[pw_docs] ADD  CONSTRAINT [DF_pw_docs_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[pw_docs] ADD  CONSTRAINT [DF_pw_docs_bldID]  DEFAULT ((0)) FOR [bldID]
GO
ALTER TABLE [dbo].[pw_docs] ADD  CONSTRAINT [DF_pw_docs_catID]  DEFAULT ((0)) FOR [catID]
GO
