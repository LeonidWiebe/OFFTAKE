SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[i_rule](
	[ruleID] [bigint] IDENTITY(23,1) NOT NULL,
	[objID] [bigint] NULL,
	[groupID] [bigint] NULL,
	[ruleCreate] [bit] NULL,
	[ruleDelete] [bit] NULL,
	[ruleModify] [bit] NULL,
	[ruleMove] [bit] NULL,
 CONSTRAINT [PK_rule] PRIMARY KEY CLUSTERED 
(
	[ruleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[i_rule] ADD  DEFAULT ((0)) FOR [ruleCreate]
GO
ALTER TABLE [dbo].[i_rule] ADD  DEFAULT ((0)) FOR [ruleDelete]
GO
ALTER TABLE [dbo].[i_rule] ADD  DEFAULT ((0)) FOR [ruleModify]
GO
ALTER TABLE [dbo].[i_rule] ADD  DEFAULT ((0)) FOR [ruleMove]
GO
