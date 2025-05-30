SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[r_usr_rein](
	[relID] [bigint] IDENTITY(33,1) NOT NULL,
	[usrID] [bigint] NULL,
	[posdefID] [bigint] NULL,
	[stdID] [bigint] NULL,
	[matID] [bigint] NULL,
	[srtmID] [bigint] NULL,
 CONSTRAINT [PK_r_usr_rein] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
