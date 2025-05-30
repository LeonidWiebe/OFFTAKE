SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_DoorProperties](
	[simID] [bigint] NOT NULL,
	[KKS] [varchar](50) NULL,
	[dtID] [bigint] NULL,
	[FireResistance] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[DoorConstruction] [nvarchar](50) NULL,
	[OpeningCode] [nvarchar](50) NULL,
	[KKS_Room1] [varchar](50) NULL,
	[KKS_Room2] [varchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[Tightness] [nvarchar](50) NULL,
	[RemoteControl] [nvarchar](50) NULL,
	[Lock] [nvarchar](50) NULL,
	[ShockWave] [nvarchar](50) NULL,
	[SafetyClass] [nvarchar](50) NULL,
	[SeismicClass] [nvarchar](50) NULL,
	[OtherFunctions] [nvarchar](50) NULL,
	[Locks] [nvarchar](50) NULL,
	[Opening] [nvarchar](50) NULL,
	[DimensionType] [nvarchar](50) NULL,
	[Door_leaf_type] [nvarchar](50) NULL,
	[Material] [nvarchar](50) NULL,
	[SmokeTightness] [nvarchar](50) NULL,
	[DoorOpeningType] [nvarchar](50) NULL,
	[Mass_of_unit] [nvarchar](50) NULL,
	[DoorType] [nvarchar](50) NULL,
	[ElectricalDrive] [nvarchar](50) NULL,
 CONSTRAINT [PK_i_DoorProperties] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
