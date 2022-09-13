/****** Object:  StoredProcedure [dbo].[USP_RP_GMPRICE_FETCH]    Script Date: 18-03-2021 22:33:08 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_RP_GMPRICE_FETCH]
GO
/****** Object:  StoredProcedure [dbo].[USP_RP_GMPRICE_FETCH]    Script Date: 18-03-2021 22:33:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
    
/*************************************** Application: MSG *************************************************************    
* Module : Transaction    
* File name : USP_RP_GMPRICE_FETCH.PRC    
* Purpose : TO fectch garage material price    
* Author : Jayakrishnan P.R    
* Date  : 07.05.2007    
*********************************************************************************************************************/    
/*********************************************************************************************************************      
I/P : -- Input Parameters    
O/P : -- Output Parameters    
Error Code    
Description    
INT.VerNO : NOV21.0     
********************************************************************************************************************/    
--'******************************************************************************************************************    
--'* Modified History :       
--'* S.No  RFC No/Bug ID   Date        Author  Description     
--*#0001#     
  
--'*******************************************************************************************************************    
  
  
CREATE PROCEDURE [dbo].[USP_RP_GMPRICE_FETCH]  
 (  
  @IV_ID_CUSTOMER  VARCHAR(10),  
  @IV_ID_SUBSIDERY INT,  
  @IV_ID_DEPT   INT,  
  @OV_RESULT   VARCHAR(10)  OUTPUT  
 )  
AS  
BEGIN  
  
 DECLARE @ID_CUST_GROUP AS INT  
 DECLARE @GARAGE_PRICE_PER AS DECIMAL 
 DECLARE @GAR_MAT_PRICE AS DECIMAL 
 SELECT   
  @ID_CUST_GROUP = ID_CUST_GROUP   
 FROM   
  TBL_MAS_CUSTOMER   
 WHERE   
  ID_CUSTOMER = @IV_ID_CUSTOMER   
  
 SELECT   
  @GARAGE_PRICE_PER = GARAGE_PRICE_PER   
 FROM   
  TBL_MAS_CUST_GRP_GM_PRICE_MAP   
 WHERE   
  ID_CUST_GRP_SEQ = @ID_CUST_GROUP   
  AND   
  ID_DEPT = @IV_ID_DEPT  
  
  SELECT 
  @GAR_MAT_PRICE = CUST_GARAGEMAT
  FROM
  TBL_MAS_CUSTOMER
  WHERE   
  ID_CUSTOMER = @IV_ID_CUSTOMER 



 IF @GAR_MAT_PRICE > 0
 BEGIN
 SELECT   
   
    MC.CUST_GARAGEMAT as 'PRICE',CG.ID_Vat as   ID_GMVat 
	--change end
   FROM 
   TBL_MAS_CUSTOMER MC
   INNER JOIN  
    TBL_MAS_CUST_GRP_GM_PRICE_MAP   CG
    ON MC.ID_CUST_GROUP = CG.ID_CUST_GRP_SEQ
   WHERE   
    ID_CUSTOMER = @IV_ID_CUSTOMER 
 
 END
 ELSE
 BEGIN
 -- Modified Date : 15th February 2010
-- Bug ID		 : Even though price is 0, configuration occurs
 --IF @GARAGE_PRICE_PER > 0   
 IF @GARAGE_PRICE_PER >= 0   
 -- End OF Modification 
  BEGIN  
   SELECT   
    --Bug ID :- 2_4 92
	--Date   :- 30-july-2008
    --Desc   :- Getting Vat for GM
	--GARAGE_PRICE_PER as 'PRICE'
    GARAGE_PRICE_PER as 'PRICE',ID_Vat as   ID_GMVat 
	--change end
   FROM   
    TBL_MAS_CUST_GRP_GM_PRICE_MAP   
   WHERE   
    ID_CUST_GRP_SEQ = @ID_CUST_GROUP   
    AND   
    ID_DEPT = @IV_ID_DEPT  
    and  
    getdate() between DT_EFF_FROM and DT_EFF_TO  

	   SELECT   
		@OV_RESULT = ID_Vat
	   FROM   
		TBL_MAS_CUST_GRP_GM_PRICE_MAP   
	   WHERE   
		ID_CUST_GRP_SEQ = @ID_CUST_GROUP   
		AND   
		ID_DEPT = @IV_ID_DEPT  
		and  
		getdate() between DT_EFF_FROM and DT_EFF_TO  

  END  
 ELSE  
  BEGIN  
   SELECT    
	--Bug ID :- 2_4 92
	--Date   :- 30-july-2008
    --Desc   :- Getting Vat for GM, if its taking from 
	--		TBL_MAS_WO_CONFIGURATION then Vat ID is 0
	--GARAGE_PRICE_PER as 'PRICE'
    WO_GAR_MATPRICE_PER as 'PRICE', '0' as   ID_GMVat  
	--change end
   FROM   
    TBL_MAS_WO_CONFIGURATION   
   WHERE   
    ID_SUBSIDERY_WO = @IV_ID_SUBSIDERY   
    AND   
    ID_DEPT_WO = @IV_ID_DEPT  
    AND  
    GETDATE() BETWEEN DT_EFF_FROM AND DT_EFF_TO  

	   SELECT    
		 @OV_RESULT = '0' 
	   FROM   
		TBL_MAS_WO_CONFIGURATION   
	   WHERE   
		ID_SUBSIDERY_WO = @IV_ID_SUBSIDERY   
		AND   
		ID_DEPT_WO = @IV_ID_DEPT  
		AND  
		GETDATE() BETWEEN DT_EFF_FROM AND DT_EFF_TO  
  END  
  END
END  
  
  
  
  
  
/*  
  
EXEC USP_RP_GMPRICE_FETCH '1005',1,3,''  
  
  
*/  
GO
