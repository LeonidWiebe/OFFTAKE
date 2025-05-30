SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[measureunit](
	[muID] [bigint] NOT NULL,
	[muName] [varchar](50) NULL,
	[muShortName] [varchar](50) NULL,
	[muSiK] [real] NOT NULL,
	[muParentID] [bigint] NULL,
	[muSpecName] [varchar](50) NULL,
 CONSTRAINT [PK_measureunit] PRIMARY KEY CLUSTERED 
(
	[muID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[measureunit] ADD  DEFAULT ((1)) FOR [muSiK]
GO
