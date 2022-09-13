/****** Object:  StoredProcedure [dbo].[USP_SPR_ADD_SUPP_IMPORT]    Script Date: 03-11-2021 11:56:33 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPR_ADD_SUPP_IMPORT]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_ADD_SUPP_IMPORT]    Script Date: 03-11-2021 11:56:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************** APPLICATION: MSG *************************************************************        
* MODULE    : SUPPLIER IMPORT     
* FILE NAME : USP_SPR_ADD_SUPP_IMPORT.PRC
* PURPOSE   : TO  SAVE DETAILS INTO SUPPLIER IMPORT Table
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
CREATE PROCEDURE [dbo].[USP_SPR_ADD_SUPP_IMPORT] (
@Id_Supplier	INT,
@StartNo		INT,
@EndNo			INT,
@Field_Name		VARCHAR(50),
@CreatedBy		VARCHAR(20),
@FileMode       VARCHAR(50),
@OV_RETVALUE	VARCHAR(20) OUTPUT,
@Order_Of_file  INT,
@Delimiter      VARCHAR(50),
@SUPP_LAYOUT_NAME varchar(50),
@REMOVE_START_ZERO bit,
@REMOVE_BLANK_FIELD bit,
@DIVIDE_PRICE_BY_HUNDRED bit,
@PRICE_FILE_DEC_SEP varchar(10)


)
AS

BEGIN
SET NOCOUNT ON
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	 INSERT INTO TBL_SPR_SUPP_IMPORT
			   (ID_SUPPLIER
			   ,START_NUM
			   ,END_NUM
			   ,FIELD_NAME
			   ,CREATED_BY
			   ,DT_CREATED
				/*==================Begin=======================================
				Modified Date  :   05-May-2008
				Fixed Bug Id   :   2227 */
			   ,FLG_DELETE	
				/*==================END=======================================*/
			   ,FILEMODE
			   ,ORDER_OF_FILE
			   ,DELIMITER
			   ,SUPP_LAYOUT_NAME 
				,REMOVE_START_ZERO 
				,REMOVE_BLANK_FIELD 
				,DIVIDE_PRICE_BY_HUNDRED 
			   )
		 VALUES
			   (@Id_Supplier
			   ,@StartNo	
			   ,@EndNo		
			   ,@Field_Name	
			   ,@CreatedBy	
			   ,GETDATE()
				/*==================Begin=======================================
				Modified Date  :   05-May-2008
				Fixed Bug Id   :   2227 */
			   ,'FALSE'
				/*==================END=======================================*/
				,@FileMode
				,@Order_Of_file
                ,@Delimiter 
				,@SUPP_LAYOUT_NAME
				,@REMOVE_START_ZERO 
				,@REMOVE_BLANK_FIELD 
				,@DIVIDE_PRICE_BY_HUNDRED 
			   )
	
	COMMIT TRANSACTION
	SET @OV_RETVALUE = '0'	
	IF EXISTS (SELECT * FROM TBL_SPR_SUPP_IMPORT where ID_SUPPLIER=@Id_Supplier)
	BEGIN
	UPDATE  TBL_SPR_SUPP_IMPORT SET SUPP_LAYOUT_NAME=@SUPP_LAYOUT_NAME, REMOVE_START_ZERO=@REMOVE_START_ZERO,REMOVE_BLANK_FIELD=@REMOVE_BLANK_FIELD,DIVIDE_PRICE_BY_HUNDRED= @DIVIDE_PRICE_BY_HUNDRED , FILEMODE = @FileMode,PRICE_FILE_DEC_SEP=@PRICE_FILE_DEC_SEP where ID_SUPPLIER=@Id_Supplier
	END
	
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
