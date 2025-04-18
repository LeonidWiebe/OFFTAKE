SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_SteelProperties](
	[simID] [bigint] NOT NULL,
	[SM] [varchar](50) NULL,
	[SEC] [varchar](50) NULL,
	[SSC] [varchar](50) NULL,
	[SPC] [varchar](50) NULL,
	[SACC] [varchar](50) NULL,
	[SCS] [varchar](50) NULL,
	[SDC] [varchar](50) NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_SteelProperties] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
