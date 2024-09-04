SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_ET-Route](
	[simID] [bigint] NOT NULL,
	[ETCode] [varchar](50) NULL,
	[NetWeight] [varchar](20) NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_ET-Route] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[i_ET-Route] ADD  CONSTRAINT [DF_i_ET-Route_simID]  DEFAULT ((0)) FOR [simID]
GO
