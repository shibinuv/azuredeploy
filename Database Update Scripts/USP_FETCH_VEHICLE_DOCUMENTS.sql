USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_FETCH_VEHICLE_IMAGES]    Script Date: 09.12.2020 14:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


    
/*************************************** Application: MSG *************************************************************    
* Module : ZipCode    
* File name : USP_FETCH_VEHICLE_NEW_USED.PRC    
* Purpose : To Fetch the Subsudiary.     
* Author :  Krishnaveni   
* Date  : 26.07.2006    
*********************************************************************************************************************/    
/*********************************************************************************************************************      
I/P : -- Input Parameters    
O/P :-- Output Parameters    
Error Code    
Description    
INT.VerNO : NOV21.0    
********************************************************************************************************************/    
--'*********************************************************************************'*********************************    
--'* Modified History :       
--'* S.No  RFC No/Bug ID   Date        Author  Description     
 --   1                   09-09-2015 Martin Omnes  Fetching vehicle data into vehicledetail page    
--*#0001#    
--'*********************************************************************************'*********************************    
create Procedure [dbo].[USP_FETCH_VEHICLE_DOCUMENTS]
@REGNO		VARCHAR(100)
as  
--update TBL_MAS_VEHICLE_REFNO set refno_count+=1 where refno_code = 2
BEGIN  
	
	select FILE_NAME, FILE_PATH from TBL_MAS_FILE_UPLOADS where FILE_CONTENT_TYPE NOT LIKE 'image/'+'%' AND FILE_REGNO = @REGNO and FILE_TYPE = 'VehicleDocument' 
		ORDER BY 
				FILE_NAME ASC
	
	END 



