SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[i_building_pw](
	[bldID] [bigint] IDENTITY(1001,1) NOT NULL,
	[buildingID] [bigint] NOT NULL,
	[objectID] [bigint] NOT NULL,
	[objID] [bigint] NOT NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_i_building_pw] PRIMARY KEY CLUSTERED 
(
	[bldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[i_building_pw] ADD  DEFAULT ((0)) FOR [deleted]
GO
