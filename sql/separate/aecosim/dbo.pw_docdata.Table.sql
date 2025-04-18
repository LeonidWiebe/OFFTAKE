SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pw_docdata](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[docguid] [char](36) NOT NULL,
	[dmsstatus] [nvarchar](200) NULL,
	[deleted] [bit] NOT NULL,
	[usr_create] [varchar](50) NULL,
	[usr_checkin] [varchar](50) NULL,
	[usr_delete] [varchar](50) NULL,
	[dt_change] [datetime] NULL,
	[dt_id] [bigint] NULL,
	[last_state] [char](30) NULL,
	[counter] [int] NOT NULL,
	[queue] [int] NOT NULL,
	[nwcheck] [int] NOT NULL,
	[spaces] [int] NOT NULL,
 CONSTRAINT [PK_pw_docdata] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[pw_docdata] ADD  CONSTRAINT [DF_pw_docdata_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[pw_docdata] ADD  CONSTRAINT [DF_pw_docdata_counter]  DEFAULT ((0)) FOR [counter]
GO
ALTER TABLE [dbo].[pw_docdata] ADD  CONSTRAINT [DF_pw_docdata_queue]  DEFAULT ((0)) FOR [queue]
GO
ALTER TABLE [dbo].[pw_docdata] ADD  CONSTRAINT [DF_pw_docdata_nwcheck]  DEFAULT ((0)) FOR [nwcheck]
GO
ALTER TABLE [dbo].[pw_docdata] ADD  CONSTRAINT [DF_pw_docdata_spaces]  DEFAULT ((0)) FOR [spaces]
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
CREATE TRIGGER [dbo].[pw_docdata_queue_set]
   ON  [dbo].[pw_docdata]
   AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @parent_proj_guid char(36)
	DECLARE @classid int
	DECLARE @instanceid int
	DECLARE @p_classid int
	DECLARE @count int
	
    DECLARE @doc_guid nvarchar(255)
    DECLARE @file_name nvarchar(255)
    DECLARE @folder_no nvarchar(255)
    DECLARE @item_name nvarchar(255)
    DECLARE @bld_name nvarchar(255)
    
    DECLARE @pat nvarchar(25)
    
    DECLARE @dmsstatus nvarchar(200)
    DECLARE @ddstatus nvarchar(200)
    
    DECLARE @dmsdate datetime
    
    declare @fupdater int
    declare @fupdater_login nvarchar(63)

	declare @mode int

	declare @qu0 int
	declare @qu1 int


	
	if exists(select * from inserted) and exists(select * from deleted) set @mode = 1 -- update
	if exists(select * from inserted) and not exists(select * from deleted) set @mode = 2 -- insert
	if not exists(select * from inserted) and exists(select * from deleted) set @mode = 3 -- delete

	--select @qu0 = COUNT(*) from pw_docdata where pw_docdata.[queue] = 0 and CONVERT(varchar, pw_docdata.deleted)  + '#' + CONVERT(varchar, dms_doc.o_fupdatetime, 121) as cs
	--select @qu1 = COUNT(*) from pw_docdata where pw_docdata.[queue] = 1
	
	--if @mode = 1 or @mode = 2
	--begin
	--	select 
	--	@item_name = o_itemname, 
	--	@doc_guid = o_docguid, 
	--	@folder_no = o_projectno, 
	--	@dmsstatus = o_dmsstatus,
	--	@dmsdate = o_dmsdate,
	--	@fupdater = o_fupdaterno
	--	from inserted
	--	if @dmsstatus = 'CI'
	--	begin
	--		select @fupdater_login = o_username from dms_user where o_userno = @fupdater
	--		update pw_docdata set dmsstatus = @dmsstatus, usr_checkin = @fupdater_login where docguid = @doc_guid
	--	end
	--	 -- чистим ошибку для доумента (если она есть) для того чтобы попытаться отработать снова
	--	delete from aep_docenv_err where docguid = @doc_guid
	--end

	
	
	--if @mode = 3 -- delete
	--begin
	--	select 
	--	@item_name = o_itemname, 
	--	@doc_guid = o_docguid, 
	--	@folder_no = o_projectno, 
	--	@dmsstatus = o_dmsstatus,
	--	@dmsdate = o_dmsdate,
	--	@fupdater = o_fupdaterno
	--	from deleted
	--	update pw_docdata set deleted = 1, dmsstatus = 'x', usr_delete = null where docguid = @doc_guid
	--	 -- чистим ошибку для доумента (если она есть)
	--	delete from aep_docenv_err where docguid = @doc_guid
	--	return
	--end






END




GO
ALTER TABLE [dbo].[pw_docdata] DISABLE TRIGGER [pw_docdata_queue_set]
GO
