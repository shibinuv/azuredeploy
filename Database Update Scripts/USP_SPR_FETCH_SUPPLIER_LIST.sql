/****** Object:  StoredProcedure [dbo].[USP_SPR_FETCH_SUPPLIER_LIST]    Script Date: 25-08-2021 15:08:45 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPR_FETCH_SUPPLIER_LIST]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_FETCH_SUPPLIER_LIST]    Script Date: 25-08-2021 15:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*************************************** Application: MSG *************************************************************
* Module	: Supplier Import
* File name	: USP_SPR_FETCH_SUPPLIER_LIST.PRC
* Purpose	: To fetch List of suppliers
* Author	: Venkatesh Prasad
* Date		: 03.01.2008
*********************************************************************************************************************/
/*********************************************************************************************************************  
I/P : -- Input Parameters
O/P :-- Output Parameters
Error Code
Description
INT.VerNO :  
********************************************************************************************************************/
--'*********************************************************************************'*********************************
--'* Modified History	:   
--'* S.No 	RFC No/Bug ID			Date	     		Author		Description	
--*#0001#
--'*********************************************************************************'*********************************

CREATE PROCEDURE [dbo].[USP_SPR_FETCH_SUPPLIER_LIST] 

@ID_SEARCH varchar(100)	= NULL
AS

IF (@ID_SEARCH is NULL)
BEGIN 


	    SELECT  ID_SUPPLIER,SUP_Name FROM TBL_MAS_SUPPLIER
		--MODIFIED BY: ASHOK S
		--DATE: 08 APR 09
		--BUG ID: 59, The vehicle groups are not sorted by vehicle group number
		ORDER BY SUP_Name ASC
		--END OF MODIFICATION
	END
else if (@ID_SEARCH is not NULL)
BEGIN
SELECT  ID_SUPPLIER,SUP_Name,SUPP_CURRENTNO,SUP_CITY 
FROM TBL_MAS_SUPPLIER
WHERE ID_SUPPLIER like('%'+ @ID_SEARCH +'%') or SUP_Name like('%'+ @ID_SEARCH +'%') or SUPP_CURRENTNO like('%'+ @ID_SEARCH +'%')
ORDER BY SUP_Name ASC
END

SELECT distinct s.ID_SUPPLIER,CASE WHEN isnull(si.SUPP_LAYOUT_NAME,'')<>'' then s.SUP_Name+'_'+si.SUPP_LAYOUT_NAME ELSE  s.SUP_Name end As 'SUP_Name',s.ID_ORDERTYPE
FROM TBL_SPR_SUPP_IMPORT si 
inner join TBL_MAS_SUPPLIER s on si.ID_SUPPLIER = s.ID_SUPPLIER where si.FLG_DELETE =0



GO
