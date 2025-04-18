SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_catpos_property](
	[relID] [bigint] IDENTITY(1,1) NOT NULL,
	[posID] [bigint] NOT NULL,
	[area] [real] NULL,
	[diameter] [real] NULL,
	[height] [real] NULL,
	[length] [real] NULL,
	[radius] [real] NULL,
	[radiusinn] [real] NULL,
	[radiusout] [real] NULL,
	[segment] [real] NULL,
	[thickness] [real] NULL,
	[width] [real] NULL,
	[diaminn] [real] NULL,
	[diamout] [real] NULL,
	[volume] [real] NULL,
	[lenmin] [real] NULL,
	[lenmax] [real] NULL,
	[lenmid] [real] NULL,
	[catdef] [bigint] NULL,
	[glevel] [int] NULL,
 CONSTRAINT [PK_r_catpos_property_1] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_catpos_property_5_1127675065__K2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20] ON [dbo].[r_catpos_property]
(
	[posID] ASC
)
INCLUDE([area],[diameter],[height],[length],[radius],[radiusinn],[radiusout],[segment],[thickness],[width],[diaminn],[diamout],[volume],[lenmin],[lenmax],[lenmid],[catdef],[glevel]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
