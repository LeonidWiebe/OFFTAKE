SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[part](
	[partID] [bigint] IDENTITY(25025,1) NOT NULL,
	[partName] [varchar](50) NULL,
	[parentID] [bigint] NOT NULL,
	[catID] [bigint] NOT NULL,
	[partdefID] [bigint] NULL,
	[typeID] [bigint] NULL,
	[deleted] [bit] NOT NULL,
	[partDescr] [varchar](250) NULL,
	[partVersion] [varchar](50) NULL,
	[partIDold] [bigint] NOT NULL,
	[catIDold] [bigint] NOT NULL,
	[partSheet] [varchar](50) NULL,
	[partSortNumber] [varchar](250) NULL,
	[partMass] [real] NOT NULL,
	[partMainPosEP] [int] NOT NULL,
	[partStatusID] [bigint] NOT NULL,
	[usrID] [bigint] NOT NULL,
	[partRoundShift] [int] NOT NULL,
	[partRoundSaved] [bit] NOT NULL,
	[dsPartListID] [bigint] NOT NULL,
	[dsDrawingsID] [bigint] NOT NULL,
 CONSTRAINT [PK_part] PRIMARY KEY CLUSTERED 
(
	[partID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K1] ON [dbo].[part]
(
	[partID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K1_5] ON [dbo].[part]
(
	[partID] ASC
)
INCLUDE([partdefID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K1_K4] ON [dbo].[part]
(
	[partID] ASC,
	[catID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K1_K7_K4_2_13_15] ON [dbo].[part]
(
	[partID] ASC,
	[deleted] ASC,
	[catID] ASC
)
INCLUDE([partName],[partSortNumber],[partMainPosEP]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K2_K4_K7_K16_K1_15] ON [dbo].[part]
(
	[partName] ASC,
	[catID] ASC,
	[deleted] ASC,
	[partStatusID] ASC,
	[partID] ASC
)
INCLUDE([partMainPosEP]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K2_K4_K7_K16_K1_K15_K20_K21_K6_K5_K8_K9_K12_K13_K3] ON [dbo].[part]
(
	[partName] ASC,
	[catID] ASC,
	[deleted] ASC,
	[partStatusID] ASC,
	[partID] ASC,
	[partMainPosEP] ASC,
	[dsPartListID] ASC,
	[dsDrawingsID] ASC,
	[typeID] ASC,
	[partdefID] ASC,
	[partDescr] ASC,
	[partVersion] ASC,
	[partSheet] ASC,
	[partSortNumber] ASC,
	[parentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K3_K7_K1_K5_K20_K21_K4_K6_K2_K8_K9_K12_K13_K16_K15] ON [dbo].[part]
(
	[parentID] ASC,
	[deleted] ASC,
	[partID] ASC,
	[partdefID] ASC,
	[dsPartListID] ASC,
	[dsDrawingsID] ASC,
	[catID] ASC,
	[typeID] ASC,
	[partName] ASC,
	[partDescr] ASC,
	[partVersion] ASC,
	[partSheet] ASC,
	[partSortNumber] ASC,
	[partStatusID] ASC,
	[partMainPosEP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K4_K7] ON [dbo].[part]
(
	[catID] ASC,
	[deleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K4_K7_K1_K13_K10_2_3_5_6_8_9_11_12_15_16_17_18_19_20_21] ON [dbo].[part]
(
	[catID] ASC,
	[deleted] ASC,
	[partID] ASC,
	[partSortNumber] ASC,
	[partIDold] ASC
)
INCLUDE([partName],[parentID],[partdefID],[typeID],[partDescr],[partVersion],[catIDold],[partSheet],[partMainPosEP],[partStatusID],[usrID],[partRoundShift],[partRoundSaved],[dsPartListID],[dsDrawingsID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K4_K7_K5_K1_K6_K2_K8_K9_K12_K13_K3_K16] ON [dbo].[part]
(
	[catID] ASC,
	[deleted] ASC,
	[partdefID] ASC,
	[partID] ASC,
	[typeID] ASC,
	[partName] ASC,
	[partDescr] ASC,
	[partVersion] ASC,
	[partSheet] ASC,
	[partSortNumber] ASC,
	[parentID] ASC,
	[partStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_part_5_1221579390__K5_K1] ON [dbo].[part]
(
	[partdefID] ASC,
	[partID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [catID] ON [dbo].[part]
(
	[catID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[part] ADD  DEFAULT ((0)) FOR [parentID]
GO
ALTER TABLE [dbo].[part] ADD  DEFAULT ((0)) FOR [catID]
GO
ALTER TABLE [dbo].[part] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[part] ADD  DEFAULT ((0)) FOR [partIDold]
GO
ALTER TABLE [dbo].[part] ADD  DEFAULT ((0)) FOR [catIDold]
GO
ALTER TABLE [dbo].[part] ADD  DEFAULT ((0)) FOR [partMass]
GO
ALTER TABLE [dbo].[part] ADD  DEFAULT ((0)) FOR [partMainPosEP]
GO
ALTER TABLE [dbo].[part] ADD  DEFAULT ((0)) FOR [partStatusID]
GO
ALTER TABLE [dbo].[part] ADD  DEFAULT ((0)) FOR [usrID]
GO
ALTER TABLE [dbo].[part] ADD  CONSTRAINT [DF_part_partRoundShift]  DEFAULT ((0)) FOR [partRoundShift]
GO
ALTER TABLE [dbo].[part] ADD  CONSTRAINT [DF_part_partRoundSaved]  DEFAULT ((0)) FOR [partRoundSaved]
GO
ALTER TABLE [dbo].[part] ADD  CONSTRAINT [DF_part_dsPartListID]  DEFAULT ((0)) FOR [dsPartListID]
GO
ALTER TABLE [dbo].[part] ADD  CONSTRAINT [DF_part_dsDrawingsID]  DEFAULT ((0)) FOR [dsDrawingsID]
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
CREATE TRIGGER [dbo].[check_part]
   ON  [dbo].[part]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @status bigint = 0;
	declare @catID bigint = 0;
	
	select 
	@status = i.partStatusID,
	@catID = ct.catID
	from inserted i
	inner join i_catalog ct on ct.catID = i.catID
	
	--if @status > 0
	--begin
	--	rollback transaction
	--	raiserror('part edit locked by part status', 16, 1)
	--	return
	--end 
	
	if dbo.isCatBlocked(@catID, 0) != 0
	begin
		rollback transaction
		raiserror('part edit locked by catalog block', 16, 1)
		return
	end 

    -- Insert statements for trigger here

END


GO
ALTER TABLE [dbo].[part] ENABLE TRIGGER [check_part]
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
CREATE TRIGGER [dbo].[check_part_del]
   ON  [dbo].[part]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @status bigint = 0;
	declare @catID bigint = 0;
	
	select 
	@status = i.partStatusID,
	@catID = ct.catID
	from deleted i
	inner join i_catalog ct on ct.catID = i.catID
	
	--if @status > 0
	--begin
	--	rollback transaction
	--	raiserror('part delete locked by part status', 16, 1)
	--	return
	--end 
	
	if dbo.isCatBlocked(@catID, 0) != 0
	begin
		rollback transaction
		raiserror('part delete locked by catalog block', 16, 1)
		return
	end 

    -- Insert statements for trigger here

END



GO
ALTER TABLE [dbo].[part] ENABLE TRIGGER [check_part_del]
GO
