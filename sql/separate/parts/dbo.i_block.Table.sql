SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_block](
	[blockID] [bigint] IDENTITY(25,1) NOT NULL,
	[blockNumber] [bigint] NOT NULL,
	[projectID] [bigint] NOT NULL,
	[deleted] [bit] NOT NULL,
	[pwPrjName] [varchar](50) NULL,
 CONSTRAINT [PK_block] PRIMARY KEY CLUSTERED 
(
	[blockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[i_block] ADD  DEFAULT ((0)) FOR [deleted]
GO
