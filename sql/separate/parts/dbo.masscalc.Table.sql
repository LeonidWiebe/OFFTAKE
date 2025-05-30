SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[masscalc](
	[mcID] [bigint] IDENTITY(9,1) NOT NULL,
	[mcName] [varchar](100) NULL,
	[calcID] [bigint] NULL,
	[mcDescription] [varchar](50) NULL,
	[mcTable] [varchar](50) NULL,
	[mcFormula] [varchar](50) NULL,
	[mcSign] [varchar](50) NULL,
	[specQty] [bit] NOT NULL,
	[specUMass] [bit] NOT NULL,
	[specCMass] [bit] NOT NULL,
 CONSTRAINT [PK_masscalc] PRIMARY KEY CLUSTERED 
(
	[mcID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[masscalc] ADD  CONSTRAINT [DF_masscalc_specQty]  DEFAULT ((1)) FOR [specQty]
GO
ALTER TABLE [dbo].[masscalc] ADD  CONSTRAINT [DF_masscalc_specUMass]  DEFAULT ((1)) FOR [specUMass]
GO
ALTER TABLE [dbo].[masscalc] ADD  CONSTRAINT [DF_masscalc_specCMass]  DEFAULT ((1)) FOR [specCMass]
GO
