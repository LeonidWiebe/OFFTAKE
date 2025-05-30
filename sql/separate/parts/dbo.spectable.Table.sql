SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[spectable](
	[stID] [bigint] IDENTITY(1,1) NOT NULL,
	[objID] [bigint] NOT NULL,
	[objectID] [bigint] NOT NULL,
	[posNumber] [int] NOT NULL,
	[stQty] [real] NOT NULL,
	[stUmass] [real] NOT NULL,
	[stCMass] [real] NOT NULL,
	[stText] [varchar](150) NULL,
	[stRunMet] [bit] NOT NULL,
	[catlistID] [bigint] NOT NULL,
 CONSTRAINT [PK_spectable] PRIMARY KEY CLUSTERED 
(
	[stID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [_dta_index_spectable_5_1191675293__K10_K4_1_2_3_5_6_7_8_9] ON [dbo].[spectable]
(
	[catlistID] ASC,
	[posNumber] ASC
)
INCLUDE([stID],[objID],[objectID],[stQty],[stUmass],[stCMass],[stText],[stRunMet]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[spectable] ADD  CONSTRAINT [DF_spectable_objID]  DEFAULT ((0)) FOR [objID]
GO
ALTER TABLE [dbo].[spectable] ADD  CONSTRAINT [DF_spectable_objectID]  DEFAULT ((0)) FOR [objectID]
GO
ALTER TABLE [dbo].[spectable] ADD  CONSTRAINT [DF_spectable_posNumber]  DEFAULT ((0)) FOR [posNumber]
GO
ALTER TABLE [dbo].[spectable] ADD  CONSTRAINT [DF_spectable_stQty]  DEFAULT ((0)) FOR [stQty]
GO
ALTER TABLE [dbo].[spectable] ADD  CONSTRAINT [DF_spectable_stUmass]  DEFAULT ((0)) FOR [stUmass]
GO
ALTER TABLE [dbo].[spectable] ADD  CONSTRAINT [DF_spectable_stCMass]  DEFAULT ((0)) FOR [stCMass]
GO
ALTER TABLE [dbo].[spectable] ADD  CONSTRAINT [DF_spectable_stRunMet]  DEFAULT ((0)) FOR [stRunMet]
GO
ALTER TABLE [dbo].[spectable] ADD  CONSTRAINT [DF_spectable_catlistID]  DEFAULT ((0)) FOR [catlistID]
GO
