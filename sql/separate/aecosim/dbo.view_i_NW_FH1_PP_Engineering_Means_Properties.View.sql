SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_NW_FH1_PP_Engineering_Means_Properties]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
dbo.i_PPEngineeringMeans.Name AS '~Name',
dbo.i_PPEngineeringMeans.KKS AS '~KKS code',
dbo.i_PPEngineeringMeans.BalancedMagneticSwitch AS '~Balanced magnetic switch',
dbo.i_PPEngineeringMeans.LockType AS '~Lock type',
dbo.i_PPEngineeringMeans.PresenceCloser AS '~Presence of door closer',
dbo.i_PPEngineeringMeans.DelayClass AS '~Delay class',
dbo.i_PPEngineeringMeans.Description AS '~Description',
dbo.i_PPEngineeringMeans.SecurityZone AS '~Security zone',
dbo.i_PPEngineeringMeans.Fire_resist AS '~Fire resistance',
dbo.i_PPEngineeringMeans.Prototype AS '~Prototype (brand)',
dbo.i_PPEngineeringMeans.Number AS '~Number of power supply inputs',
dbo.i_PPEngineeringMeans.Supply AS '~Supply voltage',
dbo.i_PPEngineeringMeans.Temperature_max AS '~Maximum allowable temperature',
dbo.i_PPEngineeringMeans.Temperature_min AS '~Minimum allowable temperature',
dbo.i_PPEngineeringMeans.Note AS '~Note for specification',
dbo.i_PPEngineeringMeans.Power_system AS '~Power supply system',
dbo.i_PPEngineeringMeans.Material AS '~Material',
dbo.i_PPEngineeringMeans.IP AS '~IP class',
dbo.i_PPEngineeringMeans.Power_train AS '~Power supply train',
dbo.i_PPEngineeringMeans.KKS_room AS '~KKS code of room',
dbo.i_PPEngineeringMeans.Power_group AS '~Power supply reliability group',
dbo.i_PPEngineeringMeans.KKS_building AS '~KKS code of building',
dbo.i_PPEngineeringMeans.Functional_safety_class AS '~Functional safety class',
dbo.i_PPEngineeringMeans.Structural_safety_class AS '~Structural safety class',
dbo.i_PPEngineeringMeans.Measurement AS '~Measurement unit',
dbo.i_PPEngineeringMeans.Opening_type AS '~Opening type',
dbo.i_PPEngineeringMeans.Opening_size AS '~Opening size',
dbo.i_PPEngineeringMeans.Safety_class AS '~Safety class',
dbo.i_PPEngineeringMeans.Seismic AS '~Seismic category',
dbo.i_PPEngineeringMeans.Quality AS '~Quality assurance category',
dbo.i_PPEngineeringMeans.Net_weight AS '~Net weight',
dbo.i_PPEngineeringMeans.Code_document AS '~Document code of Design requirements',
dbo.i_PPEngineeringMeans.Detection AS '~Detection zone angle',
dbo.i_PPEngineeringMeans.Max_eff_range AS '~Maximum effective range',
dbo.i_PPEngineeringMeans.Comp_mount_meth AS '~Component mounting method',
dbo.i_PPEngineeringMeans.Voltage AS '~Operating power supply voltage',
dbo.i_PPEngineeringMeans.Consumed_power AS '~Consumed power',
dbo.i_PPEngineeringMeans.Ph_detection AS '~Physical detection principle',
dbo.i_PPEngineeringMeans.AccesID AS '~Acces ID',
dbo.i_PPEngineeringMeans.Height AS '~Height',



doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_PPEngineeringMeans ON dbo.elements.simID = dbo.i_PPEngineeringMeans.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid




GO
