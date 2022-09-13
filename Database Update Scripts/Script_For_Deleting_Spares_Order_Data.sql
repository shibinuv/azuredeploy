  /*=========================================================SPARES SCREENS=================================================================================*/
GO

 DECLARE @PAR_ID_SCR_SPARES INT
SELECT  @PAR_ID_SCR_SPARES = ID_SCR FROM TBL_UTIL_MOD_DETAILS D WHERE D.NAME_MODULE ='SPARES' AND MODULE_LEVEL IS NULL

UPDATE TBL_UTIL_MOD_DETAILS
SET Module_level = @PAR_ID_SCR_SPARES
WHERE NAME_MODULE = 'SPARES' AND NAME_URL ='/SS3/LocalSPDetail.aspx'

 DECLARE @ID_SCR_SPARES_RPT INT
SELECT @ID_SCR_SPARES_RPT = ID_SCR FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_MODULE='SPARES' AND NAME_SCR ='Reports'

UPDATE TBL_UTIL_MOD_DETAILS
SET NAME_URL ='/SS3/frmStockValue.aspx' ,Module_level = @PAR_ID_SCR_SPARES
WHERE ID_SCR = @ID_SCR_SPARES_RPT


UPDATE TBL_UTIL_MOD_DETAILS
SET NAME_URL= '/SS3/frmStockValue.aspx'
WHERE NAME_SCR='Value of Stock' AND NAME_MODULE='SPARES' 

DECLARE @ID_SCR_SPARES_SALES INT
SELECT @ID_SCR_SPARES_SALES = ID_SCR FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_MODULE='SPARES' AND NAME_SCR ='Replacement Chain'

UPDATE TBL_UTIL_MOD_DETAILS
SET NAME_URL ='/Reports/frmSaleAnaylse.aspx'  ,NAME_SCR='Sales Analysis'
WHERE ID_SCR = @ID_SCR_SPARES_SALES

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Sales Analysis' WHERE ID_SCR = @ID_SCR_SPARES_SALES AND ID_LANG=1
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Verkaufsanalyse' WHERE ID_SCR = @ID_SCR_SPARES_SALES AND ID_LANG=2
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Salgsanalyse' WHERE ID_SCR = @ID_SCR_SPARES_SALES AND ID_LANG=3

DECLARE @ID_SCR_SPARES_SUPP_IMP INT
SELECT @ID_SCR_SPARES_SUPP_IMP = ID_SCR FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_MODULE='SPARES' AND  NAME_SCR ='Discount Matrix'

UPDATE TBL_UTIL_MOD_DETAILS
SET NAME_URL ='/SS3/SupplierImportConfig.aspx'  ,NAME_SCR='Settings'
WHERE ID_SCR = @ID_SCR_SPARES_SUPP_IMP

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Settings' WHERE ID_SCR = @ID_SCR_SPARES_SUPP_IMP AND ID_LANG=1
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Einstellungen' WHERE ID_SCR = @ID_SCR_SPARES_SUPP_IMP AND ID_LANG=2
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Innstillinger' WHERE ID_SCR = @ID_SCR_SPARES_SUPP_IMP AND ID_LANG=3

DECLARE @ID_SCR_SPARES_SUPP_CONFIG INT
SELECT @ID_SCR_SPARES_SUPP_CONFIG = ID_SCR FROM TBL_UTIL_MOD_DETAILS  WHERE NAME_MODULE='SPARES' AND  NAME_SCR ='Discount Matrix Buying' AND NAME_URL='/SS3/DiscountMatrixBuying.aspx'

