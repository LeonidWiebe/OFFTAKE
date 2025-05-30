SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_rein_property](
	[relID] [bigint] IDENTITY(1,1) NOT NULL,
	[srtmID] [bigint] NOT NULL,
	[fillet_radius] [real] NULL,
	[fillet_length] [real] NULL,
	[rif_diameter] [real] NULL,
 CONSTRAINT [PK_r_rein_property] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
