SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_Layers](
	[simID] [bigint] NOT NULL,
	[dtID] [bigint] NULL,
	[L1] [varchar](250) NULL,
	[T1] [varchar](20) NULL,
	[L2] [varchar](250) NULL,
	[T2] [varchar](20) NULL,
	[L3] [varchar](250) NULL,
	[T3] [varchar](20) NULL,
	[L4] [varchar](250) NULL,
	[T4] [varchar](20) NULL,
	[L5] [varchar](250) NULL,
	[T5] [varchar](20) NULL,
	[L6] [varchar](250) NULL,
	[T6] [varchar](20) NULL,
	[L7] [varchar](250) NULL,
	[T7] [varchar](20) NULL,
	[L8] [varchar](250) NULL,
	[T8] [nvarchar](20) NULL,
	[L9] [varchar](250) NULL,
	[T9] [varchar](20) NULL,
	[L10] [varchar](250) NULL,
	[T10] [varchar](20) NULL,
	[L11] [varchar](250) NULL,
	[T11] [varchar](20) NULL,
	[L12] [varchar](250) NULL,
	[T12] [varchar](20) NULL,
 CONSTRAINT [PK_i_Layers] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
