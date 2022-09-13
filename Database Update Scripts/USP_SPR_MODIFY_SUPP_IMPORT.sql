/****** Object:  StoredProcedure [dbo].[USP_SPR_MODIFY_SUPP_IMPORT]    Script Date: 25-08-2021 15:16:44 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPR_MODIFY_SUPP_IMPORT]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_MODIFY_SUPP_IMPORT]    Script Date: 25-08-2021 15:16:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/*************************************** APPLICATION: MSG *************************************************************        
* MODULE    : SUPPLIER IMPORT     
* FILE NAME : USP_SPR_MODIFY_SUPP_IMPORT.PRC
* PURPOSE   : TO  Modify DETAILS INTO SUPPLIER IMPORT Table
* AUTHOR    : Venkatesh Prasad 
* DATE      : 03.01.2008        
*********************************************************************************************************************/        
/*********************************************************************************************************************          
I/P : -- INPUT PARAMETERS        
O/P : -- OUTPUT PARAMETERS        
@OV_RETVALUE - 'INSFLG' IF ERROR, 'OK' OTHERWISE        
       
ERROR CODE        
DESCRIPTION  
INT.VerNO : NOV21.0       
********************************************************************************************************************/        
--'*********************************************************************************'*********************************        
--'* MODIFIED HISTORY :           
--'* S.NO  RFC NO/BUG ID   DATE        AUTHOR  DESCRIPTION       
      
--'*********************************************************************************'*********************************
CREATE PROCEDURE [dbo].[USP_SPR_MODIFY_SUPP_IMPORT] (
@ID_SUPP_IMPORT	INT,
@StartNo		INT,
@EndNo			INT,
@ModifyBy		VARCHAR(20),
@OV_RETVALUE	VARCHAR(20) OUTPUT,
@OrderNo        INT
)
AS

BEGIN
SET NOCOUNT ON
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	 UPDATE TBL_SPR_SUPP_IMPORT
	 SET		START_NUM= @StartNo
			   ,END_NUM	= @EndNo		   
			   ,MODIFIED_BY = @ModifyBy
			   ,DT_MODIFIED = GETDATE()
			   ,ORDER_OF_FILE=@OrderNo
			   
	 WHERE ID_SUPP_IMPORT = @ID_SUPP_IMPORT
	COMMIT TRANSACTION
	SET @OV_RETVALUE = '0'	
END TRY

BEGIN CATCH

 IF (XACT_STATE()) = -1            
  BEGIN                 
	ROLLBACK TRANSACTION        
	SET @OV_RETVALUE = @@ERROR	        
  END;
 IF (XACT_STATE()) = 1            
  BEGIN             
   COMMIT TRANSACTION              
  END                   

END CATCH


SET NOCOUNT OFF
SET XACT_ABORT OFF
END


GO
