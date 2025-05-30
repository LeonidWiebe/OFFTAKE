SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[posdef](
	[posdefID] [bigint] IDENTITY(19,1) NOT NULL,
	[posdefName] [varchar](150) NOT NULL,
	[posdefNameMulti] [varchar](150) NULL,
	[massCommon] [bit] NOT NULL,
	[sortNumber] [bigint] NOT NULL,
	[posdefDrawSign] [varchar](50) NULL,
	[posdefDrawName] [bit] NOT NULL,
	[posdefDrawSymbol] [varchar](50) NULL,
	[posdefDrawSrtmPrefix] [varchar](50) NULL,
	[posdefNumber] [bigint] NULL,
	[posdefSP] [varchar](50) NULL,
	[masscalcID] [bigint] NOT NULL,
	[posdefUsing] [bit] NOT NULL,
	[posdefDefaultQty] [real] NOT NULL,
	[calcID] [bigint] NOT NULL,
	[posdefIDGlobal] [bigint] NULL,
	[objID] [bigint] NULL,
	[isDraw3D] [bit] NOT NULL,
	[isRein] [bit] NOT NULL,
	[massLevel] [int] NOT NULL,
	[posNum] [bit] NOT NULL,
	[pdIDtoCalc] [bigint] NOT NULL,
	[specSign] [bit] NOT NULL,
	[usedByCatPos] [bit] NOT NULL,
	[comment] [varchar](250) NULL,
	[inclCmnMass] [bit] NOT NULL,
 CONSTRAINT [PK_posdef] PRIMARY KEY CLUSTERED 
(
	[posdefID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[posdef] ADD  DEFAULT ((0)) FOR [massCommon]
GO
ALTER TABLE [dbo].[posdef] ADD  DEFAULT ((0)) FOR [sortNumber]
GO
ALTER TABLE [dbo].[posdef] ADD  DEFAULT ((0)) FOR [posdefDrawName]
GO
ALTER TABLE [dbo].[posdef] ADD  DEFAULT ((0)) FOR [posdefNumber]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF_posdef_masscalcID]  DEFAULT ((1)) FOR [masscalcID]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF__posdef__posdefUs__6383C8BA]  DEFAULT ((0)) FOR [posdefUsing]
GO
ALTER TABLE [dbo].[posdef] ADD  DEFAULT ((1.0)) FOR [posdefDefaultQty]
GO
ALTER TABLE [dbo].[posdef] ADD  DEFAULT ((0)) FOR [calcID]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF_posdef_isDraw3D]  DEFAULT ((0)) FOR [isDraw3D]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF_posdef_isRein]  DEFAULT ((0)) FOR [isRein]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF_posdef_massLevel]  DEFAULT ((0)) FOR [massLevel]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF_posdef_posNum]  DEFAULT ((1)) FOR [posNum]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF_posdef_pdIDtoCalc]  DEFAULT ((0)) FOR [pdIDtoCalc]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF_posdef_specSign]  DEFAULT ((0)) FOR [specSign]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF_posdef_usedByCatPos]  DEFAULT ((0)) FOR [usedByCatPos]
GO
ALTER TABLE [dbo].[posdef] ADD  CONSTRAINT [DF_posdef_inclCmnMass]  DEFAULT ((1)) FOR [inclCmnMass]
GO
