SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_Electrical](
	[simID] [bigint] NOT NULL,
	[WIDTH] [real] NULL,
	[TRADE_WIDTH] [real] NULL,
	[HEIGHT] [real] NULL,
	[TRADE_HEIGHT] [real] NULL,
	[LENGTH] [real] NULL,
	[DESCRIPTION] [varchar](250) NULL,
	[MANUFACTURER] [varchar](150) NULL,
	[NuclearSafetyClass] [varchar](50) NULL,
	[SeismicClass] [varchar](50) NULL,
	[Train] [varchar](50) NULL,
	[DesignWorkingLife] [varchar](50) NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_i_Electrical] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
