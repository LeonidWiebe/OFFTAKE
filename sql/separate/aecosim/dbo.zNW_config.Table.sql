SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[zNW_config](
	[ID] [varchar](50) NOT NULL,
	[Component] [varchar](50) NOT NULL,
	[table_view] [varchar](150) NOT NULL,
	[Project_name] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
