SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pendiam2](
	[pendiamID] [bigint] IDENTITY(93,1) NOT NULL,
	[flanNumber] [varchar](1) NULL,
	[diamNumber] [bigint] NULL,
	[srtmPipeID] [bigint] NULL,
	[flangeThickness] [float] NULL,
	[flangeWidth] [float] NULL,
	[flangeHeight] [float] NULL,
	[depID] [bigint] NOT NULL,
	[prjID] [bigint] NOT NULL,
	[flangeQty] [int] NOT NULL,
 CONSTRAINT [PK_pendiam2] PRIMARY KEY CLUSTERED 
(
	[pendiamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
