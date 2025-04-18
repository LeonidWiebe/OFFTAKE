SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_project](
	[projectID] [bigint] IDENTITY(36,1) NOT NULL,
	[projectName] [varchar](50) NOT NULL,
	[projectPath] [varchar](300) NULL,
	[deleted] [bit] NOT NULL,
	[typeID] [bigint] NULL,
	[projectCode] [varchar](50) NULL,
	[specID] [bigint] NOT NULL,
	[useRienFillet] [int] NOT NULL,
	[useMassDop] [bit] NOT NULL,
	[useStdNumberAlt] [bit] NOT NULL,
	[projectDSTable] [varchar](50) NULL,
 CONSTRAINT [PK_project] PRIMARY KEY CLUSTERED 
(
	[projectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[i_project] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[i_project] ADD  CONSTRAINT [DF_i_project_specID]  DEFAULT ((0)) FOR [specID]
GO
ALTER TABLE [dbo].[i_project] ADD  CONSTRAINT [DF_i_project_useRienFillet]  DEFAULT ((0)) FOR [useRienFillet]
GO
ALTER TABLE [dbo].[i_project] ADD  CONSTRAINT [DF_i_project_useMassDop]  DEFAULT ((0)) FOR [useMassDop]
GO
ALTER TABLE [dbo].[i_project] ADD  CONSTRAINT [DF_i_project_useStdNumberAlt]  DEFAULT ((0)) FOR [useStdNumberAlt]
GO
