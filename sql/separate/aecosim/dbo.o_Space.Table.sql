SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[o_Space](
	[roomID] [bigint] IDENTITY(1,1) NOT NULL,
	[roomKKS] [varchar](50) NULL,
	[roomNameRus] [varchar](250) NULL,
	[roomNameEng] [varchar](250) NULL,
	[fcID] [bigint] NOT NULL,
	[simID_start] [bigint] NOT NULL,
	[simID_current] [bigint] NOT NULL,
 CONSTRAINT [PK_o_Space] PRIMARY KEY CLUSTERED 
(
	[roomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[o_Space] ADD  CONSTRAINT [DF_o_Space_fcID]  DEFAULT ((0)) FOR [fcID]
GO
ALTER TABLE [dbo].[o_Space] ADD  CONSTRAINT [DF_o_Space_simID_start]  DEFAULT ((0)) FOR [simID_start]
GO
ALTER TABLE [dbo].[o_Space] ADD  CONSTRAINT [DF_o_Space_simID_current]  DEFAULT ((0)) FOR [simID_current]
GO
