USE [parts_new]
GO

DELETE FROM [dbo].c_building
DELETE FROM [dbo].catlist where catlistID > 1
DELETE FROM [dbo].i_block
DELETE FROM [dbo].i_building
DELETE FROM [dbo].i_catalog
DELETE FROM [dbo].i_project
DELETE FROM [dbo].ms_cell_library
DELETE FROM [dbo].ms_cell_rectpen
DELETE FROM [dbo].ms_cell_roxtec
DELETE FROM [dbo].ms_construct
DELETE FROM [dbo].ms_elem_attrib_codes
DELETE FROM [dbo].ms_opening
DELETE FROM [dbo].ms_partsys
DELETE FROM [dbo].ms_pen_indent
DELETE FROM [dbo].ms_pen_type
DELETE FROM [dbo].ms_radial_section
DELETE FROM [dbo].ms_ring
DELETE FROM [dbo].ms_strap
DELETE FROM [dbo].operationslog
DELETE FROM [dbo].part
DELETE FROM [dbo].pen
DELETE FROM [dbo].pendiam
DELETE FROM [dbo].position
DELETE FROM [dbo].r_catalog_part
DELETE FROM [dbo].r_catlist_part
DELETE FROM [dbo].r_department_project
DELETE FROM [dbo].r_object_catalog
DELETE FROM [dbo].r_part_reinpoints
DELETE FROM [dbo].r_part_reinsketch
DELETE FROM [dbo].r_position_property
DELETE FROM [dbo].r_sp_relations
DELETE FROM [dbo].r_usr_catalog
DELETE FROM [dbo].r_usr_rein
DELETE FROM [dbo].r_usr_reinpoints
DELETE FROM [dbo].task
DELETE FROM [dbo].taskversion
DELETE FROM [dbo].usr
DELETE FROM [dbo].usrlist
GO


