SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[trigger_log_elements_spaces](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[kks] [varchar](50) NULL,
	[fcID] [bigint] NULL,
	[roomID] [bigint] NOT NULL,
 CONSTRAINT [PK_trigger_log_elements_spaces] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[trigger_log_elements_spaces] ADD  CONSTRAINT [DF_trigger_log_elements_spaces_roomID]  DEFAULT ((0)) FOR [roomID]
GO
