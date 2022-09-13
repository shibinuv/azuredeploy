USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_DEPTS_FETCH]    Script Date: 27.03.2020 11:46:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************** APPLICATION: MSG *************************************************************        
* MODULE	:      
* FILE NAME : USP_DEPTS_FETCH.PRC        
* PURPOSE	: TO FETCH THE MECHANICS DEPARTMENTS
* AUTHOR	: 
* DATE		: 27.09.2006        
*********************************************************************************************************************/        
/*********************************************************************************************************************          
I/P : -- INPUT PARAMETERS  @P_IVWO, @P_IVPREFIX        
O/P : -- OUTPUT PARAMETERS        
ERROR CODE        
DESCRIPTION  
INT.VerNO : NOV21.0       
        
********************************************************************************************************************/        
--'*********************************************************************************'*********************************        
--'* MODIFIED HISTORY :           
--'* S.NO  RFC NO/BUG ID   DATE        AUTHOR  DESCRIPTION         
--*#0001#         
--'*********************************************************************************'*********************************        
        
ALTER PROCEDURE [dbo].[USP_SPR_FETCH_REPLACEMENTITEMS]  
(
	@ID_ITEM VARCHAR(100),
	@SUPP_CURRENTNO VARCHAR(100)


)       
AS        
BEGIN     
	    
	
	select REPLACE_ID_ITEM FROM TBL_SPR_REPLACEMENT WHERE THIS_ID_ITEM=@ID_ITEM and THIS_SUPP_CURRENTNO=@SUPP_CURRENTNO


END        


