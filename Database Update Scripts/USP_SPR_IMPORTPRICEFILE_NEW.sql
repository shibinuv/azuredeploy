/****** Object:  StoredProcedure [dbo].[USP_SPR_IMPORTPRICEFILE_NEW]    Script Date: 20-10-2021 16:25:30 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPR_IMPORTPRICEFILE_NEW]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_IMPORTPRICEFILE_NEW]    Script Date: 20-10-2021 16:25:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*************************************** APPLICATION: MSG *************************************************************  
* MODULE	: ITEMS  
* FILE NAME : USP_SPR_IMPORTPRICEFILE_NEW
* PURPOSE	: TO INSERT IMPORT FILE DETAILS  
* AUTHOR	: ANUJ
* DATE		: 16.10.2021

*********************************************************************************************************************/  

  
CREATE PROCEDURE [dbo].[USP_SPR_IMPORTPRICEFILE_NEW] (  
	--@ID_MAKE			 Varchar(10),
	@ID_ITEM_CATG		 Varchar(10),
	@ID_SUPPLIER		 Int,
	@MarkupforSellPrice	 Varchar(10),
	@MarkupforBasicPrice Varchar(10),
	@MarkupforCostPrice1 Varchar(10),
	@MarkupforCostPrice2 Varchar(10),
	@PriceFileName		 Varchar(50),
	@NO_CRT_UPD_SP_REG bit,
	@DLT_AND_ADD_SP_REG bit,
	@UPDATE_SP_REG bit,
	@UPDATE_LOCAL_SP bit,
	@UPDATE_SP_ON_JOB_PKG bit,
	@CREATED_BY			 Varchar(20)
	--@OV_RETVALUE		 Varchar(10) output
)  
AS  

BEGIN 
	BEGIN TRY 
			BEGIN  
				INSERT INTO TBL_SPR_IMPORTPRICEFILE
				(  
					ID_MAKE,		
					ID_ITEM_CATG,
					ID_SUPPLIER,
					MarkupforSellingPrice,
					MarkupforBasicPrice,	
					MarkupforCostPrice1,	
					MarkupforCostPrice2,	
					PriceFileName,
					NO_CRT_UPD_SP_REG ,
					DLT_AND_ADD_SP_REG ,
					UPDATE_SP_REG ,
					UPDATE_LOCAL_SP ,
					UPDATE_SP_ON_JOB_PKG,
					CREATED_BY,
					DT_CREATED
				)  
				VALUES  
				(  
					@ID_SUPPLIER , --@ID_MAKE,		
					@ID_ITEM_CATG,
					@ID_SUPPLIER,		
					@MarkupforSellPrice,
					@MarkupforBasicPrice,	
					@MarkupforCostPrice1,	
					@MarkupforCostPrice2,	
					@PriceFileName,
					@NO_CRT_UPD_SP_REG ,
					@DLT_AND_ADD_SP_REG ,
					@UPDATE_SP_REG ,
					@UPDATE_LOCAL_SP ,
					@UPDATE_SP_ON_JOB_PKG,
					@CREATED_BY,		
					GETDATE() 
				)  
				--SET @OV_RETVALUE = 'INS' 
			END 
		END TRY
		BEGIN CATCH	
			SELECT @@ERROR         
		END CATCH
END




GO
