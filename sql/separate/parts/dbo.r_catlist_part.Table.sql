SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[r_catlist_part](
	[relID] [bigint] IDENTITY(40649,1) NOT NULL,
	[catlistID] [bigint] NOT NULL,
	[partID] [bigint] NULL,
	[partQty] [real] NULL,
	[partSortID] [bigint] NULL,
	[objID] [bigint] NOT NULL,
	[partNameOver] [varchar](150) NULL,
	[koef] [real] NOT NULL,
 CONSTRAINT [PK_r_catlist_part] PRIMARY KEY CLUSTERED 
(
	[relID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_catlist_part_5_2101582525__K2_K1_K3_K5_4_6_7_8] ON [dbo].[r_catlist_part]
(
	[catlistID] ASC,
	[relID] ASC,
	[partID] ASC,
	[partSortID] ASC
)
INCLUDE([partQty],[objID],[partNameOver],[koef]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_catlist_part_5_2101582525__K2_K1_K3_K5_K4] ON [dbo].[r_catlist_part]
(
	[catlistID] ASC,
	[relID] ASC,
	[partID] ASC,
	[partSortID] ASC,
	[partQty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_catlist_part_5_2101582525__K2_K6_K1_K3_4] ON [dbo].[r_catlist_part]
(
	[catlistID] ASC,
	[objID] ASC,
	[relID] ASC,
	[partID] ASC
)
INCLUDE([partQty]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_catlist_part_5_2101582525__K2_K6_K1_K3_K4_K5] ON [dbo].[r_catlist_part]
(
	[catlistID] ASC,
	[objID] ASC,
	[relID] ASC,
	[partID] ASC,
	[partQty] ASC,
	[partSortID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_r_catlist_part_5_2101582525__K6_K2_K3_K1_K4_K5] ON [dbo].[r_catlist_part]
(
	[objID] ASC,
	[catlistID] ASC,
	[partID] ASC,
	[relID] ASC,
	[partQty] ASC,
	[partSortID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [catlistID] ON [dbo].[r_catlist_part]
(
	[catlistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [partID] ON [dbo].[r_catlist_part]
(
	[partID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[r_catlist_part] ADD  CONSTRAINT [DF_r_catlist_part_objID]  DEFAULT ((1)) FOR [objID]
GO
ALTER TABLE [dbo].[r_catlist_part] ADD  CONSTRAINT [DF_r_catlist_part_koef]  DEFAULT ((1)) FOR [koef]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

--ALTER TRIGGER [dbo].[r_catlist_part_AfterInsTrig] 
--ON  [dbo].[r_catlist_part] 
--FOR INSERT
--   AS 
--   IF trigger_nestlevel() = 1
--   if isnull((select top 1 partSortID from inserted),0)=0 update r_catlist_part set partSortID = relid where r_catlist_part.relID =(select top 1 relid from inserted)

CREATE TRIGGER [dbo].[r_catlist_part_AfterInsTrig] 
ON  [dbo].[r_catlist_part] 
FOR INSERT,UPDATE,DELETE
   AS 

	if exists(select * from inserted)
	begin
	   IF trigger_nestlevel() = 1
	   if isnull((select top 1 partSortID from inserted),0)=0 
			update r_catlist_part set partSortID = relid where r_catlist_part.relID =(select top 1 relid from inserted)

		insert into r_catlist_part_history ([relID],[catlistID],[partID],[partQty],[partSortID],[objID],[oper]) 
		select [relID],[catlistID],[partID],[partQty],[partSortID],[objID],1 from inserted
	end

	if exists(select * from deleted)
	begin
		insert into r_catlist_part_history ([relID],[catlistID],[partID],[partQty],[partSortID],[objID],[oper]) 
		select [relID],[catlistID],[partID],[partQty],[partSortID],[objID],0 from deleted
	end

	if exists(select * from deleted) and not exists(select * from inserted)
	begin
		delete from r_catlist_position where [clpID] in (select [relID] from deleted)
	end

GO
ALTER TABLE [dbo].[r_catlist_part] ENABLE TRIGGER [r_catlist_part_AfterInsTrig]
GO
