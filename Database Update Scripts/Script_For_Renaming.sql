
/*Customer - To delete the Customer Reports */
DECLARE @ID_SCR_CUST INT
SELECT @ID_SCR_CUST = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_SCR='Customer Reports' AND NAME_MODULE='CUSTOMER' AND NAME_URL='/Reports/frmCustomerReport.aspx'

DELETE TBL_MAS_ROLE_ACCESS  WHERE ID_SCR_UTIL = @ID_SCR_CUST

DELETE FROM TBL_UTIL_LANG_DETAILS WHERE ID_SCR = @ID_SCR_CUST

GO
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
/*Vehicle  */
DECLARE @ID_SCR_CF_VEH INT
SELECT @ID_SCR_CF_VEH = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='VEHICLE' and NAME_URL='/master/frmCfVehicleDetail.aspx'

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Innstillinger' WHERE ID_SCR = @ID_SCR_CF_VEH and ID_LANG = 3


DECLARE @ID_SCR_VEH_SRCH INT,@ID_SCR_VEH_DET INT
SELECT @ID_SCR_VEH_SRCH = ID_SCR FROM TBL_UTIL_MOD_DETAILS
WHERE NAME_MODULE ='VEHICLE' and NAME_SCR='Vehicle Search' and NAME_URL='/master/frmVehicleSearch.aspx' and Flg = 0

UPDATE TBL_UTIL_MOD_DETAILS SET Flg = 1
WHERE ID_SCR =  @ID_SCR_VEH_SRCH 

-- To delete NAME_MODULE ='VEHICLE' , NAME_SCR='Vehicle_Detail' , NAME_URL='/master/frmVehicle.aspx'

DELETE TBL_MAS_ROLE_ACCESS  WHERE ID_SCR_UTIL = @ID_SCR_VEH_SRCH

DELETE TBL_UTIL_MOD_DETAILS WHERE ID_SCR = @ID_SCR_VEH_SRCH AND  NAME_MODULE ='VEHICLE'

GO

---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------

/*Spares  */

DECLARE @ID_SCR_PO INT , @ID_SCR_SPR_DET INT
SELECT @ID_SCR_PO = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='SPARES' AND NAME_SCR ='Purchase Order' AND NAME_URL='/SS3/PurchaseOrder.aspx'

SELECT @ID_SCR_SPR_DET = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='SPARES' AND NAME_SCR ='Local Spare Parts Detail' AND NAME_URL='/SS3/LocalSPDetail.aspx'

UPDATE TBL_UTIL_MOD_DETAILS SET NAME_SCR = 'Local Spare Parts Detail' ,NAME_URL='/SS3/LocalSPDetail.aspx'
WHERE ID_SCR = @ID_SCR_PO

UPDATE TBL_UTIL_MOD_DETAILS SET NAME_SCR = 'Purchase Order' ,NAME_URL='/SS3/PurchaseOrder.aspx'
WHERE ID_SCR = @ID_SCR_SPR_DET

--To update the text for both in lang tables
SELECT * INTO #Temp_PO
FROM TBL_UTIL_LANG_DETAILS WHERE ID_SCR = @ID_SCR_PO

SELECT * INTO #Temp_Spr
FROM TBL_UTIL_LANG_DETAILS WHERE ID_SCR = @ID_SCR_SPR_DET

