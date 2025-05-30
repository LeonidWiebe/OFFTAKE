SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[whatsnew](
	[wnID] [bigint] IDENTITY(1,1) NOT NULL,
	[wnDescr] [varchar](500) NULL,
	[wnDate] [datetime] NULL,
	[wnVers] [varchar](50) NULL,
	[wnMajor] [bigint] NOT NULL,
	[wnMinor] [bigint] NOT NULL,
	[wnRev] [bigint] NOT NULL,
 CONSTRAINT [PK_whatsnew] PRIMARY KEY CLUSTERED 
(
	[wnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[whatsnew] ADD  CONSTRAINT [DF_whatsnew_wnMajor]  DEFAULT ((2)) FOR [wnMajor]
GO
ALTER TABLE [dbo].[whatsnew] ADD  CONSTRAINT [DF_whatsnew_wnMinor]  DEFAULT ((0)) FOR [wnMinor]
GO
ALTER TABLE [dbo].[whatsnew] ADD  CONSTRAINT [DF_whatsnew_wnRev]  DEFAULT ((0)) FOR [wnRev]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE TRIGGER [dbo].[whatsnew_AfterInsTrig] 
ON  [dbo].[whatsnew] 
FOR INSERT
   AS 
   IF trigger_nestlevel() = 1
   update [whatsnew] set wnDate = CURRENT_TIMESTAMP where [whatsnew].wnID =(select wnID from inserted)



GO
ALTER TABLE [dbo].[whatsnew] ENABLE TRIGGER [whatsnew_AfterInsTrig]
GO
