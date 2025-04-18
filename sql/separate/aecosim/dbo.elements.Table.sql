SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[elements](
	[simID] [bigint] IDENTITY(1,1) NOT NULL,
	[elemID] [bigint] NOT NULL,
	[pwdocID] [bigint] NOT NULL,
	[elemguid] [varchar](50) NOT NULL,
	[cattype] [varchar](200) NOT NULL,
	[catitem] [varchar](200) NOT NULL,
	[partdef] [varchar](200) NULL,
	[elemVolume] [real] NOT NULL,
	[isexternal] [bit] NOT NULL,
	[dtID] [bigint] NULL,
	[pCentX] [bigint] NOT NULL,
	[pCentY] [bigint] NOT NULL,
	[pCentZ] [bigint] NOT NULL,
	[pMinX] [bigint] NOT NULL,
	[pMinY] [bigint] NOT NULL,
	[pMinZ] [bigint] NOT NULL,
	[pMaxX] [bigint] NOT NULL,
	[pMaxY] [bigint] NOT NULL,
	[pMaxZ] [bigint] NOT NULL,
	[elemarea] [bigint] NOT NULL,
	[elemvertarea] [bigint] NOT NULL,
	[elemVolumeMan] [real] NULL,
	[elemareaMan] [real] NULL,
	[elemvertareaMan] [real] NULL,
	[uors] [bigint] NOT NULL,
	[elemOldID] [bigint] NULL,
	[bldID] [bigint] NOT NULL,
	[modID] [bigint] NOT NULL,
 CONSTRAINT [PK_elements] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [_dta_index_elements_13_759673754__K1_26] ON [dbo].[elements]
(
	[simID] ASC
)
INCLUDE([elemOldID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_elements_13_759673754__K27_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26] ON [dbo].[elements]
(
	[bldID] ASC
)
INCLUDE([simID],[elemID],[pwdocID],[elemguid],[cattype],[catitem],[partdef],[elemVolume],[isexternal],[dtID],[pCentX],[pCentY],[pCentZ],[pMinX],[pMinY],[pMinZ],[pMaxX],[pMaxY],[pMaxZ],[elemarea],[elemvertarea],[elemVolumeMan],[elemareaMan],[elemvertareaMan],[uors],[elemOldID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [_dta_index_elements_13_759673754__K27_K3_K5] ON [dbo].[elements]
(
	[bldID] ASC,
	[pwdocID] ASC,
	[cattype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_elements_13_759673754__K3_1_2_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27] ON [dbo].[elements]
(
	[pwdocID] ASC
)
INCLUDE([simID],[elemID],[elemguid],[cattype],[catitem],[partdef],[elemVolume],[isexternal],[dtID],[pCentX],[pCentY],[pCentZ],[pMinX],[pMinY],[pMinZ],[pMaxX],[pMaxY],[pMaxZ],[elemarea],[elemvertarea],[elemVolumeMan],[elemareaMan],[elemvertareaMan],[uors],[elemOldID],[bldID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [index1] ON [dbo].[elements]
(
	[elemID] ASC,
	[pwdocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [index4] ON [dbo].[elements]
(
	[pwdocID] ASC,
	[elemOldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_elemVolume]  DEFAULT ((0)) FOR [elemVolume]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_isext]  DEFAULT ((0)) FOR [isexternal]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_pCentX]  DEFAULT ((0)) FOR [pCentX]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_pCentY]  DEFAULT ((0)) FOR [pCentY]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_pCentZ]  DEFAULT ((0)) FOR [pCentZ]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_pMinX]  DEFAULT ((0)) FOR [pMinX]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_pMinY]  DEFAULT ((0)) FOR [pMinY]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_pMinZ]  DEFAULT ((0)) FOR [pMinZ]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_pMaxX]  DEFAULT ((0)) FOR [pMaxX]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_pMaxY]  DEFAULT ((0)) FOR [pMaxY]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_pMaxZ]  DEFAULT ((0)) FOR [pMaxZ]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_elemarea]  DEFAULT ((0)) FOR [elemarea]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_elemvertarea]  DEFAULT ((0)) FOR [elemvertarea]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_uors]  DEFAULT ((0)) FOR [uors]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_bldID]  DEFAULT ((0)) FOR [bldID]
GO
ALTER TABLE [dbo].[elements] ADD  CONSTRAINT [DF_elements_modID]  DEFAULT ((0)) FOR [modID]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[trig_elements_row_del]
   ON  [dbo].[elements]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @cattype varchar(200) = ''
	declare @pwdocID bigint = 0
	declare @simID bigint = 0
	declare @fcID bigint = 0
	declare @kks varchar(50) = ''
	
	select @simID = simID, @pwdocID = pwdocID, @cattype = cattype from deleted
	
	if @cattype = 'Space'
	begin
		select @kks = number, @fcID = fcID from dbo.i_Space where simID = @simID
		
		if @fcID > 0
		begin
			update dbo.i_Space set fcID = @fcID where number = @kks 
				--and simID in (select simID from elements where pwdocID = @pwdocID)
				
			insert into dbo.trigger_log_elements_spaces (kks, fcID) values (@kks, @fcID)
		end
	end
	
END
GO
ALTER TABLE [dbo].[elements] DISABLE TRIGGER [trig_elements_row_del]
GO
