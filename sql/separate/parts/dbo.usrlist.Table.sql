SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usrlist](
	[usrlistID] [bigint] IDENTITY(51814,1) NOT NULL,
	[usrID] [bigint] NOT NULL,
	[partID] [bigint] NULL,
	[posID] [bigint] NULL,
	[partQty] [real] NULL,
	[partSortID] [bigint] NULL,
	[objID] [bigint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[usrlist] ADD  CONSTRAINT [DF_usrlist_objID]  DEFAULT ((1)) FOR [objID]
GO
