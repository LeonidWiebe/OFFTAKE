SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[z_tmp_spaces](
	[pwdocID] [bigint] NOT NULL,
	[cnt] [bigint] NOT NULL,
	[prjname] [varchar](300) NOT NULL,
	[bldname] [varchar](300) NOT NULL,
	[filepath] [varchar](300) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
