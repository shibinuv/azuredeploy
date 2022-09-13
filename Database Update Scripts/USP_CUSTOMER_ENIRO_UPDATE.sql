USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_CUSTOMER_ENIRO_UPDATE]    Script Date: 23.06.2020 10.21.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================  
-- Author:  Praveen  
-- Description: To save vehicle details  
-- =============================================  
create PROCEDURE [dbo].[USP_CUSTOMER_ENIRO_UPDATE]                    
(                    
 @ID_CUSTOMER   VARCHAR(15),                    
 @LAST_NAME  VARCHAR(100),                    
 @FIRST_NAME   VARCHAR(100),    --Understellsnummer                
 @MIDDLE_NAME  VARCHAR(100),                    
 @VISIT_ADDRESS  VARCHAR(200),                    
 @BILLING_ADDRESS   VARCHAR(200),                    
 @ZIP_CODE  VARCHAR(20),                    
 @ZIP_PLACE     VARCHAR(100),                    
 @PHONE VARCHAR(20),                    
 @MOBILE   VARCHAR(20),                    
 @BORN    VARCHAR(50),                    
 @SSN  VARCHAR(50),                                         
 @LOGIN   VARCHAR(200),                    
  
 @OV_RETVALUE   VARCHAR(10) OUTPUT                   
   
)                    
AS                    
BEGIN 
DECLARE @BORNDATE VARCHAR(20)
SET @BORNDATE = dbo.FN_DateFormat(@BORN)
IF EXISTS (SELECT * FROM TBL_MAS_CUSTOMER WHERE ID_CUSTOMER = @ID_CUSTOMER)

 IF @LAST_NAME <> ''  
   UPDATE TBL_MAS_CUSTOMER SET CUST_LAST_NAME = @LAST_NAME WHERE ID_CUSTOMER = @ID_CUSTOMER   
           
 
          
 IF @FIRST_NAME <> ''                   
   BEGIN                            
    UPDATE TBL_MAS_CUSTOMER SET CUST_FIRST_NAME = @FIRST_NAME WHERE ID_CUSTOMER = @ID_CUSTOMER                            
   END         
     
  --SELECT @IV_ID_MAKE_VEH = ID_MAKE FROM TBL_MAS_MAKE WHERE LOWER(ID_MAKE_NAME) = LOWER(@IV_ID_MAKE_VEH)  
          
 IF @MIDDLE_NAME <> ''                   
 BEGIN                            
  UPDATE TBL_MAS_CUSTOMER SET CUST_MIDDLE_NAME = @MIDDLE_NAME WHERE ID_CUSTOMER = @ID_CUSTOMER                            
 END     
  
 IF @VISIT_ADDRESS <> ''                   
 BEGIN                            
  UPDATE TBL_MAS_CUSTOMER SET CUST_VISIT_ADDRESS = @VISIT_ADDRESS WHERE ID_CUSTOMER = @ID_CUSTOMER                             
 END  
 
 IF @VISIT_ADDRESS <> ''                   
 BEGIN                            
  UPDATE TBL_MAS_CUSTOMER SET CUST_PERM_ADD1 = @VISIT_ADDRESS WHERE ID_CUSTOMER = @ID_CUSTOMER                             
 END 
 
 IF @BILLING_ADDRESS <> ''                   
 BEGIN                            
  UPDATE TBL_MAS_CUSTOMER SET CUST_BILL_ADD1 = @BILLING_ADDRESS WHERE ID_CUSTOMER = @ID_CUSTOMER                             
 END 
 
 IF @ZIP_CODE <> ''                   
 BEGIN                            
  UPDATE TBL_MAS_CUSTOMER SET ID_CUST_PERM_ZIPCODE = @VISIT_ADDRESS WHERE ID_CUSTOMER = @ID_CUSTOMER                             
 END  

 IF @PHONE <> ''                   
 BEGIN
  UPDATE TBL_MAS_CUSTOMER_CONTACT SET CONTACT_VALUE = @PHONE WHERE CONTACT_TYPE=2 AND CONTACT_CUSTOMER_ID = @ID_CUSTOMER AND CONTACT_STANDARD = 1                            
 END  

 IF @MOBILE <> ''                   
 BEGIN                            
   UPDATE TBL_MAS_CUSTOMER_CONTACT SET CONTACT_VALUE = @PHONE WHERE CONTACT_TYPE=1 AND CONTACT_CUSTOMER_ID = @ID_CUSTOMER AND CONTACT_STANDARD = 1                             
 END 
 
 IF @BORNDATE <> ''                   
 BEGIN                            
  UPDATE TBL_MAS_CUSTOMER SET DT_CUST_BORN = @BORNDATE WHERE ID_CUSTOMER = @ID_CUSTOMER                             
 END  

 IF @SSN <> ''                   
 BEGIN                            
  UPDATE TBL_MAS_CUSTOMER SET CUST_SSN_NO = @SSN WHERE ID_CUSTOMER = @ID_CUSTOMER                             
 END 
 
                 
 SET @OV_RETVALUE = 'UPDFLG'          
                  
 
                 
                   
 PRINT  @OV_RETVALUE                  
END                    
    

