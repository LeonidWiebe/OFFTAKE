SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_SealAttributes](
	[simID] [bigint] NOT NULL,
	[dtID] [bigint] NULL,
	[WaterTight] [varchar](25) NULL,
	[AirTight] [varchar](25) NULL,
	[RadiationProtect] [varchar](25) NULL,
	[SealFireResistance] [varchar](25) NULL,
 CONSTRAINT [PK_i_SealAttributes] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[i_SealAttributes] ADD  CONSTRAINT [DF_i_SealAttributes_simID]  DEFAULT ((0)) FOR [simID]
GO
