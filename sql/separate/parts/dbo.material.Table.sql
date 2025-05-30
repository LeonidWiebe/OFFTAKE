SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[material](
	[matID] [bigint] IDENTITY(32,1) NOT NULL,
	[stdID] [bigint] NULL,
	[matName] [varchar](250) NULL,
	[armclassID] [bigint] NULL,
	[matUsing] [bit] NOT NULL,
	[matSortNumber] [bigint] NOT NULL,
	[matScndID] [bigint] NOT NULL,
	[matMassCorrect] [real] NULL,
 CONSTRAINT [PK_Material] PRIMARY KEY CLUSTERED 
(
	[matID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[material] ADD  DEFAULT ((1)) FOR [matUsing]
GO
ALTER TABLE [dbo].[material] ADD  DEFAULT ((0)) FOR [matSortNumber]
GO
ALTER TABLE [dbo].[material] ADD  CONSTRAINT [DF_material_matScndID]  DEFAULT ((0)) FOR [matScndID]
GO
