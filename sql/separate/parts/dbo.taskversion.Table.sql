SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[taskversion](
	[versionID] [bigint] IDENTITY(219,1) NOT NULL,
	[versionDate] [varchar](50) NOT NULL,
	[taskID] [bigint] NOT NULL,
	[usrLogin] [varchar](50) NOT NULL,
	[filename] [varchar](300) NOT NULL,
	[used] [bit] NOT NULL,
 CONSTRAINT [PK_taskversion] PRIMARY KEY CLUSTERED 
(
	[versionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[taskversion] ADD  DEFAULT ((1)) FOR [used]
GO
