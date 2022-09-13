USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_INSERT_WEBSERVICE_RESPONSE]    Script Date: 20.04.2020 12.05.52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================  
-- Author:  Praveen  
-- Description: To save vehicle details  
-- =============================================  
CREATE PROCEDURE [dbo].[USP_INSERT_WEBSERVICE_RESPONSE]                    
(                    
 @ORDERNO   VARCHAR(100),                    
 @TEXT  VARCHAR(300),                    
 @STATUS   VARCHAR(100),
 @SERVICE   VARCHAR(100),
 @LOGIN   VARCHAR(100),
 @OV_RETVALUE   VARCHAR(10) OUTPUT     
)                    
AS                    
BEGIN                       
 
  
 IF NOT EXISTS(SELECT * FROM TBL_MAS_WEBSERVICE_RESPONSE WHERE ORDERNO = @ORDERNO AND [SERVICE] = @SERVICE)            
                   
  BEGIN    
       
  INSERT INTO TBL_MAS_WEBSERVICE_RESPONSE                    
  ( [SERVICE]
    ,[ORDERNO]
    ,[TEXT]
    ,[STATUS]
    ,[DT_CREATED]
    ,[CREATED_BY])
	VALUES (
	@SERVICE,
	 @ORDERNO,
	 @TEXT,
	 @STATUS,
	 GETDATE(),
	 @LOGIN )
        
	   SET @OV_RETVALUE = 'INSFLG'         
       
 end
 ELSE IF EXISTS (SELECT * FROM TBL_MAS_WEBSERVICE_RESPONSE WHERE ORDERNO = @ORDERNO AND  [SERVICE] = @SERVICE) 

    BEGIN       
      UPDATE TBL_MAS_WEBSERVICE_RESPONSE SET
	  TEXT = @TEXT,
	  STATUS = @STATUS,
	  DT_MODIFIED = GETDATE()
	  WHERE ORDERNO = @ORDERNO AND  [SERVICE] = @SERVICE
	  
	  SET @OV_RETVALUE = 'UPDFLG' 
   END                   
  
 PRINT  @OV_RETVALUE                  
END                    
                        
                 
                   
                   
                
  
