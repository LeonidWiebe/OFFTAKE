SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_ConcreteExposure](
	[simID] [bigint] NOT NULL,
	[XC] [varchar](10) NULL,
	[XD] [varchar](10) NULL,
	[XS] [varchar](10) NULL,
	[XF] [varchar](10) NULL,
	[XA] [varchar](10) NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_ConcreteExposure] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[i_ConcreteExposure] ADD  CONSTRAINT [DF_i_ConcreteExposure_simID]  DEFAULT ((0)) FOR [simID]
GO
