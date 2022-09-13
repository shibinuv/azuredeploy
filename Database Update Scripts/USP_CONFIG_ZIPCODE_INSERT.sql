/****** Object:  StoredProcedure [dbo].[USP_CONFIG_ZIPCODE_INSERT]    Script Date: 04-05-2022 15:19:35 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CONFIG_ZIPCODE_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[USP_CONFIG_ZIPCODE_INSERT]    Script Date: 04-05-2022 15:19:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


      
      
/*************************************** APPLICATION: MSG *************************************************************      
* MODULE : ZIPCODE      
* FILE NAME : USP_CONFIG_ZIPCODE_INSERT.PRC      
* PURPOSE : TO INSERT ZIPCODES INFORMATION.       
* AUTHOR : DHANUNJAYA RAO      
* DATE  : 24.07.2006      
*********************************************************************************************************************/      
/*********************************************************************************************************************        
I/P : -- INPUT PARAMETERS      
O/P :-- OUTPUT PARAMETERS      
ERROR CODE      
DESCRIPTION      
INT.VerNO : NOV21.0      
********************************************************************************************************************/      
/*********************************************************************************'*********************************      
* MODIFIED HISTORY :         
* S.NO  RFC NO/BUG ID   DATE        AUTHOR  DESCRIPTION       
*#0001#      
*********************************************************************************'**********************************/      
      
      
CREATE PROCEDURE [dbo].[USP_CONFIG_ZIPCODE_INSERT]      
(      
 @IV_ZIPCODE  VARCHAR(10),      
 @IV_DESCCOUNTRY VARCHAR(100),      
 @IV_DESCSTATE VARCHAR(100),      
 @IV_CITY  VARCHAR(50),      
 @IV_USERID      VARCHAR(20),      
 @OV_RETVALUE    VARCHAR(10) OUTPUT,      
 @OV_ZIPID  VARCHAR(10)   OUTPUT      
)      
AS      
BEGIN      
-- CODING TO CHECK ZIPCODE IS PRESENT      
	IF @IV_ZIPCODE IS NOT NULL AND LEN(@IV_ZIPCODE) >0      
	BEGIN    
		DECLARE @COUNT INT  		
		DECLARE @CNT INT      
		SELECT @CNT = COUNT(ID_PARAM) FROM TBL_MAS_CONFIG_DETAILS WHERE DESCRIPTION=@IV_DESCCOUNTRY        
		IF @CNT = 0 AND @IV_DESCCOUNTRY IS NOT NULL AND   @IV_DESCCOUNTRY <> ''   
		BEGIN      
			INSERT INTO TBL_MAS_CONFIG_DETAILS       
			(      
			ID_CONFIG,  DESCRIPTION, CREATED_BY, DT_CREATED       
			)      
			VALUES      
			(      
			'CTRY', @IV_DESCCOUNTRY, @IV_USERID, GETDATE()      
			)      
		END      
		DECLARE @IV_PARAMCOUNTRY INT      
		SELECT @IV_PARAMCOUNTRY = ID_PARAM FROM TBL_MAS_CONFIG_DETAILS WHERE DESCRIPTION=@IV_DESCCOUNTRY 
		  
		DECLARE @CNT2 INT      
		SET @CNT2 = 0      
		SELECT @CNT2 = COUNT(ID_PARAM) FROM TBL_MAS_CONFIG_DETAILS WHERE DESCRIPTION=@IV_DESCSTATE      
		IF @CNT2 = 0  AND @IV_DESCSTATE IS NOT NULL AND   @IV_DESCSTATE <> ''  
		BEGIN      
			INSERT INTO TBL_MAS_CONFIG_DETAILS       
			(      
			ID_CONFIG, DESCRIPTION, CREATED_BY, DT_CREATED       
			)      
			VALUES      
			(      
			'STATE', @IV_DESCSTATE, @IV_USERID, GETDATE()      
			)        
		END       
		DECLARE @IV_PARAMSTATE INT      
		SELECT @IV_PARAMSTATE = ID_PARAM FROM TBL_MAS_CONFIG_DETAILS WHERE DESCRIPTION=@IV_DESCSTATE    

		SELECT   @COUNT = COUNT(*)     
		FROM     TBL_MAS_ZIPCODE        
		WHERE    ZIP_ZIPCODE = @IV_ZIPCODE  		  
	 
		SELECT @OV_ZIPID = @IV_ZIPCODE	  
		IF @COUNT = 0      
		BEGIN      				 
			INSERT INTO TBL_MAS_ZIPCODE      
			(      
			ZIP_ZIPCODE, ZIP_ID_COUNTRY, ZIP_ID_STATE, ZIP_CITY, CREATED_BY, DT_CREATED       
			)      
			VALUES      
			(      
			@IV_ZIPCODE, @IV_PARAMCOUNTRY, @IV_PARAMSTATE, @IV_CITY, @IV_USERID, GETDATE()      
			)      			
			SET @OV_RETVALUE=0      

			IF @@ERROR <> 0       
				SET @OV_RETVALUE = @@ERROR      
			ELSE      
				SET @OV_RETVALUE = '0'      
			END--END FOR IF      
		ELSE 		   	
			UPDATE TBL_MAS_ZIPCODE 
				SET          
					ZIP_ID_COUNTRY = @IV_PARAMCOUNTRY,
					ZIP_ID_STATE = @IV_PARAMSTATE,
					ZIP_CITY = @IV_CITY,
					CREATED_BY = @IV_USERID,
					DT_CREATED =  GETDATE()          
			WHERE  ZIP_ZIPCODE = @IV_ZIPCODE       				        
				SET @OV_RETVALUE=0  		  
		END 
	SELECT @OV_RETVALUE      
	SELECT @OV_ZIPID  	
END--END FOR PROCEDURE      
      
      
/*      
      
DECLARE @ERR VARCHAR(20)      
DECLARE @OV_ZIPID VARCHAR(20)      
EXEC [USP_CONFIG_ZIPCODE_INSERT] '53', 'INDIA', 'KA', 'BANGLORE', 'DHANU', @ERR, @OV_ZIPID      
      
*/      


select top 5 * from TBL_MAS_ERR_MESSAGE


GO
