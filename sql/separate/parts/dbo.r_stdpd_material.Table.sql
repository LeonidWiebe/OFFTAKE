SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_stdpd_material](
	[relID] [bigint] IDENTITY(1,1) NOT NULL,
	[stdpdID] [bigint] NOT NULL,
	[matID] [bigint] NOT NULL,
 CONSTRAINT [PK_r_stdpd_material] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
