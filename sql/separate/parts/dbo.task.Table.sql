SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[task](
	[taskID] [bigint] IDENTITY(146,1) NOT NULL,
	[taskName] [varchar](250) NOT NULL,
	[buildingID] [bigint] NOT NULL,
	[taskType] [bigint] NULL,
	[usrLogin] [varchar](50) NOT NULL,
	[used] [bit] NOT NULL,
	[projectID] [bigint] NULL,
 CONSTRAINT [PK_task] PRIMARY KEY CLUSTERED 
(
	[taskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[task] ADD  DEFAULT ((0)) FOR [taskType]
GO
ALTER TABLE [dbo].[task] ADD  DEFAULT ((1)) FOR [used]
GO