UPDATE TBL_UTIL_MOD_DETAILS
SET NAME_URL ='/SS3/SupplierImportConfig.aspx'  ,NAME_SCR='PriceFile'
WHERE ID_SCR = @ID_SCR_SPARES_SUPP_CONFIG

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='PriceFile' WHERE ID_SCR = @ID_SCR_SPARES_SUPP_CONFIG AND ID_LANG=1
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Einrichtung der Preisdatei' WHERE ID_SCR = @ID_SCR_SPARES_SUPP_CONFIG AND ID_LANG=2
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION ='Prisfil oppsett' WHERE ID_SCR = @ID_SCR_SPARES_SUPP_CONFIG AND ID_LANG=3

 -- Script for deleting all the SPARES Screens that is not used from Role Access 
DELETE TBL_MAS_ROLE_ACCESS WHERE ID_SCR_UTIL IN(
	SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='SPARES' AND ID_SCR NOT IN(
	SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='SPARES' AND 
		NAME_URL in (
		'','/SS3/LocalSPSearch.aspx','/SS3/LocalSPDetail.aspx','/SS3/SupplierDetail.aspx','/SS3/CountingSystem.aspx','/SS3/PurchaseOrder.aspx','/SS3/frmStockValue.aspx','/Reports/frmSaleAnaylse.aspx','/SS3/SupplierImportConfig.aspx'
		)AND NAME_SCR in ('Spares','Local Global','Local Spare Parts Detail','Supplier','Counting','Purchase Order','Value of Stock','Sales Analysis','PriceFile','Reports','Settings')
		)
	)
GO

IF EXISTS ( 
			SELECT * FROM  TBL_MAS_ROLE WHERE ID_SCR_START_ROLE IN (
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='SPARES' AND ID_SCR NOT IN(
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='SPARES' AND 
				NAME_URL in (
				'','/SS3/LocalSPSearch.aspx','/SS3/LocalSPDetail.aspx','/SS3/SupplierDetail.aspx','/SS3/CountingSystem.aspx','/SS3/PurchaseOrder.aspx','/SS3/frmStockValue.aspx','/Reports/frmSaleAnaylse.aspx','/SS3/SupplierImportConfig.aspx'
				)AND NAME_SCR in ('Spares','Local Global','Local Spare Parts Detail','Supplier','Counting','Purchase Order','Value of Stock','Sales Analysis','PriceFile','Reports','Settings')
			  )
			)
		 )
BEGIN
		DECLARE @ID_SCR_SPARES_START_ROLE INT
		SELECT @ID_SCR_SPARES_START_ROLE = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_URL = '/SS3/LocalSPSearch.aspx' AND NAME_SCR='Local Global'

		UPDATE TBL_MAS_ROLE SET ID_SCR_START_ROLE = @ID_SCR_SPARES_START_ROLE 
		WHERE ID_SCR_START_ROLE IN
		(
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='SPARES' AND ID_SCR NOT IN(
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='SPARES' AND 
				NAME_URL in (
				'','/SS3/LocalSPSearch.aspx','/SS3/LocalSPDetail.aspx','/SS3/SupplierDetail.aspx','/SS3/CountingSystem.aspx','/SS3/PurchaseOrder.aspx','/SS3/frmStockValue.aspx','/Reports/frmSaleAnaylse.aspx','/SS3/SupplierImportConfig.aspx'
				)AND NAME_SCR in ('Spares','Local Global','Local Spare Parts Detail','Supplier','Counting','Purchase Order','Value of Stock','Sales Analysis','PriceFile','Reports','Settings')
			  )
		)

END

GO

 DELETE TBL_UTIL_MOD_DETAILS 
 WHERE NAME_MODULE='SPARES' AND ID_SCR NOT IN(
SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='SPARES' AND 
	NAME_URL in (
	'','/SS3/LocalSPSearch.aspx','/SS3/LocalSPDetail.aspx','/SS3/SupplierDetail.aspx','/SS3/CountingSystem.aspx','/SS3/PurchaseOrder.aspx','/SS3/frmStockValue.aspx','/Reports/frmSaleAnaylse.aspx','/SS3/SupplierImportConfig.aspx'
	)AND NAME_SCR in ('Spares','Local Global','Local Spare Parts Detail','Supplier','Counting','Purchase Order','Value of Stock','Sales Analysis','PriceFile','Reports','Settings')
)

