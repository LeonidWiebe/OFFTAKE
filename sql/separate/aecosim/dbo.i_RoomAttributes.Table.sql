SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_RoomAttributes](
	[simID] [bigint] NOT NULL,
	[AccessArea] [varchar](50) NULL,
	[dtID] [bigint] NULL,
	[RadiationZone] [varchar](50) NULL,
	[FinishingGroup] [nvarchar](10) NULL,
	[SafetyTrain] [nvarchar](10) NULL,
	[Speciality] [nvarchar](30) NULL,
	[FireLoadGroup] [nvarchar](5) NULL,
	[KKSFireZone] [nvarchar](50) NULL,
 CONSTRAINT [PK_i_RoomAttributes] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
