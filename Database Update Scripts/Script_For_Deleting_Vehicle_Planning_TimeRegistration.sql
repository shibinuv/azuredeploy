

/*=====================================================VEHICLE SCREENS============================================================================*/
-- Script for deleting all the Vehicle Screens that is not used from Role Access 
DELETE TBL_MAS_ROLE_ACCESS WHERE ID_SCR_UTIL IN(
	SELECT ID_SCR_UTIL
	FROM TBL_MAS_ROLE_ACCESS 
	WHERE  ID_SCR_UTIL IN (
		SELECT ID_SCR 
		FROM TBL_UTIL_MOD_DETAILS 
		WHERE NAME_MODULE='VEHICLE'
		AND NAME_URL NOT IN ('/master/frmVehicleDetail.aspx','/master/frmCfVehicleDetail.aspx','/master/frmVehicleSearch.aspx','/Transactions/frmXtraCheck.aspx','')
	) 	
)
GO

-- Script for deleting all the Vehicle Screens that is not used
DELETE TBL_UTIL_MOD_DETAILS WHERE ID_SCR IN(
	SELECT ID_SCR 
	FROM TBL_UTIL_MOD_DETAILS 
	WHERE NAME_MODULE='VEHICLE'
	AND NAME_URL NOT IN ('/master/frmVehicleDetail.aspx','/master/frmCfVehicleDetail.aspx','/master/frmVehicleSearch.aspx','/Transactions/frmXtraCheck.aspx','')
) 

GO

/*=========================================================TIME REGISTRATION SCREENS=================================================================================*/
 -- Script for selecting all the Time Registration Screens that is not used
 DECLARE @PAR_ID_SCR_TREG INT
SELECT  @PAR_ID_SCR_TREG = ID_SCR FROM TBL_UTIL_MOD_DETAILS D WHERE D.NAME_MODULE LIKE '%TIME REGISTRATION%' AND MODULE_LEVEL IS NULL

IF EXISTS(SELECT * FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_URL ='/Reports/frmSalesPerMechanic.aspx' AND NAME_SCR='Order Reports')
BEGIN
	DECLARE @ID_SCR_TREG_REPORTS INT
	SELECT @ID_SCR_TREG_REPORTS = ID_SCR FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_URL ='/Reports/frmSalesPerMechanic.aspx' AND NAME_SCR='Order Reports'
	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='TIME REGISTRATION',Module_level = @PAR_ID_SCR_TREG WHERE ID_SCR = @ID_SCR_TREG_REPORTS

	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='TIME REGISTRATION',Module_level = @ID_SCR_TREG_REPORTS 
	WHERE NAME_URL ='/Reports/frmSalesPerMechanic.aspx' AND NAME_SCR='Sales Per Mechanic'

	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='TIME REGISTRATION',Module_level = @ID_SCR_TREG_REPORTS 
	WHERE NAME_URL ='/Reports/frmHoursPerMechanic.aspx' AND NAME_SCR='Hours Per Mechanic'

	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='TIME REGISTRATION',Module_level = @ID_SCR_TREG_REPORTS 
	WHERE NAME_URL ='/Reports/frmInspLogWithOTDetails.aspx' AND NAME_SCR='Inspection Log OTD Details'

	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='TIME REGISTRATION',Module_level = @ID_SCR_TREG_REPORTS 
	WHERE NAME_URL ='/Reports/frmFixedPriceAnaly.aspx' AND NAME_SCR='Fixed Price Analyse'	

END
GO
IF EXISTS(SELECT * FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_URL ='/Transactions/frmTimeRegCTPOrder.aspx?TabId=2' AND NAME_SCR='Clock Time Per Order')
BEGIN
	DECLARE @ID_SCR_TREG_SETTINGS INT
	SELECT @ID_SCR_TREG_SETTINGS = ID_SCR FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_URL ='/Transactions/frmTimeRegCTPOrder.aspx?TabId=2' AND NAME_SCR='Clock Time Per Order'
	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_SCR='Settings',NAME_URL='/master/frmCfTimeRegistration.aspx'  WHERE ID_SCR = @ID_SCR_TREG_SETTINGS

	UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Settings' WHERE ID_SCR = @ID_SCR_TREG_SETTINGS AND ID_LANG =1
	UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Einstellungen' WHERE ID_SCR = @ID_SCR_TREG_SETTINGS AND ID_LANG =2
	UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Innstillinger' WHERE ID_SCR = @ID_SCR_TREG_SETTINGS AND ID_LANG =3

	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='TIME REGISTRATION',Module_level = @ID_SCR_TREG_SETTINGS
	WHERE NAME_URL='/master/frmCfTimeRegistration.aspx' AND NAME_SCR='Time Registration'

	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='TIME REGISTRATION',Module_level = @ID_SCR_TREG_SETTINGS
	WHERE NAME_URL='/master/frmCfMechComp.aspx' AND NAME_SCR='Mechanic Competency'

	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='TIME REGISTRATION',Module_level = @ID_SCR_TREG_SETTINGS
	WHERE NAME_URL='/master/frmCfNewStation.aspx' AND NAME_SCR='Station Master'

	UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='TIME REGISTRATION',Module_level = @ID_SCR_TREG_SETTINGS
	WHERE NAME_URL='/master/frmCfHourlyPrice.aspx' AND NAME_SCR='Hourly Price'