Update TBL_UTIL_LANG_DETAILS SET ID_SCR = @ID_SCR_SPR_DET
WHERE SLNO in (SELECT SLNO FROM #Temp_PO)

DROP TABLE #Temp_PO
------------------------------------------------------------------------------------------------------------------

UPDATE TBL_UTIL_LANG_DETAILS SET ID_SCR = @ID_SCR_PO
WHERE SLNO in (SELECT SLNO FROM #Temp_Spr)

DROP TABLE #Temp_Spr

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Vare' WHERE ID_SCR = @ID_SCR_PO AND ID_LANG = 3

GO

---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
/* DEKKHOTELL/TIRE HOTELL  */

DECLARE @ID_SCR_TP INT
SELECT @ID_SCR_TP = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='HOTELS' AND NAME_SCR ='Hotels' AND Module_level IS NULL
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Dekkpakker' WHERE ID_SCR = @ID_SCR_TP AND ID_LANG = 3

GO
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
/* DAYPLAN   */

DECLARE @ID_SCR_DP INT
SELECT @ID_SCR_DP = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='PLANNING' AND Module_level IS NULL

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Avtaler' WHERE ID_SCR = @ID_SCR_DP AND ID_LANG = 3

DECLARE @ID_SCR_DP_SETT INT
SELECT @ID_SCR_DP_SETT = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE ='PLANNING' AND NAME_SCR='DayPlanSettings' AND NAME_URL='/master/frmDayPlanSettings.aspx'
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Avtaleinnstillinger' WHERE ID_SCR = @ID_SCR_DP_SETT AND ID_LANG = 3

----
DECLARE @ID_SCR_DP_SCR INT
SELECT @ID_SCR_DP_SCR = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='PLANNING' and NAME_SCR='Day Plan' and NAME_URL='/Transactions/frmDayPlan.aspx'

DELETE TBL_MAS_ROLE_ACCESS WHERE ID_SCR_UTIL = @ID_SCR_DP_SCR
DELETE TBL_UTIL_MOD_DETAILS WHERE ID_SCR = @ID_SCR_DP_SCR

GO
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
/* ORDRE /WORK ORDER   */

DECLARE @ID_SCR_ALLORD INT
SELECT @ID_SCR_ALLORD = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' AND NAME_SCR='All Orders' AND NAME_URL='/Transactions/frmOrderSearch.aspx'

UPDATE TBL_MENU_CONFIG SET MENU_HEADER_ID = @ID_SCR_ALLORD  WHERE NAME_MODULE ='WORK ORDER'

DECLARE @ID_SCR_RETSPR INT
SELECT @ID_SCR_RETSPR = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' and NAME_SCR='Return Spare Search' and NAME_URL='/SS3/frmReturnSpareSearch.aspx'

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Überf. Finanzbuchh.' WHERE ID_SCR = @ID_SCR_RETSPR AND ID_LANG = 2
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Returordre' WHERE ID_SCR = @ID_SCR_RETSPR AND ID_LANG = 3

DECLARE @ID_SCR_RET_RPT INT
SELECT @ID_SCR_RET_RPT = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' and NAME_SCR='Reports' and NAME_URL='/Reports/frmSalesJournal.aspx'

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Berichte' WHERE ID_SCR = @ID_SCR_RET_RPT AND ID_LANG = 2
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Rapporter' WHERE ID_SCR = @ID_SCR_RET_RPT AND ID_LANG = 3

DECLARE @ID_SCR_WOJOB INT
SELECT @ID_SCR_WOJOB = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' and NAME_SCR='Work Order Job Details' and NAME_URL='/Transactions/frmWOJobDetails.aspx'
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Ny ordre' WHERE ID_SCR = @ID_SCR_WOJOB AND ID_LANG = 3

DECLARE @ID_SCR_WOSRCH INT
SELECT @ID_SCR_WOSRCH = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' and NAME_SCR='Work Order Search' and NAME_URL='/Transactions/frmWOSearch.aspx'
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Bestillingssøk' WHERE ID_SCR = @ID_SCR_WOSRCH AND ID_LANG = 3

--- To delete the Work Order Search
DECLARE @ID_SCR_ORD_SRCH INT
SELECT @ID_SCR_ORD_SRCH = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' and NAME_SCR='Order Search' and NAME_URL='/Transactions/frmWOSearch.aspx'

UPDATE TBL_MAS_ROLE SET ID_SCR_START_ROLE = @ID_SCR_WOSRCH   WHERE ID_SCR_START_ROLE = @ID_SCR_ORD_SRCH


DELETE TBL_MAS_ROLE_ACCESS  WHERE ID_SCR_UTIL = @ID_SCR_ORD_SRCH

DELETE TBL_UTIL_MOD_DETAILS WHERE ID_SCR = @ID_SCR_ORD_SRCH AND  NAME_MODULE ='WORK ORDER'