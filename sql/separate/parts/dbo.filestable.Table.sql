SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[filestable](
	[fileID] [bigint] IDENTITY(1,1) NOT NULL,
	[fileFullPath] [varchar](300) NOT NULL,
	[catID] [bigint] NOT NULL,
	[fileSheetNum] [int] NOT NULL,
	[fileDescr] [varchar](300) NULL,
	[fileUse] [bit] NOT NULL,
 CONSTRAINT [PK_filestable] PRIMARY KEY CLUSTERED 
(
	[fileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[filestable] ADD  CONSTRAINT [DF_filestable_catID]  DEFAULT ((0)) FOR [catID]
GO
ALTER TABLE [dbo].[filestable] ADD  CONSTRAINT [DF_filestable_fileSheetNum]  DEFAULT ((0)) FOR [fileSheetNum]
GO
ALTER TABLE [dbo].[filestable] ADD  CONSTRAINT [DF_filestable_fileUse]  DEFAULT ((1)) FOR [fileUse]
GO
