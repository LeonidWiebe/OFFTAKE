SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_Stair_Common](
	[simID] [bigint] NOT NULL,
	[Width] [bigint] NULL,
	[FlightPartDef] [varchar](150) NULL,
	[StairPartDef] [varchar](150) NULL,
	[TreadPartDef] [varchar](150) NULL,
	[LandingPartDef] [varchar](150) NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_Stair_Common] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
