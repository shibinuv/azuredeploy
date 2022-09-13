USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_DISCOUNTCODE_DELETE]    Script Date: 11.11.2020 13:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************** APPLICATION: MSG *************************************************************        
* MODULE : CONFIG        
* FILE NAME : <DBO.USP_SPR_DISCOUNTCODE_DELETE>      
* PURPOSE : To Delete the unit of measurement.    
* AUTHOR :  Maheshwaran s 
* DATE  : 22/10/2007       
*********************************************************************************************************************/        
/*********************************************************************************************************************          
I/P : -- @ID_DISCOUNTCODE 
O/P : -- @ISSUCCESS,@Errmsg   
@OV_RETVALUE - '    
       
ERROR CODE        
DESCRIPTION  
INT.VerNO : NOV21.0       
********************************************************************************************************************/        
--'*********************************************************************************'*********************************        
--'* MODIFIED HISTORY :           
--'* S.NO  RFC NO/BUG ID   DATE        AUTHOR  DESCRIPTION         
--* #0001#        
--'*********************************************************************************'*********************************        
ALTER PROCEDURE [dbo].[USP_SPR_DISCOUNTCODE_DELETE]
(@ID_DISCOUNTCODE VARCHAR(100),
 @SUPP_CURRENTNO VARCHAR(100),
 @ERRMSG VARCHAR(100) OUTPUT)
AS
BEGIN
	IF NOT EXISTS((SELECT * FROM TBL_SPR_DISCOUNTMATRIXBUY WHERE DISCOUNTCODE = @ID_DISCOUNTCODE))
	BEGIN			
		DELETE FROM TBL_SPR_DISCOUNTCODE					
		WHERE DISCOUNTCODE = @ID_DISCOUNTCODE					
		SET @ERRMSG = '0'	
	END
	ELSE
	BEGIN
			SET @ERRMSG = 'ERROR'
	END		
END









