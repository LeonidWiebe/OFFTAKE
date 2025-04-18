SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_standard_posdef](
	[relID] [bigint] IDENTITY(123,1) NOT NULL,
	[stdID] [bigint] NOT NULL,
	[posdefID] [bigint] NOT NULL,
	[mcID] [bigint] NULL,
	[using] [bit] NOT NULL,
	[useDrawSign] [bit] NOT NULL,
	[pdNameAlt] [varchar](250) NULL,
	[massLevel] [int] NULL,
 CONSTRAINT [PK_r_standard_posdef] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [posdefID] ON [dbo].[r_standard_posdef]
(
	[posdefID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [stdID] ON [dbo].[r_standard_posdef]
(
	[stdID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[r_standard_posdef] ADD  CONSTRAINT [DF_r_standard_posdef_using]  DEFAULT ((1)) FOR [using]
GO
ALTER TABLE [dbo].[r_standard_posdef] ADD  CONSTRAINT [DF_r_standard_posdef_useDrawSign]  DEFAULT ((1)) FOR [useDrawSign]
GO
