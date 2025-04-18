SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[i_Space](
	[simID] [bigint] NOT NULL,
	[number] [varchar](50) NULL,
	[label] [varchar](250) NULL,
	[label2] [varchar](250) NULL,
	[height] [varchar](50) NULL,
	[actualGross] [varchar](50) NULL,
	[AccessArea] [varchar](50) NULL,
	[SafetyCanal] [varchar](50) NULL,
	[NumFireComp] [varchar](50) NULL,
	[SignFireComp] [varchar](50) NULL,
	[ProtectionLevel] [varchar](50) NULL,
	[SPF_FireLoadGroup] [varchar](50) NULL,
	[SPF_RadiationSafetyAreaYVLC2] [varchar](50) NULL,
	[SPF_FireHazardClass] [varchar](50) NULL,
	[SPF_Speciality] [varchar](50) NULL,
	[dtID] [bigint] NULL,
	[SPF_TypeOfDetectors] [varchar](50) NULL,
	[SPF_AvailabilityOfFAS] [varchar](50) NULL,
	[SPF_AvailOfAFFP] [varchar](50) NULL,
	[SPF_FireFightAgent] [varchar](50) NULL,
	[SPF_FireClassRating] [varchar](50) NULL,
	[RadiationZone] [varchar](50) NULL,
	[TopCoatLayer] [varchar](50) NULL,
	[WallInteriorFinish] [varchar](50) NULL,
	[CeilInteriorFinish] [varchar](50) NULL,
	[SPF_AvailabilOfFDS] [varchar](50) NULL,
	[Doc2_ID] [bigint] NOT NULL,
	[heightMan] [real] NULL,
	[FireClass] [nchar](10) NULL,
	[SPAS_03] [nchar](10) NULL,
	[perimeter] [bigint] NULL,
	[NumFireComp2] [nvarchar](50) NULL,
	[FinishingGroup] [nvarchar](10) NULL,
	[SafetyTrain] [nvarchar](10) NULL,
	[Speciality] [nvarchar](30) NULL,
	[FireLoadGroup] [nvarchar](5) NULL,
	[SPF_FireLoadGroup_9Chapter] [varchar](150) NULL,
	[fcID] [bigint] NOT NULL,
	[FinishingTypes] [varchar](50) NULL,
	[Doc2_autp_avl] [int] NOT NULL,
	[roomID] [bigint] NOT NULL,
	[KKSFireZone] [varchar](50) NULL,
	[FloorWaterproofed] [nvarchar](50) NULL,
 CONSTRAINT [PK_i_Space] PRIMARY KEY CLUSTERED 
(
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [_dta_index_i_Space_13_629577281__K2_K39_K1] ON [dbo].[i_Space]
(
	[number] ASC,
	[fcID] ASC,
	[simID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [index2] ON [dbo].[i_Space]
(
	[NumFireComp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [index3] ON [dbo].[i_Space]
(
	[number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[i_Space] ADD  CONSTRAINT [DF_i_Space_Doc2_ID]  DEFAULT ((0)) FOR [Doc2_ID]
GO
ALTER TABLE [dbo].[i_Space] ADD  CONSTRAINT [DF_i_Space_fcID]  DEFAULT ((0)) FOR [fcID]
GO
ALTER TABLE [dbo].[i_Space] ADD  CONSTRAINT [DF_i_Space_Doc2_autp_avl]  DEFAULT ((0)) FOR [Doc2_autp_avl]
GO
ALTER TABLE [dbo].[i_Space] ADD  CONSTRAINT [DF_i_Space_roomID]  DEFAULT ((0)) FOR [roomID]
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
CREATE TRIGGER [dbo].[trig_space_row_ins]
   ON  [dbo].[i_Space]
   AFTER update, delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @cattype varchar(200) = ''
	declare @logID bigint = 0
	declare @pwdocID bigint = 0
	declare @simID bigint = 0
	declare @fcID bigint = 0
	declare @kks varchar(50) = ''
	
	if exists(select * from deleted) -- always
	begin
		select @kks = number, @simID = simID, @fcID = fcID from deleted -- existing values

		if len(@kks) > 0 and @fcID > 0
		begin
			select @logID = id from dbo.trigger_log_elements_spaces where kks = @kks

			if @logID is null or @logID = 0 
				insert into dbo.trigger_log_elements_spaces (kks, fcID) values (@kks, @fcID)
			else
				update dbo.trigger_log_elements_spaces set fcID = @fcID where kks = @kks
		end
	end

	if exists(select * from inserted) -- update...
		select @kks = number from inserted -- new values
	else
		return -- only delete


	
	
	
	if @simID is null return
	if @simID = 0 return

	if @kks is null return

	--if @fcID is null return
	--if @fcID > 0 return


	if len(@kks) > 0
	begin

		select @fcID = fcID from [dbo].[i_Space] where number = @kks and fcID > 0
			--and simID in (select simID from elements where pwdocID = @pwdocID)

		if @fcID is null or @fcID = 0
		begin
			select @fcID = fcID from [dbo].trigger_log_elements_spaces where kks = @kks
		end

		if @fcID is null return
		if @fcID = 0 return

		update dbo.i_Space set fcID = @fcID where simID = @simID 

		--insert into dbo.trigger_log_elements_spaces (kks, fcID) values (@kks, @fcID)

				
	end

	delete from [dbo].trigger_log_elements_spaces where kks = @kks
	
END

GO
ALTER TABLE [dbo].[i_Space] ENABLE TRIGGER [trig_space_row_ins]
GO
