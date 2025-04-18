SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pendiam](
	[pendiamID] [bigint] IDENTITY(93,1) NOT NULL,
	[flanNumber] [bigint] NULL,
	[diamNumber] [bigint] NULL,
	[srtmPipeID] [bigint] NULL,
	[flangeThickness] [float] NULL,
	[flangeWidth] [float] NULL,
	[flangeHeight] [float] NULL,
	[depID] [bigint] NOT NULL,
	[prjID] [bigint] NOT NULL,
	[flangeQty] [int] NOT NULL,
 CONSTRAINT [PK_pendiam] PRIMARY KEY CLUSTERED 
(
	[pendiamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[pendiam] ADD  CONSTRAINT [DF_pendiam_depID]  DEFAULT ((0)) FOR [depID]
GO
ALTER TABLE [dbo].[pendiam] ADD  CONSTRAINT [DF_pendiam_prjID]  DEFAULT ((0)) FOR [prjID]
GO
ALTER TABLE [dbo].[pendiam] ADD  CONSTRAINT [DF_pendiam_flangeQty]  DEFAULT ((0)) FOR [flangeQty]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE TRIGGER [dbo].[penSrtm] 
ON  [dbo].[pendiam] 
AFTER INSERT
   AS 

	--SQLWAYS_EVAL# added to prevent extra result sets from
	--SQLWAYS_EVAL# SELECT statements.
   SET NOCOUNT ON
   update pendiam set pendiam.srtmPipeID = 385+pendiam.diamNumber where pendiam.pendiamID =(select pendiamID from inserted)
    --SQLWAYS_EVAL# for trigger here








GO
ALTER TABLE [dbo].[pendiam] DISABLE TRIGGER [penSrtm]
GO
