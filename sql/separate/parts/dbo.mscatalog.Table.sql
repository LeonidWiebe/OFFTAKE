SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mscatalog](
	[tablename] [nvarchar](32) NULL,
	[entitynum] [int] NOT NULL,
	[screenform] [nvarchar](64) NULL,
	[reporttable] [nvarchar](64) NULL,
	[sqlreview] [nvarchar](240) NULL,
	[fencefilter] [nvarchar](240) NULL,
	[dastable] [nvarchar](32) NULL,
	[formtable] [nvarchar](64) NULL
) ON [PRIMARY]
GO
