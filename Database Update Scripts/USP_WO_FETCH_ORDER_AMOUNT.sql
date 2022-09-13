USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_WO_FETCH_ORDER_AMOUNT]    Script Date: 29.07.2020 08.56.27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************** Application: GMS *************************************************************          
* Module :Configuration  
* File name : [USP_MECHANIC_FETCH].PRC          
* Purpose : To TEMP PLAN DETAILS.  
* Author :  SUBRAMANIAN         
* Date  :  27.10.2006 
*********************************************************************************************************************/          
/*********************************************************************************************************************            
I/P : -- Input Parameters          
O/P :-- Output Parameters          
Error Code          
Description          
NT.VerNO : NOV21.0
********************************************************************************************************************/          
--'*********************************************************************************'*********************************          
--'* Modified History :             
--'* S.No  RFC No/Bug ID   Date        Author  Description           
--'*********************************************************************************'*********************************          
CREATE PROCEDURE [dbo].[USP_WO_FETCH_ORDER_AMOUNT]
(
	@ID_WO_NO AS VARCHAR(100)
)  
AS   
BEGIN
	SELECT 
			SUM(WO_FINAL_TOTAL) AS WO_FINAL_TOTAL, SUM(WO_FINAL_VAT) AS WO_FINAL_VAT , SUM(WO_FINAL_DISCOUNT) AS WO_FINAL_DISCOUNT, (SUM(WO_FINAL_TOTAL) + SUM(WO_FINAL_VAT) - SUM(WO_FINAL_DISCOUNT)) AS TOTAL_AMOUNT
	FROM 
			TBL_WO_DETAIL
	WHERE 
			ID_WO_PREFIX+ID_WO_NO = @ID_WO_NO

		
			
	
END

/*
	EXEC USP_MECHANIC_FETCH 77
*/

