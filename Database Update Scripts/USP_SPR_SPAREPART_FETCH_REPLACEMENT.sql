USE [CARSDEV]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_FETCH_REPLACEMENTITEMS]    Script Date: 30.03.2020 09.04.03 ******/
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
        
CREATE PROCEDURE [dbo].[USP_SPR_SPAREPART_FETCH_REPLACEMENT]  
(
	@ITEM VARCHAR(100),
	@SUPP VARCHAR(100),
	@CATG VARCHAR(100)


)       
AS        
BEGIN       
	SELECT REPLACE_ID_ITEM FROM TBL_SPR_REPLACEMENT WHERE THIS_ID_ITEM=@ITEM and THIS_SUPP_CURRENTNO=@SUPP AND THIS_ID_ITEM_CATG = @CATG
	SELECT THIS_ID_ITEM FROM TBL_SPR_REPLACEMENT WHERE REPLACE_ID_ITEM=@ITEM and REPLACE_SUPP_CURRENTNO=@SUPP AND REPLACE_ID_ITEM_CATG = @CATG

END        


