USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_SPAREPARTCATG_INSERT]    Script Date: 03.04.2020 10:01:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
/*************************************** APPLICATION: MSG *************************************************************          
* MODULE : CONFIG          
* FILE NAME : <DBO.USP_SPR_SPAREPARTCATG_INSERT>        
* PURPOSE : TO ADD THE SPARE PART CONFIGURATION       
* AUTHOR :  Maheshwaran s       
* DATE  : 22/07/2007      
*********************************************************************************************************************/          
/*********************************************************************************************************************            
I/P : --  @ID_DISCOUNTCODEBUY,@ID_DISCOUNTCODESELL,@ID_SUPPLIER,@ID_MAKE,@CATEGORY,@DESCRIPTION  
@INITIALCLASSCODE,@VATCODE,@ACCOUNTCODE,@FLG_ALLOWBO,@FLG_COUNTSTOCK,@FLG_ALLOWCLASS    
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
ALTER PROCEDURE [dbo].[USP_SPR_SPAREPARTCATG_INSERT] (  
 --@ID_ITEM_CATG VARCHAR(10),  
 @ID_DISCOUNTCODEBUY INT,  
 @ID_DISCOUNTCODESELL INT,  
 @SUPP_CURRENTNO varchar(50),  
 @ID_MAKE VARCHAR(10),  
 @CATEGORY VARCHAR(50),  
 @DESCRIPTION VARCHAR(100),  
 @INITIALCLASSCODE VARCHAR(50),  
 @VATCODE VARCHAR(100) null,  
 @ACCOUNTCODE VARCHAR(50) null,  
 @FLG_ALLOWBO BIT null,  
 @FLG_COUNTSTOCK BIT null,  
 @FLG_ALLOWCLASS BIT null,  
 @CREATEDBY VARCHAR(20),  
 @ISSUCCESS BIT OUTPUT,  
 @ERRMSG VARCHAR(100) OUTPUT)  
AS  
BEGIN  
 DECLARE @ID_ITEM_CATG VARCHAR(10)  
 IF EXISTS(SELECT * FROM TBL_MAS_ITEM_CATG WHERE SUPP_CURRENTNO = @ID_MAKE AND CATG_DESC = @CATEGORY)  
 BEGIN  
   set @ISSUCCESS = 0  
   set @ERRMSG = 'Record already exists for the combination of Make and Category.'    
 END  
 else  
 begin  
   BEGIN TRY  
       
     SELECT @ID_ITEM_CATG= MAX(ID_ITEM_CATG) FROM TBL_MAS_ITEM_CATG  
     IF @ID_ITEM_CATG IS NOT NULL  
      BEGIN  
       SET @ID_ITEM_CATG = CAST(@ID_ITEM_CATG AS INT) + 1  
       IF @ID_ITEM_CATG <=9  
        SET @ID_ITEM_CATG = '0' + CAST(@ID_ITEM_CATG AS VARCHAR)  
       ELSE  
        SET @ID_ITEM_CATG= @ID_ITEM_CATG  
      END  
     ELSE  
      SET @ID_ITEM_CATG='01'   
    
     INSERT INTO   
      TBL_MAS_ITEM_CATG 
      (
		ID_ITEM_CATG,CATG_DESC,ID_DISCOUNTCODEBUY,ID_DISCOUNTCODESELL,SUPP_CURRENTNO,ID_MAKE,DESCRIPTION,INITIALCLASSCODE,VATCODE,ACCOUNTCODE,FLG_ALLOWBO,
		FLG_COUNTSTOCK,FLG_ALLOWCLASS,CREATED_BY,DT_CREATED,MODIFIED_BY,DT_MODIFIED      
      )      
     VALUES  
      (        
      @ID_ITEM_CATG,  
      @CATEGORY,  
      @ID_DISCOUNTCODEBUY,  
      @ID_DISCOUNTCODESELL,  
      @SUPP_CURRENTNO,  
      NULL,--@ID_MAKE,  -- Added supp current no
      @DESCRIPTION,  
      @INITIALCLASSCODE,  
      @VATCODE,  
      @ACCOUNTCODE,  
      @FLG_ALLOWBO,  
      @FLG_COUNTSTOCK,  
      @FLG_ALLOWCLASS ,       
      @CREATEDBY,
      GETDATE(),
      NULL,
      NULL)  
     SET @ISSUCCESS = 1  
     SET @ERRMSG = ''  
   END TRY   
   BEGIN CATCH  
    SET @ISSUCCESS = 0  
    SELECT @ERRMSG = ERROR_MESSAGE()  
   END CATCH  
 end  
END  

