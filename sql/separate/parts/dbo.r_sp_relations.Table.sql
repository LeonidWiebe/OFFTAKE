SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_sp_relations](
	[relID] [bigint] IDENTITY(1,1) NOT NULL,
	[spSrcID] [bigint] NOT NULL,
	[spDstID] [bigint] NOT NULL,
	[Priority] [bigint] NOT NULL,
 CONSTRAINT [PK_r_standards] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[r_sp_relations] ADD  CONSTRAINT [DF_r_standards_stdSrcID]  DEFAULT ((0)) FOR [spSrcID]
GO
ALTER TABLE [dbo].[r_sp_relations] ADD  CONSTRAINT [DF_r_standards_stdDstID]  DEFAULT ((0)) FOR [spDstID]
GO
ALTER TABLE [dbo].[r_sp_relations] ADD  CONSTRAINT [DF_r_standards_Priority]  DEFAULT ((0)) FOR [Priority]
GO