GO

 GO
  /*=========================================================ORDER SCREENS=================================================================================*/
GO

DECLARE @PAR_ID_SCR_WORK_ORDER INT
SELECT  @PAR_ID_SCR_WORK_ORDER = ID_SCR FROM TBL_UTIL_MOD_DETAILS D WHERE D.NAME_MODULE ='WORK ORDER' AND MODULE_LEVEL IS NULL

DECLARE @ID_SCR_ORDERSEARCH INT
SELECT  @ID_SCR_ORDERSEARCH = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' AND NAME_SCR='Add' AND NAME_URL='/Transactions/frmWOJobDetails.aspx?TabId=2'

UPDATE TBL_UTIL_MOD_DETAILS 
SET NAME_SCR ='All Orders',NAME_URL='/Transactions/frmOrderSearch.aspx'
WHERE ID_SCR = @ID_SCR_ORDERSEARCH

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='All Orders' WHERE ID_SCR = @ID_SCR_ORDERSEARCH AND ID_LANG =1 
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Alle Bestellungen' WHERE ID_SCR = @ID_SCR_ORDERSEARCH AND ID_LANG =2
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Alle Ordre' WHERE ID_SCR = @ID_SCR_ORDERSEARCH AND ID_LANG =3 

DECLARE @ID_SCR_RETSPARESEARCH INT
SELECT  @ID_SCR_RETSPARESEARCH = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' AND NAME_SCR='Work Order History' AND NAME_URL='/Transactions/frmWOhistory.aspx'

UPDATE TBL_UTIL_MOD_DETAILS 
SET NAME_SCR ='Return Spare Search',NAME_URL= '/SS3/frmReturnSpareSearch.aspx'
WHERE ID_SCR = @ID_SCR_RETSPARESEARCH

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Return Spare Search' WHERE ID_SCR = @ID_SCR_RETSPARESEARCH AND ID_LANG =1 
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Suche nach Ersatzteilen zurückgeben' WHERE ID_SCR = @ID_SCR_RETSPARESEARCH AND ID_LANG =2
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Returner reservesøk' WHERE ID_SCR = @ID_SCR_RETSPARESEARCH AND ID_LANG =3 

DECLARE @ID_SCR_WO_REPORTS INT
SELECT @ID_SCR_WO_REPORTS = ID_SCR FROM TBL_UTIL_MOD_DETAILS  WHERE  NAME_MODULE='WORK ORDER' AND NAME_SCR ='Accounting' AND NAME_URL='/Transactions/frmLACodeList.aspx'

UPDATE TBL_UTIL_MOD_DETAILS 
SET NAME_SCR ='Reports',NAME_URL= '/Reports/frmSalesJournal.aspx' 
WHERE ID_SCR = @ID_SCR_WO_REPORTS

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Reports' WHERE ID_SCR = @ID_SCR_WO_REPORTS AND ID_LANG =1 
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Berichte' WHERE ID_SCR = @ID_SCR_RETSPARESEARCH AND ID_LANG =2
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Rapporter' WHERE ID_SCR = @ID_SCR_RETSPARESEARCH AND ID_LANG =3 

--
UPDATE TBL_UTIL_MOD_DETAILS
SET Module_level = @ID_SCR_WO_REPORTS
WHERE NAME_MODULE='WORK ORDER' AND NAME_URL='/Reports/frmSalesJournal.aspx' AND NAME_SCR='Sales Journal'

UPDATE TBL_UTIL_MOD_DETAILS
SET Module_level = @ID_SCR_WO_REPORTS
WHERE NAME_MODULE='WORK ORDER' AND NAME_URL='/Reports/frmCreditNoteSalesJournal.aspx' AND NAME_SCR='Credit Note Sales Journal'

