SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_usr_reinpoints](
	[upID] [bigint] IDENTITY(1,1) NOT NULL,
	[usrID] [bigint] NOT NULL,
	[xd] [real] NOT NULL,
	[yd] [real] NOT NULL,
	[zd] [real] NOT NULL,
	[isMain] [bit] NOT NULL,
	[isOk] [bit] NOT NULL,
	[xs] [real] NOT NULL,
	[ys] [real] NOT NULL,
	[zs] [real] NOT NULL,
	[isSketchOk] [bit] NOT NULL,
 CONSTRAINT [PK_r_usr_reinpoints] PRIMARY KEY CLUSTERED 
(
	[upID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_usrID]  DEFAULT ((0)) FOR [usrID]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_xd]  DEFAULT ((0)) FOR [xd]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_yd]  DEFAULT ((0)) FOR [yd]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_zd]  DEFAULT ((0)) FOR [zd]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_isMain]  DEFAULT ((0)) FOR [isMain]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_isOk]  DEFAULT ((1)) FOR [isOk]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_xs]  DEFAULT ((0)) FOR [xs]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_ys]  DEFAULT ((0)) FOR [ys]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_zs]  DEFAULT ((0)) FOR [zs]
GO
ALTER TABLE [dbo].[r_usr_reinpoints] ADD  CONSTRAINT [DF_r_usr_reinpoints_isSketchOk]  DEFAULT ((0)) FOR [isSketchOk]
GO
