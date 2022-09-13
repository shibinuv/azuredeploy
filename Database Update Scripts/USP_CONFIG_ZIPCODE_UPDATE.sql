/****** Object:  StoredProcedure [dbo].[USP_CONFIG_ZIPCODE_UPDATE]    Script Date: 04-05-2022 15:21:01 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_CONFIG_ZIPCODE_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[USP_CONFIG_ZIPCODE_UPDATE]    Script Date: 04-05-2022 15:21:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*************************************** APPLICATION: MSG *************************************************************  
* MODULE : ZIPCODE  
* FILE NAME : USP_CONFIG_ZIPCODE_UPDATE.PRC  
* PURPOSE : TO UPDATE ZIPCODES INFORMATION.   
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
*********************************************************************************'*********************************/  
  
  
CREATE PROCEDURE [dbo].[USP_CONFIG_ZIPCODE_UPDATE]  
(  
 @IV_ZIPCODE     VARCHAR(10),  
 @IV_DESCCOUNTRY VARCHAR(100),  
 @IV_DESCSTATE	 VARCHAR(100),  
 @IV_CITY		 VARCHAR(50),  
 @IV_USERID      VARCHAR(20),  
 @OV_RETVALUE    VARCHAR(10) OUTPUT,
 @IV_ZIPID		 INT
)  
AS  
BEGIN  
 -- DECLARE @CNT1 AS INT
 -- SELECT  @CNT1 = COUNT(*) FROM TBL_MAS_ZIPCODE 
 -- WHERE   ZIP_ZIPCODE = @IV_ZIPCODE  
 -- AND     ZIP_ID_COUNTRY = (SELECT ID_PARAM FROM TBL_MAS_CONFIG_DETAILS WHERE DESCRIPTION=@IV_DESCCOUNTRY)
  
  
	--IF @CNT1 <> 0
	--BEGIN
	--	SET @OV_RETVALUE = 'UPDFLG'
	--	RETURN
	--END
						
 -- CODING TO RETRIVE THE COUNTRY CODE   
 --CONDITION IF ALREADY EXISTS RETRIVE FROM THE  TBL_MAS_CONFIG_DETAILS OTHER WISE INSERT THE COUNTRY

  
 DECLARE @CNT INT  
 SELECT @CNT = COUNT(ID_PARAM) FROM TBL_MAS_CONFIG_DETAILS WHERE DESCRIPTION=@IV_DESCCOUNTRY  
 IF @CNT = 0  AND @IV_DESCCOUNTRY IS NOT NULL AND   @IV_DESCCOUNTRY <> ''
 BEGIN    
  INSERT INTO TBL_MAS_CONFIG_DETAILS   
  (  
   ID_CONFIG,  DESCRIPTION, CREATED_BY, DT_CREATED   
  )  
  VALUES  
  (  
   'CTRY',  @IV_DESCCOUNTRY, @IV_USERID, GETDATE()  
  )  
 END  
 DECLARE @IV_PARAMCOUNTRY INT  
 SELECT @IV_PARAMCOUNTRY = ID_PARAM FROM TBL_MAS_CONFIG_DETAILS WHERE DESCRIPTION=@IV_DESCCOUNTRY   
  
 -- CODING TO RETRIVE THE STATE CODE  
 --CONDITION IF ALREADY EXISTS RETRIVE FROM THE  TBL_MAS_CONFIG_DETAILS OTHER WISE INSERT THE STATE  
 DECLARE @CNT2 INT  
 SET @CNT2 = 0  
 SELECT @CNT2 = COUNT(ID_PARAM) FROM TBL_MAS_CONFIG_DETAILS WHERE DESCRIPTION=@IV_DESCSTATE  
 IF @CNT2 = 0  AND @IV_DESCSTATE IS NOT NULL AND   @IV_DESCSTATE <> ''
 BEGIN  
  INSERT INTO TBL_MAS_CONFIG_DETAILS   
  (  
   ID_CONFIG,  DESCRIPTION, CREATED_BY, DT_CREATED   
  )  
  VALUES  
  (  
   'STATE', @IV_DESCSTATE, @IV_USERID, GETDATE()  
  )  
 END   
 DECLARE @IV_PARAMSTATE INT  
 SELECT @IV_PARAMSTATE = ID_PARAM FROM TBL_MAS_CONFIG_DETAILS WHERE DESCRIPTION=@IV_DESCSTATE  
   
  -- UPDATING ZIPCODE  
 UPDATE TBL_MAS_ZIPCODE SET  
  --ZIP_ZIPCODE = @IV_ZIPCODE,   
  ZIP_ID_COUNTRY=@IV_PARAMCOUNTRY,  
  ZIP_ID_STATE=@IV_PARAMSTATE,  
  ZIP_CITY = @IV_CITY,   
  MODIFIED_BY= @IV_USERID,   
  DT_MODIFIED = GETDATE()  
 WHERE ZIP_ZIPCODE = @IV_ZIPCODE
    
 SET @OV_RETVALUE=0   
 IF @@ERROR <> 0   
  SET @OV_RETVALUE = @@ERROR  
 ELSE  
  SET @OV_RETVALUE = '0'  
 SELECT @OV_RETVALUE  
   
END--END FOR PROCEDURE  
  
/*  
  
DECLARE @ERR VARCHAR(20)  
EXEC [USP_CONFIG_ZIPCODE_UPDATE] '54', 'INDIA', 'TN', 'CHENNAI', 'HARI', @ERR , 3 
  
SELECT * FROM TBL_MAS_ZIPCODE  
  
*/  
  
  
  
  
  
  
GO
