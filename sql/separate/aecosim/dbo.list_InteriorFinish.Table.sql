SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[list_InteriorFinish](
	[lifID] [bigint] IDENTITY(1,1) NOT NULL,
	[lifCode] [varchar](50) NOT NULL,
	[lifName] [varchar](150) NULL,
	[lifDescr] [varchar](250) NULL,
	[lifFlowRate] [real] NOT NULL,
	[lifCalorific] [real] NOT NULL,
 CONSTRAINT [PK_list_InteriorFinish] PRIMARY KEY CLUSTERED 
(
	[lifID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[list_InteriorFinish] ADD  CONSTRAINT [DF_list_InteriorFinish_lifFlowRate]  DEFAULT ((0)) FOR [lifFlowRate]
GO
ALTER TABLE [dbo].[list_InteriorFinish] ADD  CONSTRAINT [DF_list_InteriorFinish_lifCalorific]  DEFAULT ((0)) FOR [lifCalorific]
GO
