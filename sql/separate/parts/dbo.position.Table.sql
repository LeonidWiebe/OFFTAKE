SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[position](
	[posID] [bigint] IDENTITY(46198,1) NOT NULL,
	[posName] [varchar](50) NULL,
	[partID] [bigint] NULL,
	[srtmID] [bigint] NOT NULL,
	[muID] [bigint] NULL,
	[posQuantity] [real] NULL,
	[matID] [bigint] NULL,
	[posUnitMass] [real] NULL,
	[posCommonMass] [real] NULL,
	[mcID] [bigint] NULL,
	[numDigits] [int] NOT NULL,
	[posNumber] [real] NOT NULL,
	[posIDold] [bigint] NOT NULL,
	[posUMCalc] [bit] NOT NULL,
	[posCMCalc] [bit] NOT NULL,
	[posSketch] [bit] NOT NULL,
	[posBarLength] [bigint] NOT NULL,
 CONSTRAINT [PK_position] PRIMARY KEY CLUSTERED 
(
	[posID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [_dta_index_position_5_1765581328__K3_9] ON [dbo].[position]
(
	[partID] ASC
)
INCLUDE([posCommonMass]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_position_5_1765581328__K3_K1_K4_9] ON [dbo].[position]
(
	[partID] ASC,
	[posID] ASC,
	[srtmID] ASC
)
INCLUDE([posCommonMass]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_position_5_1765581328__K3_K1_K4_K12_5_6_7_8_9_10_11_13_14_15_16_17] ON [dbo].[position]
(
	[partID] ASC,
	[posID] ASC,
	[srtmID] ASC,
	[posNumber] ASC
)
INCLUDE([muID],[posQuantity],[matID],[posUnitMass],[posCommonMass],[mcID],[numDigits],[posIDold],[posUMCalc],[posCMCalc],[posSketch],[posBarLength]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_position_5_1765581328__K3_K10_K1_9] ON [dbo].[position]
(
	[partID] ASC,
	[mcID] ASC,
	[posID] ASC
)
INCLUDE([posCommonMass]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_position_5_1765581328__K3_K4_K7_6_9] ON [dbo].[position]
(
	[partID] ASC,
	[srtmID] ASC,
	[matID] ASC
)
INCLUDE([posQuantity],[posCommonMass]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [matID] ON [dbo].[position]
(
	[matID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [muID] ON [dbo].[position]
(
	[muID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [partID] ON [dbo].[position]
(
	[partID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [srtmID] ON [dbo].[position]
(
	[srtmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((1)) FOR [muID]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((0)) FOR [posQuantity]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((0)) FOR [posUnitMass]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((0)) FOR [posCommonMass]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((0)) FOR [mcID]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((1)) FOR [numDigits]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((0)) FOR [posNumber]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((0)) FOR [posIDold]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((1)) FOR [posUMCalc]
GO
ALTER TABLE [dbo].[position] ADD  DEFAULT ((1)) FOR [posCMCalc]
GO
ALTER TABLE [dbo].[position] ADD  CONSTRAINT [DF_position_posSketch]  DEFAULT ((1)) FOR [posSketch]
GO
ALTER TABLE [dbo].[position] ADD  CONSTRAINT [DF_position_posBarLength]  DEFAULT ((0)) FOR [posBarLength]
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
CREATE TRIGGER [dbo].[check_position]
   ON  [dbo].[position]
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
	inner join inserted i on pt.partID = i.partID 
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
ALTER TABLE [dbo].[position] ENABLE TRIGGER [check_position]
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
CREATE TRIGGER [dbo].[check_position_del]
   ON  [dbo].[position]
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
	inner join deleted i on pt.partID = i.partID 
	inner join i_catalog ct on ct.catID = pt.catID
	
	--if @status > 0
	--begin
	--	rollback transaction
	--	raiserror('position delete locked by part status', 16, 1)
	--	return
	--end 
	
	if dbo.isCatBlocked(@catID, 0) != 0
	begin
		rollback transaction
		raiserror('position delete locked by catalog block', 16, 1)
		return
	end 

    -- Insert statements for trigger here

END


GO
ALTER TABLE [dbo].[position] ENABLE TRIGGER [check_position_del]
GO