END
 GO
 -- To Delete other Unused Time Registration Screens

 -- Script for deleting all the Vehicle Screens that is not used from Role Access 
DELETE TBL_MAS_ROLE_ACCESS WHERE ID_SCR_UTIL IN(
	SELECT ID_SCR_UTIL
	FROM TBL_MAS_ROLE_ACCESS 
	WHERE  ID_SCR_UTIL IN (
		SELECT ID_SCR 
		FROM TBL_UTIL_MOD_DETAILS 
		WHERE NAME_MODULE='TIME REGISTRATION'
		AND NAME_SCR IN ('Clock Time Per Mechanic','Inspection In Out','Over Time Details','Import Operation Numbers','User Detail Report')
	) 	
)
GO

-- IF the Screen is set as Start page for a Role we cant delete the record 
IF EXISTS ( 
			SELECT * FROM  TBL_MAS_ROLE WHERE ID_SCR_START_ROLE IN 
			(   
				SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS
				WHERE NAME_MODULE='TIME REGISTRATION' AND 
				NAME_SCR in ('Clock Time Per Mechanic','Inspection In Out','Over Time Details','Import Operation Numbers','User Detail Report')
			)
		 )
BEGIN
		DECLARE @ID_SCR_START_ROLE INT
		SELECT @ID_SCR_START_ROLE = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_URL ='/Reports/frmSalesPerMechanic.aspx' AND NAME_SCR='Sales Per Mechanic'

		UPDATE TBL_MAS_ROLE SET ID_SCR_START_ROLE = @ID_SCR_START_ROLE 
		WHERE ID_SCR_START_ROLE IN
		(   
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS
			WHERE NAME_MODULE='TIME REGISTRATION' AND 
			NAME_SCR in ('Clock Time Per Mechanic','Inspection In Out','Over Time Details','Import Operation Numbers','User Detail Report')
		)

END 

 DELETE TBL_UTIL_MOD_DETAILS 
 WHERE NAME_MODULE='TIME REGISTRATION' AND 
 NAME_SCR in ('Clock Time Per Mechanic','Inspection In Out','Over Time Details','Import Operation Numbers','User Detail Report')

 /*=========================================================PLANNING SCREENS=================================================================================*/
 GO
 DECLARE @ID_SCR_PLANNING INT 
 SELECT @ID_SCR_PLANNING = ID_SCR FROM TBL_UTIL_MOD_DETAILS D WHERE D.NAME_MODULE ='PLANNING'  AND MODULE_LEVEL IS NULL

 DECLARE @ID_DP_SETT INT
 SELECT @ID_DP_SETT = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='PLANNING' AND NAME_URL='/Transactions/frmGPPlanSummary.aspx' AND NAME_SCR='Plan Summary'
 
 UPDATE TBL_UTIL_MOD_DETAILS
 SET NAME_SCR ='DayPlanSettings' , NAME_URL='/master/frmDayPlanSettings.aspx' 
 WHERE NAME_MODULE ='PLANNING' AND ID_SCR = @ID_DP_SETT

 UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION = 'DayPlanSettings'  WHERE ID_SCR = @ID_DP_SETT AND ID_LANG = 1  
 UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION = 'Tagesplaneinstellungen'  WHERE ID_SCR = @ID_DP_SETT AND ID_LANG = 2  
 UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION = 'Dagsplan Innstillinger'  WHERE ID_SCR = @ID_DP_SETT AND ID_LANG = 3 
 
