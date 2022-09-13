/****** Object:  StoredProcedure [dbo].[USP_Del_EnvFeeDetails]    Script Date: 5/12/2017 3:32:09 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_Del_EnvFeeDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[USP_Del_EnvFeeDetails]
GO
/****** Object:  StoredProcedure [dbo].[USP_Del_EnvFeeDetails]    Script Date: 5/12/2017 3:32:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_Del_EnvFeeDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[USP_Del_EnvFeeDetails] AS' 
END
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: 24/01/13  
-- Description: To   
-- =============================================  
ALTER PROCEDURE [dbo].[USP_Del_EnvFeeDetails]  
 @SPNO varchar(30),  
 @Make varchar(30),  
 @WareHouseid int,  
 @FLG_RETURN    VARCHAR(20) OUTPUT   
AS  
BEGIN  
DELETE FROM  TBL_MAS_ENVFEESETTINGS WHERE ID_ITEM =@SPNO AND SUPP_CURRENTNO=@Make AND ID_WAREHOUSE = @WareHouseid  

IF @@ERROR <> 0   
		SET @FLG_RETURN = @@ERROR  
	ELSE  
	 SET @FLG_RETURN = 'DEL' 

--SET @FLG_RETURN = 'DEL' 

 
END  

GO
