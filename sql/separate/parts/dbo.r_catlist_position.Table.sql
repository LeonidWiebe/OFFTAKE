SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_catlist_position](
	[relID] [bigint] IDENTITY(1,1) NOT NULL,
	[clpID] [bigint] NOT NULL,
	[catlistID] [bigint] NULL,
	[partID] [bigint] NULL,
	[posNumber] [bigint] NULL,
	[posQty] [real] NULL,
	[objID] [bigint] NOT NULL,
	[koef] [real] NOT NULL,
 CONSTRAINT [PK_r_catlist_position] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[r_catlist_position] ADD  CONSTRAINT [DF_r_catlist_position_objID]  DEFAULT ((2)) FOR [objID]
GO
ALTER TABLE [dbo].[r_catlist_position] ADD  CONSTRAINT [DF_r_catlist_position_koef]  DEFAULT ((1)) FOR [koef]
GO
