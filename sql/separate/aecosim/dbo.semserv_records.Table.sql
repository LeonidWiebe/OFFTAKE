SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[semserv_records](
	[recID] [bigint] IDENTITY(1,1) NOT NULL,
	[simID] [bigint] NOT NULL,
	[table_name] [varchar](150) NOT NULL,
	[prop_name] [varchar](150) NOT NULL,
	[prop_value] [varchar](250) NOT NULL,
	[dtID] [bigint] NOT NULL,
 CONSTRAINT [PK_semserv_records] PRIMARY KEY CLUSTERED 
(
	[recID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[semserv_records] ADD  CONSTRAINT [DF_semserv_records_simID]  DEFAULT ((0)) FOR [simID]
GO
ALTER TABLE [dbo].[semserv_records] ADD  CONSTRAINT [DF_semserv_records_dtID]  DEFAULT ((0)) FOR [dtID]
GO
