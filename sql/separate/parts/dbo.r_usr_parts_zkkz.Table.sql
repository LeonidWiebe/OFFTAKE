SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_usr_parts_zkkz](
	[zzID] [bigint] IDENTITY(1,1) NOT NULL,
	[usrID] [bigint] NOT NULL,
	[zzName] [varchar](50) NULL,
	[zzDiamMin] [real] NOT NULL,
	[zzDiamMax] [real] NOT NULL,
	[qty] [bigint] NOT NULL,
	[qtyRM] [real] NOT NULL,
 CONSTRAINT [PK_r_usr_parts_zkkz] PRIMARY KEY CLUSTERED 
(
	[zzID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[r_usr_parts_zkkz] ADD  CONSTRAINT [DF_r_usr_parts_zkkz_usrID]  DEFAULT ((0)) FOR [usrID]
GO
ALTER TABLE [dbo].[r_usr_parts_zkkz] ADD  CONSTRAINT [DF_r_usr_parts_zkkz_zzDiamMin]  DEFAULT ((0)) FOR [zzDiamMin]
GO
ALTER TABLE [dbo].[r_usr_parts_zkkz] ADD  CONSTRAINT [DF_r_usr_parts_zkkz_zzDiamMax]  DEFAULT ((0)) FOR [zzDiamMax]
GO
ALTER TABLE [dbo].[r_usr_parts_zkkz] ADD  CONSTRAINT [DF_r_usr_parts_zkkz_qty]  DEFAULT ((0)) FOR [qty]
GO
ALTER TABLE [dbo].[r_usr_parts_zkkz] ADD  CONSTRAINT [DF_r_usr_parts_zkkz_qtyRM]  DEFAULT ((0)) FOR [qtyRM]
GO