GO

 DECLARE @ID_DP_MECH_LEAVE_TYPES INT
 SELECT @ID_DP_MECH_LEAVE_TYPES = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='PLANNING' AND NAME_URL='/Transactions/frmDayPlanStation.aspx' AND NAME_SCR='Station Day plan'
 
 UPDATE TBL_UTIL_MOD_DETAILS 
 SET NAME_SCR ='MechanicLeaveTypes' , NAME_URL='/master/frmMechanicLeaveTypes.aspx'  
 WHERE NAME_MODULE ='PLANNING' AND ID_SCR = @ID_DP_MECH_LEAVE_TYPES

 UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION = 'MechanicLeaveTypes'  WHERE ID_SCR = @ID_DP_MECH_LEAVE_TYPES AND ID_LANG = 1  
 UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION = 'Arten von Mechanikerurlaub'  WHERE ID_SCR = @ID_DP_MECH_LEAVE_TYPES AND ID_LANG = 2  
 UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION = 'Mekaniker Permisjonstyper'  WHERE ID_SCR = @ID_DP_MECH_LEAVE_TYPES AND ID_LANG = 3 

 GO

 DECLARE @ID_DP_MECH_SETTINGS INT
 SELECT @ID_DP_MECH_SETTINGS = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='PLANNING' AND NAME_URL='/Transactions/frmGPPlanShiftDetails.aspx' AND NAME_SCR='Plan Shift Details'
 
 UPDATE TBL_UTIL_MOD_DETAILS 
 SET NAME_SCR ='MechanicSettings' , NAME_URL='/master/frmMechanicSetting.aspx'  
 WHERE NAME_MODULE ='PLANNING' AND ID_SCR = @ID_DP_MECH_SETTINGS 

 UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION = 'MechanicSettings'  WHERE ID_SCR = @ID_DP_MECH_SETTINGS AND ID_LANG = 1  
 UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION = 'Mechanische Einstellungen'  WHERE ID_SCR = @ID_DP_MECH_SETTINGS AND ID_LANG = 2  
 UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION = 'Mekanikerinnstillinger'  WHERE ID_SCR = @ID_DP_MECH_SETTINGS AND ID_LANG = 3 

 GO

 -- Script for deleting all the Planning Screens that is not used from Role Access 
DELETE TBL_MAS_ROLE_ACCESS WHERE ID_SCR_UTIL IN(
	SELECT ID_SCR_UTIL
	FROM TBL_MAS_ROLE_ACCESS 
	WHERE  ID_SCR_UTIL IN (
		SELECT ID_SCR 
		FROM TBL_UTIL_MOD_DETAILS 
		WHERE NAME_MODULE='PLANNING'
		AND NAME_SCR IN ('Mechanic Leave','Overview Orders','Mechanic Pop Up Calendar','Work Plan Summary','Split Pop Up','Mechanic Pop Up Calendar')
	) 	
)
GO

-- IF the Screen is set as Start page for a Role we cant delete the record 
IF EXISTS ( 
			SELECT * FROM  TBL_MAS_ROLE WHERE ID_SCR_START_ROLE IN 
			(   
				SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS
				WHERE NAME_MODULE='PLANNING' AND 
				NAME_SCR in ('Mechanic Leave','Overview Orders','Mechanic Pop Up Calendar','Work Plan Summary','Split Pop Up','Mechanic Pop Up Calendar')
			)
		 )
BEGIN
		DECLARE @ID_SCR_START_ROLE INT
		SELECT @ID_SCR_START_ROLE = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_URL ='/Transactions/frmDayPlan.aspx' AND NAME_SCR='Mechanic Day Plan'

		UPDATE TBL_MAS_ROLE SET ID_SCR_START_ROLE = @ID_SCR_START_ROLE 
		WHERE ID_SCR_START_ROLE IN
		(   
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS
			WHERE NAME_MODULE='PLANNING' AND 
			NAME_SCR in ('Mechanic Leave','Overview Orders','Mechanic Pop Up Calendar','Work Plan Summary','Split Pop Up','Mechanic Pop Up Calendar')
		)

END 

GO

 DELETE TBL_UTIL_MOD_DETAILS 
 WHERE NAME_MODULE='PLANNING' AND 
 NAME_SCR in ('Mechanic Leave','Overview Orders','Mechanic Pop Up Calendar','Work Plan Summary','Split Pop Up','Mechanic Pop Up Calendar')


 GO
  /*=========================================================SCREENS=================================================================================*/
