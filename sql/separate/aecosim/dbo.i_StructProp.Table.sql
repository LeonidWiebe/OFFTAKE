SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_StructProp](
	[simID] [bigint] NOT NULL,
	[StructNumber] [varchar](50) NULL,
	[StructCode] [varchar](50) NULL,
	[ShortCode] [varchar](50) NULL,
	[FC] [varchar](50) NULL,
	[DWL] [varchar](50) NULL,
	[BCC] [varchar](50) NULL,
	[SRC] [varchar](50) NULL,
	[SC] [varchar](50) NULL,
	[NSC] [varchar](50) NULL,
	[dtID] [bigint] NULL,
	[Firewall] [nvarchar](50) NULL,
	[ExecutionClass] [nvarchar](50) NULL,
	[AtmosphericCorrosivityCategory] [nvarchar](50) NULL,
	[DurabilityofCoating] [nvarchar](50) NULL,
 CONSTRAINT [PK_i_StructProp] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
