/****** Object:  StoredProcedure [dbo].[USP_CONFIG_WO_ORDER_INSERT]    Script Date: 01-02-2022 17:00:48 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CONFIG_WO_ORDER_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[USP_CONFIG_WO_ORDER_INSERT]    Script Date: 01-02-2022 17:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************** Application: MSG *************************************************************    
* Module : Configuration    
* File name : [USP_CONFIG_WO_ORDER_INSERT].PRC    
* Purpose : Insert the work order Details .     
* Author : G.narayana Rao  
* Date  : 27.07.2006    
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
--*#0001#     18-may-07  G.Narayana Rao  The Workorder prefix are Unquic  the application  
--Bug ID :- Update in WO Configuration, date :- 06-OCT-2009
--'*********************************************************************************'*********************************    
 

CREATE  PROCEDURE [dbo].[USP_CONFIG_WO_ORDER_INSERT]  
(  
	@IV_ID_SUB					INT			,  
	@IV_ID_DEPT					INT			,  
	@IV_ID_WO_PREFIX			VARCHAR(3)	,  
	@IV_ID_WO_SERIES			VARCHAR(10)	,  
	@IV_ID_WO_VAT_CALCRISK		BIT			,  
	@IV_ID_WO_GAR_MATPRICE_PER	DECIMAL(5, 2),  
	@IV_ID_WO_CHAREGE_BASE		CHAR(2)		,  
	@IV_ID_WO_DISCOUNT_BASE		CHAR(2)		,  
	@IV_ID_CREATED_BY			VARCHAR(20) ,  
	@USE_DELIVERY_ADDRESS		BIT,
	@USE_MANUAL_RWRK		    BIT,
	@USE_VEHICLE		        BIT,
	@USE_PC_JOB					BIT,
	@WO_DEF_STAT                VARCHAR(50)  ,
	@USE_DEF_CUST               BIT,
	@ID_CUSTOMER                VARCHAR(10),
	@USE_CNFRM_DIA              BIT,
	@USE_SAVE_JOB_GRID			BIT,
	@USE_VA_ACC_CODE			BIT,
	@VA_ACC_CODE                VARCHAR(20),
	@USE_ALL_SPARE_SEARCH       BIT,
	@DISP_RINV_PINV				BIT,
	@USER_NAME					VARCHAR(50),
	@PASSWORD					VARCHAR(50),
	@NBK_LABOUR_PERCENT	        DECIMAL(13,2),
	@TIRE_PKG_TXT_LINE			VARCHAR(200),
	@STOCK_SUPPLIER_ID			INT,
	@ov_RetValue				VARCHAR(10)	OUTPUT
 )  
AS  
BEGIN  
	DECLARE @COUNT  INT  
	DECLARE @WO_CUR_SER  BIGINT
	DECLARE @WO_SER VARCHAR(10)
	DECLARE @FLG  INT  
	SET @ov_RetValue = 'INST'  
	SET @FLG = 0  
	SET @COUNT = 0  

	IF NOT EXISTS(SELECT * FROM TBL_MAS_WO_CONFIGURATION   
					WHERE	WO_PREFIX	= @IV_ID_WO_PREFIX 
					AND		ID_DEPT_WO	<> @IV_ID_DEPT)
	BEGIN
		-- CHECKING THE WORK ORDER PREFIX & SERIES EXITS  
		SELECT	@COUNT = COUNT(*)   
		FROM	TBL_MAS_WO_CONFIGURATION   
		WHERE	WO_PREFIX		= @IV_ID_WO_PREFIX 
		AND		ID_SUBSIDERY_WO = @IV_ID_SUB      
		AND		ID_DEPT_WO		= @IV_ID_DEPT   

		IF @COUNT > 0   
		BEGIN
			SELECT	@WO_CUR_SER = MAX(CAST(WO_CUR_SERIES AS BIGINT))     
			FROM	TBL_MAS_WO_CONFIGURATION   
			WHERE	WO_PREFIX		= @IV_ID_WO_PREFIX 
			AND		ID_SUBSIDERY_WO = @IV_ID_SUB 
			AND		ID_DEPT_WO		= @IV_ID_DEPT 

			IF LEN(@WO_CUR_SER) <> 0 
				BEGIN 
					IF @IV_ID_WO_SERIES >= @WO_CUR_SER
						BEGIN 
							SET @FLG = 0
						END 
					ELSE
						BEGIN
							SET @ov_RetValue='ERRSER'
							SET @FLG = 1 
						END
				END		
			ELSE IF LEN(@WO_CUR_SER) = 0 
				BEGIN
					SET @FLG = 0
				END
		END 
		ELSE IF @COUNT = 0    					 
			BEGIN
				SET @FLG = 0	
			END 

		IF @FLG = 0
			BEGIN

				SELECT	@COUNT = COUNT(*)   
				FROM	TBL_MAS_WO_CONFIGURATION   
				WHERE		
							ID_SUBSIDERY_WO = @IV_ID_SUB AND
							ID_DEPT_WO=@IV_ID_DEPT  AND
							WO_PREFIX		= @IV_ID_WO_PREFIX  AND
							DT_EFF_TO > GETDATE()	
		
				IF @COUNT > 0
				BEGIN
					UPDATE	
							TBL_MAS_WO_CONFIGURATION   
					SET		
							WO_VAT_CALCRISK=@IV_ID_WO_VAT_CALCRISK,
							WO_CUR_SERIES=@IV_ID_WO_SERIES,
							WO_GAR_MATPRICE_PER=@IV_ID_WO_GAR_MATPRICE_PER,
							WO_CHAREGE_BASE=@IV_ID_WO_CHAREGE_BASE,
							WO_DISCOUNT_BASE=@IV_ID_WO_DISCOUNT_BASE,
							USE_DELV_ADDRESS=@USE_DELIVERY_ADDRESS,
							USE_MANUAL_RWRK = @USE_MANUAL_RWRK,
							USE_VEHICLE_SP = @USE_VEHICLE,
							USE_PC_JOB = @USE_PC_JOB,
							MODIFIED_BY = @IV_ID_CREATED_BY,  
							DT_MODIFIED = GETDATE(),
							WO_ID_SETTINGS=@WO_DEF_STAT, 
							USE_DEF_CUST =@USE_DEF_CUST, 
							ID_CUSTOMER = @ID_CUSTOMER,
							USE_CNFRM_DIA=@USE_CNFRM_DIA,
							USE_SAVE_JOB_GRID = @USE_SAVE_JOB_GRID,
							USE_VA_ACC_CODE = @USE_VA_ACC_CODE,
							VA_ACC_CODE = @VA_ACC_CODE,
							USE_ALL_SPARE_SEARCH =@USE_ALL_SPARE_SEARCH,
							DISP_RINV_PINV = @DISP_RINV_PINV,
							USERNAME=@USER_NAME,
							PASSWORD=@PASSWORD,
							NBK_LABOUR_PERCENT=@NBK_LABOUR_PERCENT,
							TIRE_PKG_TXT_LINE=@TIRE_PKG_TXT_LINE,
							STOCK_SUPPLIER_ID=@STOCK_SUPPLIER_ID
					WHERE		
							ID_SUBSIDERY_WO = @IV_ID_SUB AND
							ID_DEPT_WO=@IV_ID_DEPT  AND
							WO_PREFIX		= @IV_ID_WO_PREFIX  AND
							DT_EFF_TO > GETDATE()

					SET @ov_RetValue = 'UPDATE'

					RETURN
				END
				
				UPDATE	
						TBL_MAS_WO_CONFIGURATION   
				SET		
						DT_EFF_TO = GETDATE(),  
						MODIFIED_BY = @IV_ID_CREATED_BY,  
						DT_MODIFIED = GETDATE()  
				WHERE	
						ID_SUBSIDERY_WO = @IV_ID_SUB 
				AND		ID_DEPT_WO=@IV_ID_DEPT  
				AND		DT_EFF_TO > GETDATE()
		
				INSERT INTO TBL_MAS_WO_CONFIGURATION  
				(  
					ID_SUBSIDERY_WO,  
					ID_DEPT_WO,  
					DT_EFF_FROM ,  
					DT_EFF_TO,  
					WO_PREFIX,  
					WO_SERIES,  
					WO_VAT_CALCRISK,  
					WO_GAR_MATPRICE_PER,  
					WO_CHAREGE_BASE,  
					WO_DISCOUNT_BASE,  
					CREATED_BY,  
					DT_CREATED ,  
					WO_CUR_SERIES,
					-- **********************************
					-- Modified Date : 7th January 2009
					-- Bug Id		 : ABS10_queries_31Dec08 - Row No 4
					-- Description	 : Added Below Column
					USE_DELV_ADDRESS ,
					USE_MANUAL_RWRK ,
					USE_VEHICLE_SP,
					USE_PC_JOB,
					WO_ID_SETTINGS ,
					USE_DEF_CUST,
					ID_CUSTOMER,
					USE_CNFRM_DIA,
					USE_SAVE_JOB_GRID,
					USE_VA_ACC_CODE,
					VA_ACC_CODE,
					USE_ALL_SPARE_SEARCH,
					DISP_RINV_PINV
				-- **************** End Of Modification ******
				,USERNAME
				,PASSWORD
				,NBK_LABOUR_PERCENT
				,TIRE_PKG_TXT_LINE
				,STOCK_SUPPLIER_ID
				)  
				VALUES  
				(  
					@IV_ID_SUB,  
					@IV_ID_DEPT,  
					GETDATE(),  
					'12/31/9999 11:59:59 PM',  	  	
					@IV_ID_WO_PREFIX,  
					@IV_ID_WO_SERIES,  
					@IV_ID_WO_VAT_CALCRISK,  
					@IV_ID_WO_GAR_MATPRICE_PER,  
					@IV_ID_WO_CHAREGE_BASE,  
					@IV_ID_WO_DISCOUNT_BASE,  
					@IV_ID_CREATED_BY,  
					GETDATE(),  
					@IV_ID_WO_SERIES,
					@USE_DELIVERY_ADDRESS ,
					@USE_MANUAL_RWRK ,
					@USE_VEHICLE,
					@USE_PC_JOB,
					@WO_DEF_STAT,
					@USE_DEF_CUST,
					@ID_CUSTOMER,
					@USE_CNFRM_DIA,
					@USE_SAVE_JOB_GRID,
					@USE_VA_ACC_CODE,
					@VA_ACC_CODE,
					@USE_ALL_SPARE_SEARCH,
					@DISP_RINV_PINV,
					@USER_NAME,
					@PASSWORD,
					@NBK_LABOUR_PERCENT,
					@TIRE_PKG_TXT_LINE,
					@STOCK_SUPPLIER_ID
				)
				
				SET @ov_RetValue = 'INST'
			END
		END
	ELSE
		BEGIN	
			SET @ov_RetValue = 'ALUSED'
		END
END   
  
  
/*  
DECLARE  @OUT VARCHAR(20)  
  
EXEC  [USP_CONFIG_WO_ORDER_INSERT]  
  
  999,3,'gt',25,TRUE,2,'ST','GAMT','TEST',@OUT  
  
PRINT @OUT  
  
SELECT * FROM  TBL_MAS_WO_CONFIGURATION  
*/  

GO
