SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_room_property](
	[relID] [bigint] IDENTITY(1,1) NOT NULL,
	[roomID] [bigint] NOT NULL,
	[rfirediv] [varchar](50) NULL,
	[rfirecomp] [varchar](50) NULL,
	[rfireload] [bigint] NULL,
	[rfirehaz] [bigint] NULL,
	[rradzone] [bigint] NULL,
	[rprotectlev] [bigint] NULL,
	[rfiredivres] [varchar](50) NULL,
	[rfirecompres] [varchar](50) NULL,
	[rfextnum] [bigint] NULL,
	[rfexttype] [bigint] NULL,
	[rfextmass] [real] NULL,
 CONSTRAINT [PK_r_room_property] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[r_room_property] ADD  CONSTRAINT [DF_r_room_property_roomID]  DEFAULT ((0)) FOR [roomID]
GO
