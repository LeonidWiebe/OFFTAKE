SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[property](
	[propID] [bigint] IDENTITY(33,1) NOT NULL,
	[propName] [varchar](100) NULL,
	[propDescr] [varchar](200) NULL,
	[propValue] [bigint] NULL,
	[muID] [bigint] NOT NULL,
	[propK_deleted] [real] NOT NULL,
	[propDefValue] [varchar](50) NULL,
	[propSign] [varchar](50) NULL,
	[muIDsrtm] [bigint] NULL,
	[tableName] [varchar](50) NULL,
	[using] [bit] NOT NULL,
	[objID] [bigint] NOT NULL,
 CONSTRAINT [PK_property] PRIMARY KEY CLUSTERED 
(
	[propID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[property] ADD  DEFAULT ((0)) FOR [muID]
GO
ALTER TABLE [dbo].[property] ADD  DEFAULT ((1)) FOR [propK_deleted]
GO
ALTER TABLE [dbo].[property] ADD  DEFAULT ((0)) FOR [propDefValue]
GO
ALTER TABLE [dbo].[property] ADD  CONSTRAINT [DF_property_using]  DEFAULT ((1)) FOR [using]
GO
ALTER TABLE [dbo].[property] ADD  CONSTRAINT [DF_property_objID]  DEFAULT ((2)) FOR [objID]
GO
