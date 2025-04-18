SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_department_project](
	[relID] [bigint] IDENTITY(15,1) NOT NULL,
	[depID] [bigint] NOT NULL,
	[projectID] [bigint] NOT NULL,
	[projectPath] [varchar](250) NULL,
	[readOnly] [bit] NOT NULL,
	[useMassDop] [bit] NOT NULL,
 CONSTRAINT [PK_r_department_project] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[r_department_project] ADD  CONSTRAINT [DF_r_department_project_readOnly]  DEFAULT ((0)) FOR [readOnly]
GO
ALTER TABLE [dbo].[r_department_project] ADD  CONSTRAINT [DF_r_department_project_useMassDop]  DEFAULT ((0)) FOR [useMassDop]
GO