UPDATE TBL_UTIL_MOD_DETAILS
SET Module_level = @ID_SCR_WO_REPORTS
WHERE NAME_MODULE='WORK ORDER' AND NAME_URL='/Reports/frmOrdernotInvoiced.aspx' AND NAME_SCR='Orders Not Invoiced'

UPDATE TBL_UTIL_MOD_DETAILS
SET Module_level = @ID_SCR_WO_REPORTS
WHERE NAME_MODULE='WORK ORDER' AND NAME_URL='/Reports/frmLabourOnOrders.aspx' AND NAME_SCR='Labour On Orders'

--
DECLARE @ID_SCR_WO_SETTINGS INT
SELECT @ID_SCR_WO_SETTINGS = ID_SCR FROM TBL_UTIL_MOD_DETAILS  WHERE  NAME_MODULE='WORK ORDER' AND NAME_SCR ='Payment Details' AND NAME_URL='/Transactions/frmWOPaydetails.aspx'

UPDATE TBL_UTIL_MOD_DETAILS 
SET NAME_SCR ='Settings',NAME_URL= '/master/frmCfWorkOrder.aspx' ,Flg=1
WHERE ID_SCR = @ID_SCR_WO_SETTINGS

UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Settings' WHERE ID_SCR = @ID_SCR_WO_SETTINGS AND ID_LANG =1 
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Einstellungen' WHERE ID_SCR = @ID_SCR_WO_SETTINGS AND ID_LANG =2
UPDATE TBL_UTIL_LANG_DETAILS SET LANG_DESCRIPTION='Innstillinger' WHERE ID_SCR = @ID_SCR_WO_SETTINGS AND ID_LANG =3 


UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='WORK ORDER',Module_level=@ID_SCR_WO_SETTINGS WHERE NAME_URL ='/master/frmCfWorkOrder.aspx' and NAME_SCR = 'Work Order' 
UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='WORK ORDER',Module_level=@ID_SCR_WO_SETTINGS  WHERE NAME_URL ='/master/frmCfInvoice.aspx' and NAME_SCR = 'Invoice'      
UPDATE TBL_UTIL_MOD_DETAILS SET NAME_MODULE='WORK ORDER',Module_level=@ID_SCR_WO_SETTINGS  WHERE NAME_URL ='/master/frmCfInvPayment.aspx' and NAME_SCR = 'Invoice Series'   

GO

 -- Script for deleting all the WORK ORDER Screens that is not used from Role Access 
DELETE TBL_MAS_ROLE_ACCESS WHERE ID_SCR_UTIL IN(
	SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' AND ID_SCR NOT IN(
	SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' AND 
		NAME_URL in (
		'','/Transactions/frmOrderSearch.aspx','/Transactions/frmWOJobDetails.aspx','/Transactions/frmRepairPackage.aspx','/Transactions/frmInvoice.aspx','/SS3/frmReturnSpareSearch.aspx','/Reports/frmSalesJournal.aspx','/Reports/frmCreditNoteSalesJournal.aspx','/Reports/frmordernotinvoiced.aspx','/Reports/frmLabourOnOrders.aspx','/master/frmCfWorkOrder.aspx','/master/frmCfInvoice.aspx','/master/frmCfInvPayment.aspx'	)
		AND NAME_SCR in ('Order','All Orders','Work Order Job Details','Repair Package','Invoice','Return Spare Search','Sales Journal','Credit Note Sales Journal','Orders Not Invoiced','Labour On Orders','Reports','Settings','Work Order' ,'Invoice Series','Order Search')
		)
	)
