SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_pdset_parttype](
	[relID] [bigint] IDENTITY(1,1) NOT NULL,
	[ptID] [bigint] NOT NULL,
	[pdsID] [bigint] NOT NULL,
	[relNameAlt] [varchar](250) NULL,
 CONSTRAINT [PK_r_pdset_parttype] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
