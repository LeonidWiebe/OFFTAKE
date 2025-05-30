SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pw_folders](
	[fldID] [bigint] IDENTITY(1,1) NOT NULL,
	[fldName] [varchar](150) NOT NULL,
 CONSTRAINT [PK_pw_folders] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