GO
IF EXISTS ( 
			SELECT * FROM  TBL_MAS_ROLE WHERE ID_SCR_START_ROLE IN (
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' AND ID_SCR NOT IN(
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS 
			WHERE 
			NAME_MODULE ='WORK ORDER' AND 
				NAME_URL in (
				'','/Transactions/frmOrderSearch.aspx','/Transactions/frmWOJobDetails.aspx','/Transactions/frmRepairPackage.aspx','/Transactions/frmInvoice.aspx','/SS3/frmReturnSpareSearch.aspx','/Reports/frmSalesJournal.aspx','/Reports/frmCreditNoteSalesJournal.aspx','/Reports/frmordernotinvoiced.aspx','/Reports/frmLabourOnOrders.aspx','/master/frmCfWorkOrder.aspx','/master/frmCfInvoice.aspx','/master/frmCfInvPayment.aspx','/Transactions/frmWOSearch.aspx')
				AND NAME_SCR in ('Order','All Orders','Work Order Job Details','Repair Package','Invoice','Return Spare Search','Sales Journal','Credit Note Sales Journal','Orders Not Invoiced','Labour On Orders','Reports','Settings','Work Order' ,'Invoice Series','Work Order Search','Order Search')
			  )
			)
		 )
BEGIN
		DECLARE @ID_SCR_WORKORDER_START_ROLE INT
		SELECT @ID_SCR_WORKORDER_START_ROLE = ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_URL = '/Transactions/frmWOSearch.aspx' AND NAME_SCR='Work Order Search'
		
		UPDATE TBL_MAS_ROLE SET ID_SCR_START_ROLE = @ID_SCR_WORKORDER_START_ROLE 
		WHERE ID_SCR_START_ROLE IN
		(
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS WHERE NAME_MODULE='WORK ORDER' AND ID_SCR NOT IN(
			SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS 
			WHERE 
			NAME_MODULE ='WORK ORDER' AND 
				NAME_URL in (
				'','/Transactions/frmOrderSearch.aspx','/Transactions/frmWOJobDetails.aspx','/Transactions/frmRepairPackage.aspx','/Transactions/frmInvoice.aspx','/SS3/frmReturnSpareSearch.aspx','/Reports/frmSalesJournal.aspx','/Reports/frmCreditNoteSalesJournal.aspx','/Reports/frmordernotinvoiced.aspx','/Reports/frmLabourOnOrders.aspx','/master/frmCfWorkOrder.aspx','/master/frmCfInvoice.aspx','/master/frmCfInvPayment.aspx','/Transactions/frmWOSearch.aspx')
				AND NAME_SCR in ('Order','All Orders','Work Order Job Details','Repair Package','Invoice','Return Spare Search','Sales Journal','Credit Note Sales Journal','Orders Not Invoiced','Labour On Orders','Reports','Settings','Work Order' ,'Invoice Series','Work Order Search','Order Search')
			  )
		)

END

GO

 DELETE TBL_UTIL_MOD_DETAILS 
 WHERE NAME_MODULE='WORK ORDER' AND ID_SCR NOT IN(
 	SELECT ID_SCR FROM TBL_UTIL_MOD_DETAILS 
	WHERE 
	NAME_MODULE ='WORK ORDER' AND 
		NAME_URL in (
		'','/Transactions/frmOrderSearch.aspx','/Transactions/frmWOJobDetails.aspx','/Transactions/frmRepairPackage.aspx','/Transactions/frmInvoice.aspx','/SS3/frmReturnSpareSearch.aspx','/Reports/frmSalesJournal.aspx','/Reports/frmCreditNoteSalesJournal.aspx','/Reports/frmordernotinvoiced.aspx','/Reports/frmLabourOnOrders.aspx','/master/frmCfWorkOrder.aspx','/master/frmCfInvoice.aspx','/master/frmCfInvPayment.aspx','/Transactions/frmWOSearch.aspx')
		AND NAME_SCR in ('Order','All Orders','Work Order Job Details','Repair Package','Invoice','Return Spare Search','Sales Journal','Credit Note Sales Journal','Orders Not Invoiced','Labour On Orders','Reports','Settings','Work Order' ,'Invoice Series','Work Order Search','Order Search')
)

GO

UPDATE TBL_UTIL_MOD_DETAILS SET FLG=1 WHERE NAME_MODULE='WORK ORDER'