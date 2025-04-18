SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_catlist_part_history](
	[histID] [bigint] IDENTITY(1,1) NOT NULL,
	[relID] [bigint] NOT NULL,
	[catlistID] [bigint] NOT NULL,
	[partID] [bigint] NULL,
	[partQty] [real] NULL,
	[partSortID] [bigint] NULL,
	[objID] [bigint] NOT NULL,
	[oper] [bit] NOT NULL,
	[histDate] [datetime] NULL,
 CONSTRAINT [PK_r_catlist_part_history] PRIMARY KEY CLUSTERED 
(
	[histID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[r_catlist_part_history] ADD  DEFAULT (getdate()) FOR [histDate]
GO
