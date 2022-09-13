/****** Object:  StoredProcedure [dbo].[USP_CONFIG_WORK_ORDER_FETCH]    Script Date: 01-02-2022 16:58:43 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CONFIG_WORK_ORDER_FETCH]
GO
/****** Object:  StoredProcedure [dbo].[USP_CONFIG_WORK_ORDER_FETCH]    Script Date: 01-02-2022 16:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************** Application: MSG *************************************************************  
* Module : Configuration 
* File name :USP_CONFIG_WORK_ORDER_FETCH.prc  
* Purpose : GET THE WORK ORDER
* Author : Narayana Rao 
* Date  : 27.10.2006
*********************************************************************************************************************/  
/*********************************************************************************************************************    
I/P : -- Input Parameters  
O/P : -- Output Parameters  
Error Code  
Description  INT.VerNO : NOV21.0
  
********************************************************************************************************************/  
--'*********************************************************************************'*********************************  
--'* Modified History :     
--'* S.No  RFC No/Bug ID   Date        Author  Description   
--*#0001#   
--'*********************************************************************************'*********************************  



CREATE PROCEDURE [dbo].[USP_CONFIG_WORK_ORDER_FETCH]
(
	@ID_SUB INT ,
	@ID_DEPT INT
)
AS
BEGIN
	DECLARE @SUPPLIER_ID int = 0
	DECLARE @SUPPLIER_NAME varchar(100)

	SELECT @SUPPLIER_ID=STOCK_SUPPLIER_ID FROM TBL_MAS_WO_CONFIGURATION WHERE	ID_SUBSIDERY_WO = @ID_SUB	AND ID_DEPT_WO	= @ID_DEPt  AND DT_EFF_TO > getdate()
	SELECT @SUPPLIER_NAME=SUP_Name FROM TBL_MAS_SUPPLIER WHERE ID_SUPPLIER=@SUPPLIER_ID

	SELECT 
			WO_PREFIX,
			WO_SERIES,
			WO_VAT_CALCRISK,
			WO_GAR_MATPRICE_PER,
			WO_CHAREGE_BASE,
			WO_DISCOUNT_BASE,
			WO_CUR_SERIES,
			-- **********************************
			-- Modified Date : 7th January 2009
			-- Bug Id		 : ABS10_queries_31Dec08 - Row No 4
			USE_DELV_ADDRESS,
			USE_MANUAL_RWRK,
			USE_VEHICLE_SP,
			USE_PC_JOB,
			WO_ID_SETTINGS,
			USE_DEF_CUST,
			ID_CUSTOMER,
			USE_CNFRM_DIA,
			USE_SAVE_JOB_GRID,
			USE_VA_ACC_CODE,
			VA_ACC_CODE,
			USE_ALL_SPARE_SEARCH,
			ISNULL(DISP_RINV_PINV,0) as DISP_RINV_PINV,
			ISNULL(USERNAME,0) as USERNAME,
			ISNULL(PASSWORD,0) as PASSWORD,
			ISNULL(NBK_LABOUR_PERCENT,0) as NBK_LABOUR_PERCENT,
			-- **************** End Of Modification ******
			ISNULL(TIRE_PKG_TXT_LINE,'') AS TIRE_PKG_TXT_LINE,

			ISNULL(STOCK_SUPPLIER_ID,0) AS STOCK_SUPPLIER_ID
			--,@SUPPLIER_ID AS STOCK_SUPPLIER_ID
			,@SUPPLIER_NAME AS STOCK_SUPPLIER_NAME
	FROM	
			TBL_MAS_WO_CONFIGURATION
	WHERE	
			ID_SUBSIDERY_WO = @ID_SUB	AND 
			ID_DEPT_WO		= @ID_DEPt  AND
			DT_EFF_TO > getdate()


END


/*

exec USP_CONFIG_WORK_ORDER_FETCH 1212,500
*/







GO
