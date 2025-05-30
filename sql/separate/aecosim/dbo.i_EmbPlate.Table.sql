SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[i_EmbPlate](
	[simID] [bigint] NOT NULL,
	[Width] [real] NULL,
	[Thickness] [real] NULL,
	[dtID] [bigint] NULL,
	[Length] [real] NULL,
	[AnchorQuantity] [int] NULL,
 CONSTRAINT [PK_i_EmbPlate] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[i_EmbPlate] ADD  CONSTRAINT [DF_i_EmbPlate_simID]  DEFAULT ((0)) FOR [simID]
GO
