SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[catpos](
	[posID] [bigint] IDENTITY(1,1) NOT NULL,
	[partID] [bigint] NULL,
	[srtmID] [bigint] NOT NULL,
	[muID] [bigint] NULL,
	[posQuantity] [real] NULL,
	[matID] [bigint] NULL,
	[posUnitMass] [real] NULL,
	[posCommonMass] [real] NULL,
	[mcID] [bigint] NULL,
	[numDigits] [int] NOT NULL,
	[posNumber] [real] NOT NULL,
	[posUMCalc] [bit] NOT NULL,
	[posCMCalc] [bit] NOT NULL,
	[posSketch] [bit] NOT NULL,
	[posBarLength] [bigint] NOT NULL,
	[posIDold] [bigint] NOT NULL,
 CONSTRAINT [PK_catpos] PRIMARY KEY CLUSTERED 
(
	[posID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_catpos_5_919674324__K2_K1_K3_K11_4_5_6_7_8_9_10_12_13_14_15] ON [dbo].[catpos]
(
	[partID] ASC,
	[posID] ASC,
	[srtmID] ASC,
	[posNumber] ASC
)
INCLUDE([muID],[posQuantity],[matID],[posUnitMass],[posCommonMass],[mcID],[numDigits],[posUMCalc],[posCMCalc],[posSketch],[posBarLength]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[catpos] ADD  DEFAULT ((1)) FOR [muID]
GO
ALTER TABLE [dbo].[catpos] ADD  DEFAULT ((0)) FOR [posQuantity]
GO
ALTER TABLE [dbo].[catpos] ADD  DEFAULT ((0)) FOR [posUnitMass]
GO
ALTER TABLE [dbo].[catpos] ADD  DEFAULT ((0)) FOR [posCommonMass]
GO
ALTER TABLE [dbo].[catpos] ADD  DEFAULT ((0)) FOR [mcID]
GO
ALTER TABLE [dbo].[catpos] ADD  DEFAULT ((1)) FOR [numDigits]
GO
ALTER TABLE [dbo].[catpos] ADD  DEFAULT ((0)) FOR [posNumber]
GO
ALTER TABLE [dbo].[catpos] ADD  DEFAULT ((1)) FOR [posUMCalc]
GO
ALTER TABLE [dbo].[catpos] ADD  DEFAULT ((1)) FOR [posCMCalc]
GO
ALTER TABLE [dbo].[catpos] ADD  CONSTRAINT [DF_catpos_posSketch]  DEFAULT ((1)) FOR [posSketch]
GO
ALTER TABLE [dbo].[catpos] ADD  CONSTRAINT [DF_catpos_posBarLength]  DEFAULT ((0)) FOR [posBarLength]
GO
ALTER TABLE [dbo].[catpos] ADD  CONSTRAINT [DF_catpos_posIDold]  DEFAULT ((0)) FOR [posIDold]
GO
