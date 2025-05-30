SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_Reinforcement](
	[simID] [bigint] NOT NULL,
	[Diameter] [varchar](25) NULL,
	[ReinforcementClass] [varchar](25) NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_Reinforcement] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[i_Reinforcement] ADD  CONSTRAINT [DF_i_Reinforcement_simID]  DEFAULT ((0)) FOR [simID]
GO
