SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[spec_config](
	[scID] [bigint] IDENTITY(1,1) NOT NULL,
	[scName] [varchar](50) NOT NULL,
	[scCapCell] [varchar](50) NOT NULL,
	[useDots] [bit] NOT NULL,
	[headHeight] [real] NOT NULL,
	[scListName] [varchar](50) NULL,
	[colWidths] [varchar](150) NULL,
	[useNewArmClass] [bit] NOT NULL,
	[useOldArmClass] [bit] NOT NULL,
	[txtHeight] [real] NOT NULL,
	[txtWidth] [real] NOT NULL,
	[txtScale] [real] NOT NULL,
	[useTranslation] [bit] NOT NULL,
	[scRunMet] [varchar](50) NULL,
	[rowHeights] [varchar](150) NULL,
	[newRowPartName] [bit] NOT NULL,
	[newRowPartDef] [bit] NOT NULL,
	[newRowMatStd] [bit] NOT NULL,
	[posdefIsText] [bit] NOT NULL,
	[posSignStd] [bit] NOT NULL,
	[lineWgtVert] [int] NOT NULL,
	[useMatScnd] [bit] NOT NULL,
	[strLenVar] [varchar](100) NULL,
	[txtFont] [int] NOT NULL,
	[lineWgtHor] [int] NOT NULL,
	[newRowMat] [bit] NOT NULL,
	[offtMatMask] [varchar](50) NULL,
	[prntID] [bigint] NOT NULL,
 CONSTRAINT [PK_spec_config] PRIMARY KEY CLUSTERED 
(
	[scID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_useDots]  DEFAULT ((0)) FOR [useDots]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_headWidth]  DEFAULT ((2500)) FOR [headHeight]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_useNewArmClass]  DEFAULT ((1)) FOR [useNewArmClass]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_useOldArmClass]  DEFAULT ((0)) FOR [useOldArmClass]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_txtHeight]  DEFAULT ((300)) FOR [txtHeight]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_txtWidth]  DEFAULT ((240)) FOR [txtWidth]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_txtScale]  DEFAULT ((1)) FOR [txtScale]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_useTranslation]  DEFAULT ((0)) FOR [useTranslation]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_newRowPartName]  DEFAULT ((1)) FOR [newRowPartName]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_newRowPartDef]  DEFAULT ((1)) FOR [newRowPartDef]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_newRowMatStd]  DEFAULT ((1)) FOR [newRowMatStd]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_posdefIsText]  DEFAULT ((0)) FOR [posdefIsText]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_posSignStd]  DEFAULT ((0)) FOR [posSignStd]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_lineWgtVert]  DEFAULT ((1)) FOR [lineWgtVert]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_useMatScnd]  DEFAULT ((0)) FOR [useMatScnd]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_txtFont]  DEFAULT ((226)) FOR [txtFont]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_lineWgtHor]  DEFAULT ((-1)) FOR [lineWgtHor]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_newRowMat]  DEFAULT ((1)) FOR [newRowMat]
GO
ALTER TABLE [dbo].[spec_config] ADD  CONSTRAINT [DF_spec_config_prntID]  DEFAULT ((0)) FOR [prntID]
GO
