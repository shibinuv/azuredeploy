/****** Object:  UserDefinedFunction [dbo].[FnGetRoundedamount]    Script Date: 30-12-2021 15:11:19 ******/
DROP FUNCTION IF EXISTS [dbo].[FnGetRoundedamount]
GO
/****** Object:  UserDefinedFunction [dbo].[FnGetRoundedamount]    Script Date: 30-12-2021 15:11:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE FUNCTION [dbo].[FnGetRoundedamount]  
(  
	@INVOICESUM DECIMAL(15,5),
	@VATAMOUNT DECIMAL(15,5),
	@INV_FEES_AMT DECIMAL(15,5),
	@INV_FEES_VAT_AMT DECIMAL(15,5),
	@ID_DEPT_INV VARCHAR(10),
	@ID_SUBSIDERY_INV VARCHAR(10)
)  
RETURNS DECIMAL(15,2)  
AS  
BEGIN  
 -- Declare the return variable here  
 DECLARE @AcualAmount DECIMAL(15,2),   
   @RoundedAmount DECIMAL(15,2),   
   @RoundingAmount DECIMAL(15,2),     
   @SpAmount DECIMAL(15,2),  
   @JCount DECIMAL(15,2)  
   

DECLARE @NETTOTAL DECIMAL(15,5)
DECLARE @VATTOTAL DECIMAL(15,5)
       SELECT @NETTOTAL = @INVOICESUM 
       SELECT @VATTOTAL = @VATAMOUNT 
--SELECT @NETTOTAL, @VATTOTAL

 SELECT @AcualAmount = @NETTOTAL + @VATTOTAL + isnull(@INV_FEES_AMT,0) --+ isnull(INV_FEES_VAT_AMT,0)  

    
 SELECT @RoundedAmount =    
  CASE WHEN @AcualAmount <> 0 THEN   
  (SELECT   
   CASE WHEN INV_PRICE_RND_FN= 'Flr' and INV_RND_DECIMAL > 0 THEN   
    FLOOR(abs(@AcualAmount)/INV_RND_DECIMAL )*INV_RND_DECIMAL   
   WHEN INV_PRICE_RND_FN= 'Rnd' and INV_RND_DECIMAL > 0 THEN   
    FLOOR(abs(@AcualAmount)/INV_RND_DECIMAL + (1 - (INV_PRICE_RND_VAL_PER/ 100 )) )*INV_RND_DECIMAL   
   WHEN INV_PRICE_RND_FN= 'Clg' and INV_RND_DECIMAL > 0 THEN   
    Ceiling(abs(@AcualAmount)/INV_RND_DECIMAL)*INV_RND_DECIMAL   
   ELSE abs(@AcualAmount)   
   END   
  FROM   
   TBL_MAS_INV_CONFIGURATION where DT_EFF_TO IS NULL AND ID_DEPT_INV = @ID_DEPT_INV
   AND ID_SUBSIDERY_INV = @ID_SUBSIDERY_INV )ELSE 0   
  END   
 WHERE @AcualAmount <> 0 

  
if @AcualAmount<0   
 SET @RoundedAmount = -1*@RoundedAmount   
  
RETURN (@RoundedAmount)  

END  
GO
