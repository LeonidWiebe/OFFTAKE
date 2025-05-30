SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[catlist](
	[catlistID] [bigint] IDENTITY(400,1) NOT NULL,
	[catID] [bigint] NOT NULL,
	[catlistName] [varchar](250) NOT NULL,
	[deleted] [bit] NOT NULL,
	[clIDold] [bigint] NOT NULL,
	[clPassive] [bit] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON
GO
CREATE CLUSTERED INDEX [_dta_index_catlist_c_5_21575115__K1_K2] ON [dbo].[catlist]
(
	[catlistID] ASC,
	[catID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_catlist_5_21575115__K4_K2_K1_3] ON [dbo].[catlist]
(
	[deleted] ASC,
	[catID] ASC,
	[catlistID] ASC
)
INCLUDE([catlistName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[catlist] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[catlist] ADD  CONSTRAINT [DF_catlist_clIDold]  DEFAULT ((0)) FOR [clIDold]
GO
ALTER TABLE [dbo].[catlist] ADD  CONSTRAINT [DF_catlist_clPassive]  DEFAULT ((0)) FOR [clPassive]
GO
