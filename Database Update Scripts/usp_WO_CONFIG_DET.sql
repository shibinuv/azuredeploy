/****** Object:  StoredProcedure [dbo].[usp_WO_CONFIG_DET]    Script Date: 11-02-2022 19:57:16 ******/
DROP PROCEDURE IF EXISTS [dbo].[usp_WO_CONFIG_DET]
GO
/****** Object:  StoredProcedure [dbo].[usp_WO_CONFIG_DET]    Script Date: 11-02-2022 19:57:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

      
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
    
      
      
      
      
      
/*************************************** Application: MSG *************************************************************        
* Module : Transaction        
* File name : usp_WO_CONFIG_DET  .prc        
* Purpose : Get all the WO Config Details        
* Author : M.Thiyagarajan       
* Date  : 19.09.2006        
*********************************************************************************************************************/        
/*********************************************************************************************************************          
I/P : -- Input Parameters        
O/P : -- Output Parameters        
Error Code        
Description        INT.VerNO : NOV21.0  
        
********************************************************************************************************************/        
--'*********************************************************************************'*********************************        
--'* Modified History :           
--'* S.No  RFC No/Bug ID   Date        Author  Description         
--*#0001#         
--'*********************************************************************************'*********************************        
CREATE PROCEDURE [dbo].[usp_WO_CONFIG_DET]      
(      
 @IV_USERID VARCHAR(20)      
)      
AS      
BEGIN      
 DECLARE @ID_SUBS AS INT      
 DECLARE @ID_DEPT AS INT      
 SELECT  @ID_SUBS = ID_Subsidery_User,@ID_DEPT = ID_Dept_User FROM TBL_MAS_USERS WHERE ID_Login = @IV_USERID 
 --Newly added 29-12-2021
 DECLARE @SUPPLIER_ID AS INT = 0
 DECLARE @SUPP_STOCK_ID AS varchar(20)
 DECLARE @DEALER_NO AS varchar(50)
 DECLARE @SUPPLIER_CURR_NO As varchar(50)
 SELECT @SUPPLIER_ID=STOCK_SUPPLIER_ID FROM TBL_MAS_WO_CONFIGURATION WHERE  GETDATE() BETWEEN DT_EFF_FROM AND DT_EFF_TO  AND ID_SUBSIDERY_WO = @ID_SUBS AND ID_DEPT_WO = @ID_DEPT
 SELECT @SUPP_STOCK_ID=SUPPLIER_STOCK_ID,@DEALER_NO=DEALER_NO_SPARE,@SUPPLIER_CURR_NO=SUPP_CURRENTNO FROM TBL_MAS_SUPPLIER WHERE ID_SUPPLIER=@SUPPLIER_ID
 SELECT       
 ID_WO_CONFIG,      
 ID_SUBSIDERY_WO,      
 ID_DEPT_WO,      
 DT_EFF_FROM,      
 DT_EFF_TO,      
 WO_PREFIX,      
 WO_SERIES,      
 WO_VAT_CALCRISK,      
 WO_GAR_MATPRICE_PER,      
 WO_CHAREGE_BASE,      
 WO_DISCOUNT_BASE,
-- **********************************
-- Modified Date : 7th January 2009
-- Bug Id		 : ABS10_queries_31Dec08 - Row No 4
-- Description	 : Added Below Column
USE_DELV_ADDRESS ,
WO_ID_SETTINGS ,
USE_DEF_CUST,
ID_CUSTOMER ,
USE_CNFRM_DIA,
USE_SAVE_JOB_GRID,
USE_VA_ACC_CODE,
VA_ACC_CODE,
USE_ALL_SPARE_SEARCH,
ISNULL(USERNAME,0) as USERNAME,
ISNULL(PASSWORD,0) as PASSWORD,
ISNULL(NBK_LABOUR_PERCENT,0) as NBK_LABOUR_PERCENT,
@SUPP_STOCK_ID AS SUPP_STOCK_ID,
@DEALER_NO AS DEALER_NO,
--Added 08-02-2022
@SUPPLIER_CURR_NO As SUPPLIER_CURR_NO

-- **************** End Of Modification ******
 FROM TBL_MAS_WO_CONFIGURATION      
 WHERE  GETDATE() BETWEEN DT_EFF_FROM AND DT_EFF_TO      
 --ID_SUBSIDERY_WO AND ID_DEPT_WO      
 AND ID_SUBSIDERY_WO = @ID_SUBS AND ID_DEPT_WO = @ID_DEPT      
END      
/*      
      
EXEC usp_WO_CONFIG_DET_new 'admin'      
*/ 
      

GO
