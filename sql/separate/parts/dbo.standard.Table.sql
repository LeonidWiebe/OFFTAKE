SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[standard](
	[stdID] [bigint] IDENTITY(131,1) NOT NULL,
	[stdNumber] [nvarchar](250) NULL,
	[stdName] [nvarchar](250) NULL,
	[stdTypeID] [bigint] NULL,
	[stdUsing] [bit] NOT NULL,
	[stdNumberAlt] [nvarchar](150) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [_dta_index_standard_5_722101613__K1_K4_K2_K6_3_5] ON [dbo].[standard]
(
	[stdID] ASC,
	[stdTypeID] ASC,
	[stdNumber] ASC,
	[stdNumberAlt] ASC
)
INCLUDE([stdName],[stdUsing]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[standard] ADD  DEFAULT ((1)) FOR [stdUsing]
GO
