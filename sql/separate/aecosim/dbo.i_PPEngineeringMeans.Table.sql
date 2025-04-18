SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_PPEngineeringMeans](
	[simID] [bigint] NOT NULL,
	[Name] [varchar](25) NULL,
	[KKS] [varchar](25) NULL,
	[BalancedMagneticSwitch] [varchar](25) NULL,
	[LockType] [varchar](25) NULL,
	[PresenceCloser] [varchar](25) NULL,
	[DelayClass] [varchar](25) NULL,
	[Description] [varchar](25) NULL,
	[SecurityZone] [varchar](25) NULL,
	[Fire_resist] [varchar](25) NULL,
	[Prototype] [varchar](25) NULL,
	[Number] [varchar](25) NULL,
	[Supply] [varchar](25) NULL,
	[Temperature_max] [varchar](25) NULL,
	[Temperature_min] [varchar](25) NULL,
	[Note] [varchar](25) NULL,
	[Power_system] [varchar](25) NULL,
	[Material] [varchar](25) NULL,
	[IP] [varchar](25) NULL,
	[Power_train] [varchar](25) NULL,
	[KKS_room] [varchar](25) NULL,
	[Power_group] [varchar](25) NULL,
	[KKS_building] [varchar](25) NULL,
	[Functional_safety_class] [varchar](25) NULL,
	[Structural_safety_class] [varchar](25) NULL,
	[Measurement] [varchar](25) NULL,
	[Opening_type] [varchar](25) NULL,
	[Opening_size] [varchar](25) NULL,
	[Safety_class] [varchar](25) NULL,
	[Seismic] [varchar](25) NULL,
	[Quality] [varchar](25) NULL,
	[Net_weight] [varchar](25) NULL,
	[Code_document] [varchar](25) NULL,
	[Detection] [varchar](25) NULL,
	[Max_eff_range] [varchar](25) NULL,
	[Comp_mount_meth] [varchar](25) NULL,
	[Voltage] [varchar](25) NULL,
	[Consumed_power] [varchar](25) NULL,
	[Ph_detection] [varchar](25) NULL,
	[AccesID] [varchar](25) NULL,
	[Height] [varchar](25) NULL,
	[dtID] [bigint] NULL,
 CONSTRAINT [PK_i_PPEngineeringMeans] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
