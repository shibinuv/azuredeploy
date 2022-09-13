USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_ITEM_CAMPAIGNPRICE_GET]    Script Date: 28.05.2020 10.07.02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
ALTER PROC [dbo].[USP_SPR_ITEM_CAMPAIGNPRICE_GET]  
 (  
  @SUPP_CURRENTNO VARCHAR(100),
  @ID_ITEM VARCHAR(100)
 )  
 
AS  
DECLARE @VALID AS INT = 0
DECLARE @VALIDDATE DATETIME
SET @VALIDDATE = GETDATE()

BEGIN
SET @VALID = (select top(1) END_DATE from TBL_SPR_ITEM_CAMPAIGNPRICE where SUPP_CURRENTNO = @SUPP_CURRENTNO and ID_ITEM = @ID_ITEM order by END_DATE desc) - (SELECT CAST(FORMAT(@VALIDDATE,'yyyyMMdd') as int))
END

BEGIN
 select *, @VALID AS VALID_DATE
 from TBL_SPR_ITEM_CAMPAIGNPRICE 
 where SUPP_CURRENTNO = @SUPP_CURRENTNO and ID_ITEM = @ID_ITEM
 
  
     
  
END  
  
