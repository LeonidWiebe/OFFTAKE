SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_position_property](
	[relID] [bigint] IDENTITY(44318,1) NOT NULL,
	[posID] [bigint] NOT NULL,
	[area] [real] NULL,
	[diameter] [real] NULL,
	[height] [real] NULL,
	[length] [real] NULL,
	[radius] [real] NULL,
	[radiusinn] [real] NULL,
	[radiusout] [real] NULL,
	[segment] [real] NULL,
	[thickness] [real] NULL,
	[width] [real] NULL,
	[diaminn] [real] NULL,
	[diamout] [real] NULL,
	[volume] [real] NULL,
	[lenmin] [real] NULL,
	[lenmax] [real] NULL,
	[lenmid] [real] NULL,
	[chainx] [varchar](50) NULL,
	[chainy] [varchar](50) NULL,
	[ancbend] [real] NULL,
 CONSTRAINT [PK_r_position_property_1] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_position_property_5_162099618__K2_K1_3_4_5_6_7_8_9_10_11_12_13_14_15] ON [dbo].[r_position_property]
(
	[posID] ASC,
	[relID] ASC
)
INCLUDE([area],[diameter],[height],[length],[radius],[radiusinn],[radiusout],[segment],[thickness],[width],[diaminn],[diamout],[volume]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_position_property_5_162099618__K2_K1_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18] ON [dbo].[r_position_property]
(
	[posID] ASC,
	[relID] ASC
)
INCLUDE([area],[diameter],[height],[length],[radius],[radiusinn],[radiusout],[segment],[thickness],[width],[diaminn],[diamout],[volume],[lenmin],[lenmax],[lenmid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_position_property_5_162099618__K2_K1_4_6_12_19_20] ON [dbo].[r_position_property]
(
	[posID] ASC,
	[relID] ASC
)
INCLUDE([diameter],[length],[width],[chainx],[chainy]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [posID] ON [dbo].[r_position_property]
(
	[posID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
CREATE TRIGGER [dbo].[check_posprop]
   ON  [dbo].[r_position_property]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @status bigint = 0;
	declare @catID bigint = 0;
	
	select 
	@status = pt.partStatusID,
	@catID = ct.catID
	from part pt
	inner join position p on pt.partID = p.partID 
	inner join inserted i on p.posID = i.posID 
	inner join i_catalog ct on ct.catID = pt.catID
	
	--if @status > 0
	--begin
	--	rollback transaction
	--	raiserror('position edit locked by part status', 16, 1)
	--	return
	--end 
	
	if dbo.isCatBlocked(@catID, 0) != 0
	begin
		rollback transaction
		raiserror('position edit locked by catalog block', 16, 1)
		return
	end 

    -- Insert statements for trigger here

END


GO
ALTER TABLE [dbo].[r_position_property] ENABLE TRIGGER [check_posprop]
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
CREATE TRIGGER [dbo].[check_posprop_del]
   ON  [dbo].[r_position_property]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @status bigint = 0;
	declare @catID bigint = 0;
	
	select 
	@status = pt.partStatusID,
	@catID = ct.catID
	from part pt
	inner join position p on pt.partID = p.partID 
	inner join inserted i on p.posID = i.posID 
	inner join i_catalog ct on ct.catID = pt.catID
	
	if @status > 0
	begin
		rollback transaction
		raiserror('position delete locked by part status', 16, 1)
		return
	end 
	
	if dbo.isCatBlocked(@catID, 0) != 0
	begin
		rollback transaction
		raiserror('position delete locked by catalog block', 16, 1)
		return
	end 

    -- Insert statements for trigger here

END



GO
ALTER TABLE [dbo].[r_position_property] ENABLE TRIGGER [check_posprop_del]
GO
