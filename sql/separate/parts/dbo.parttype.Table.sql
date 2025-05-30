SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[parttype](
	[typeID] [bigint] IDENTITY(38,1) NOT NULL,
	[typeName] [varchar](100) NULL,
	[specID] [bigint] NOT NULL,
	[sortID] [bigint] NOT NULL,
	[pdsID] [bigint] NOT NULL,
	[partsketch] [varchar](50) NULL,
 CONSTRAINT [PK_parttype] PRIMARY KEY CLUSTERED 
(
	[typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[parttype] ADD  DEFAULT ((1)) FOR [specID]
GO
ALTER TABLE [dbo].[parttype] ADD  CONSTRAINT [DF_parttype_sortID]  DEFAULT ((0)) FOR [sortID]
GO
ALTER TABLE [dbo].[parttype] ADD  CONSTRAINT [DF_parttype_pdsID]  DEFAULT ((0)) FOR [pdsID]
GO
